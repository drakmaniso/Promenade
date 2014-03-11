---------------------------------------------------------------------------------------------------


function HSL(hue, saturation, lightness, alpha)
    alpha = alpha or 1.0
    if saturation <= 0 then 
        return lightness*255.0, lightness*255.0, lightness*255.0, alpha*255.0
    end
    
    local c = (1.0 - math.abs(2.0 * lightness - 1.0)) * saturation
    hue = hue / 60.0
    local x = (1.0 - math.abs(hue % 2.0 - 1.0)) * c
    
    local r,g,b = 0.0, 0.0, 0.0
    if     hue < 1.0 then r,g,b =   c,   x, 0.0
    elseif hue < 2.0 then r,g,b =   x,   c, 0.0
    elseif hue < 3.0 then r,g,b = 0.0,   c,   x
    elseif hue < 4.0 then r,g,b = 0.0,   x,   c
    elseif hue < 5.0 then r,g,b =   x, 0.0,   c
    else                r,g,b =   c, 0.0,   x
    end 

    local m = lightness - 0.5 * c
    return (r+m)*255.0, (g+m)*255.0, (b+m)*255.0, alpha*255.0
end


---------------------------------------------------------------------------------------------------
-- Copyright (c) 2014 - Laurent Moussault <moussault.laurent@gmail.com>