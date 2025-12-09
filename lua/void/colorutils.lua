-- void.nvim - Color utilities
-- Based on hsluv color space for perceptually uniform colors

local hex_chars = "0123456789abcdef"
local epsilon = 0.0088564516
local kappa = 903.2962962
local refY = 1
local refU = 0.19783000664283
local refV = 0.46831999493879
local m = {
  {3.2409699419045, -1.5373831775701, -0.498610760293},
  {-0.96924363628087, 1.8759675015077, 0.041555057407175},
  {0.055630079696993, -0.20397695888897, 1.0569715142429}
}
local minv = {
  {0.41239079926595, 0.35758433938387, 0.18048078840183},
  {0.21263900587151, 0.71516867876775, 0.072192315360733},
  {0.019330818715591, 0.11919477979462, 0.95053215224966}
}

local function get_bounds(l)
  local result = {}
  local sub1 = (((l + 16) ^ 3) / 1560896)
  local sub2
  if (sub1 > epsilon) then
    sub2 = sub1
  else
    sub2 = (l / kappa)
  end
  for i = 1, 3 do
    local m1 = m[i][1]
    local m2 = m[i][2]
    local m3 = m[i][3]
    for t = 0, 1 do
      local top1 = (((284517 * m1) - (94839 * m3)) * sub2)
      local top2 = ((((((838422 * m3) + (769860 * m2)) + (731718 * m1)) * l) * sub2) - ((769860 * t) * l))
      local bottom = ((((632260 * m3) - (126452 * m2)) * sub2) + (126452 * t))
      table.insert(result, {slope = (top1 / bottom), intercept = (top2 / bottom)})
    end
  end
  return result
end

local function length_of_ray_until_intersect(theta, line)
  return (line.intercept / (math.sin(theta) - (line.slope * math.cos(theta))))
end

local function max_safe_chroma_for_lh(l, h)
  local hrad = (((h / 360) * math.pi) * 2)
  local bounds = get_bounds(l)
  local min = 1.7976931348623e+308
  for i = 1, 6 do
    local bound = bounds[i]
    local distance = length_of_ray_until_intersect(hrad, bound)
    if (distance >= 0) then
      min = math.min(min, distance)
    end
  end
  return min
end

local function y_to_l(Y)
  if (Y <= epsilon) then
    return ((Y / refY) * kappa)
  else
    return ((116 * ((Y / refY) ^ 0.33333333333333)) - 16)
  end
end

local function l_to_y(L)
  if (L <= 8) then
    return ((refY * L) / kappa)
  else
    return (refY * (((L + 16) / 116) ^ 3))
  end
end

local function from_linear(c)
  if (c <= 0.0031308) then
    return (12.92 * c)
  else
    return ((1.055 * (c ^ 0.41666666666667)) - 0.055)
  end
end

local function to_linear(c)
  if (c > 0.04045) then
    return (((c + 0.055) / 1.055) ^ 2.4)
  else
    return (c / 12.92)
  end
end

local function dot_product(a, b)
  local sum = 0
  for i = 1, 3 do
    sum = (sum + (a[i] * b[i]))
  end
  return sum
end

local function luv_to_lch(tuple)
  local L = tuple[1]
  local U = tuple[2]
  local V = tuple[3]
  local C = math.sqrt(((U * U) + (V * V)))
  local H
  if (C < 1e-08) then
    H = 0
  else
    H = ((math.atan2(V, U) * 180) / 3.1415926535898)
    if (H < 0) then
      H = (360 + H)
    end
  end
  return {L, C, H}
end

local function lch_to_luv(tuple)
  local L = tuple[1]
  local C = tuple[2]
  local Hrad = (((tuple[3] / 360) * 2) * math.pi)
  return {L, (math.cos(Hrad) * C), (math.sin(Hrad) * C)}
end

local function xyz_to_luv(tuple)
  local X = tuple[1]
  local Y = tuple[2]
  local divider = ((X + (15 * Y)) + (3 * tuple[3]))
  local var_u = (4 * X)
  local var_v = (9 * Y)
  if (divider ~= 0) then
    var_u = (var_u / divider)
    var_v = (var_v / divider)
  else
    var_u = 0
    var_v = 0
  end
  local L = y_to_l(Y)
  if (L == 0) then
    return {0, 0, 0}
  end
  return {L, ((13 * L) * (var_u - refU)), ((13 * L) * (var_v - refV))}
end

local function luv_to_xyz(tuple)
  local L = tuple[1]
  local U = tuple[2]
  local V = tuple[3]
  if (L == 0) then
    return {0, 0, 0}
  end
  local var_u = ((U / (13 * L)) + refU)
  local var_v = ((V / (13 * L)) + refV)
  local Y = l_to_y(L)
  local X = (0 - (((9 * Y) * var_u) / (((var_u - 4) * var_v) - (var_u * var_v))))
  return {X, Y, ((((9 * Y) - ((15 * var_v) * Y)) - (var_v * X)) / (3 * var_v))}
