
function gradient(color, to_color, min, max, value)
    local function color2dec (c)
        return tonumber(c:sub(2,3),16), tonumber(c:sub(4,5),16), tonumber(c:sub(6,7),16)
    end

    local factor = 0
    if (value >= max) then
        factor = 1
    elseif (value > min) then
        factor = (value - min) / (max - min)
    end

    local red, green, blue = color2dec(color)
    local to_red, to_green, to_blue = color2dec(to_color)

    red = red + (factor * (to_red - red))
    green = green + (factor * (to_green - green))
    blue = blue + (factor * (to_blue - blue))

    return string.format("#%02x%02x%02x", red, green, blue)
end