end

local function xyz_to_rgb(tuple)
  return {
    from_linear(dot_product(m[1], tuple)),
    from_linear(dot_product(m[2], tuple)),
    from_linear(dot_product(m[3], tuple))
  }
end

local function rgb_to_xyz(tuple)
  local rgbl = {to_linear(tuple[1]), to_linear(tuple[2]), to_linear(tuple[3])}
  return {
    dot_product(minv[1], rgbl),
    dot_product(minv[2], rgbl),
    dot_product(minv[3], rgbl)
  }
end

local function hex_to_rgb(hex)
  hex = string.lower(hex)
  local ret = {}
  for i = 0, 2 do
    local char1 = string.sub(hex, ((i * 2) + 2), ((i * 2) + 2))
    local char2 = string.sub(hex, ((i * 2) + 3), ((i * 2) + 3))
    local digit1 = (string.find(hex_chars, char1) - 1)
    local digit2 = (string.find(hex_chars, char2) - 1)
    ret[i + 1] = (((digit1 * 16) + digit2) / 255)
  end
  return ret
end

local function rgb_to_hex(tuple)
  local h = "#"
  for i = 1, 3 do
    local c = math.floor(((tuple[i] * 255) + 0.5))
    local digit2 = math.fmod(c, 16)
    local x = ((c - digit2) / 16)
    local digit1 = math.floor(x)
    h = (h .. string.sub(hex_chars, (digit1 + 1), (digit1 + 1)))
    h = (h .. string.sub(hex_chars, (digit2 + 1), (digit2 + 1)))
  end
  return h
end

local function lch_to_hsluv(tuple)
  local L = tuple[1]
  local C = tuple[2]
  local H = tuple[3]
  local max_chroma = max_safe_chroma_for_lh(L, H)
  if (L > 99.9999999) then
    return {H, 0, 100}
  end
  if (L < 1e-08) then
    return {H, 0, 0}
  end
  return {H, ((C / max_chroma) * 100), L}
end

local function hsluv_to_lch(tuple)
  local H = tuple[1]
  local S = tuple[2]
  local L = tuple[3]
  if (L > 99.9999999) then
    return {100, 0, H}
  end
  if (L < 1e-08) then
    return {0, 0, H}
  end
  return {L, ((max_safe_chroma_for_lh(L, H) / 100) * S), H}
end

local function rgb_to_hsluv(tuple)
  return lch_to_hsluv(luv_to_lch(xyz_to_luv(rgb_to_xyz(tuple))))
end

local function hsluv_to_rgb(tuple)
  return xyz_to_rgb(luv_to_xyz(lch_to_luv(hsluv_to_lch(tuple))))
end

local function hex_to_hsluv(s)
  return rgb_to_hsluv(hex_to_rgb(s))
end

local function hsluv_to_hex(tuple)
  return rgb_to_hex(hsluv_to_rgb(tuple))
end

local function linear_tween(start, stop)
  return function(i)
    return (start + (i * (stop - start)))
  end
end

local function radial_tween(x, y)
  local start = math.rad(x)
  local stop = math.rad(y)
  local delta = math.atan2(math.sin((stop - start)), math.cos((stop - start)))
  return function(i)
    return ((360 + math.deg((start + (delta * i)))) % 360)
  end
end

local function blend_hsluv(start, stop, ratio)
  ratio = ratio or 0.5
  local h = radial_tween(start[1], stop[1])
  local s = linear_tween(start[2], stop[2])
  local l = linear_tween(start[3], stop[3])
  return {h(ratio), s(ratio), l(ratio)}
end

local function blend_hex(c1, c2, r)
  return hsluv_to_hex(blend_hsluv(hex_to_hsluv(c1), hex_to_hsluv(c2), r))
end

local function lighten(c, n)
  local l = linear_tween(c[3], 100)
  return {c[1], c[2], l(n)}
end

local function darken(c, n)
  local l = linear_tween(c[3], 0)
  return {c[1], c[2], l(n)}
end

local function lighten_hex(c, n)
  return hsluv_to_hex(lighten(hex_to_hsluv(c), n))
end

local function darken_hex(c, n)
  return hsluv_to_hex(darken(hex_to_hsluv(c), n))
end

return {
  ["blend-hex"] = blend_hex,
  ["lighten-hex"] = lighten_hex,
  ["darken-hex"] = darken_hex,
  hex_to_hsluv = hex_to_hsluv,
  hsluv_to_hex = hsluv_to_hex,
}