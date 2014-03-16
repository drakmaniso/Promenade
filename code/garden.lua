garden = Prototype:clone()


---------------------------------------------------------------------------------------------------


local cellSide = 0.5


-- The garden is a flat-topped hexagon.


local gardenRadius = (gridRadius + 0.75) * math.sqrt(3) * cellSide
local gardenHeight = math.sqrt(3.0) * gardenRadius
local gardenWidth = gardenRadius * 2.0

local color = {HSL(120.0, 0.35, 0.35)}

local vertices = 
{
    {
        0.0, 0.0,
        0.0, 0.0,
        unpack(color),
    },
    {
        -0.5*gardenRadius, -0.5*gardenHeight,
        -0.5*gardenRadius, -0.5*gardenHeight,
        unpack(color),
    },
    {
        0.5*gardenRadius, -0.5*gardenHeight,
        0.5*gardenRadius, -0.5*gardenHeight,
        unpack(color),
    },
    {
        gardenRadius, 0.0,
        gardenRadius, 0.0,
        unpack(color),
    },
    {
        0.5*gardenRadius, 0.5*gardenHeight,
        0.5*gardenRadius, 0.5*gardenHeight,
        unpack(color),
    },
    {
        -0.5*gardenRadius, 0.5*gardenHeight,
        -0.5*gardenRadius, 0.5*gardenHeight,
        unpack(color),
    },
    {
        -gardenRadius, 0.0,
        -gardenRadius, 0.0,
        unpack(color),
    },
    {
        -0.5*gardenRadius, -0.5*gardenHeight,
        -0.5*gardenRadius, -0.5*gardenHeight,
        unpack(color),
    },
}

local mesh = love.graphics.newMesh(vertices, nil, "fan")


---------------------------------------------------------------------------------------------------


function garden:initialize()
    self.mouseQ, self.mouseR, self.mouseCorner = {0, 0, 1}
end


---------------------------------------------------------------------------------------------------


function garden:mousepressed(x, y, button)
    if self.mouseQ then
    end
end


---------------------------------------------------------------------------------------------------


function garden:update(dt, x, y)
    self.mouseQ, self.mouseR, self.mouseCorner = false, false, false
    local q, r, corner = grid:normalizeCorner(grid:pixelToCorner(x, y))
    local ox, oy = grid:cornerToPixel(q, r, corner)
    local dx, dy = ox-x, oy-y
    local d2 = dx*dx + dy*dy
    local distanceToCenter = grid:distance(0, 0, q, r)
    if 
        d2 < 0.15*0.15
        and distanceToCenter < gardenRadius
        and not (distanceToCenter >= gardenRadius-1 and r <=0 and corner == 1)
        and not (distanceToCenter >= gardenRadius-1 and r >=0 and corner == 4)
    then
        self.mouseQ, self.mouseR, self.mouseCorner = q, r, corner
    end
end


---------------------------------------------------------------------------------------------------


function garden:drawCell(q, r)
    local x, y = grid:cellToPixel(q, r)
--    local l = 0.40
--    if (math.floor(q%3)+2*math.floor(r%3))%3 == 0 then
--        l = 0.40
--    elseif (math.floor(q%3)+2*math.floor(r%3))%3 == 1 then
--        l = 0.44
--    else
--        l = 0.48
--    end
--    love.graphics.setColor(HSL(120.0, 0.35, l))
--    love.graphics.arc("fill", x, y, cellSide * 1.0, -math.pi/2, 2.9999*math.pi/2, 6)
    love.graphics.circle("fill", x, y, cellSide * 0.75, 32)
end


function garden:drawCorner(q, r, corner)
    local x, y = grid:cornerToPixel(q, r, corner)
    local x1, y1, x2, y2, x3, y3
    if corner == 1 then
        x1, y1 = grid:cornerToPixel(q, r-1, 2)
        x2, y2 = grid:cornerToPixel(q, r, 2)
        x3, y3 = grid:cornerToPixel(q, r, 6)
    elseif corner == 4 then
        x1, y1 = grid:cornerToPixel(q, r, 3)
        x2, y2 = grid:cornerToPixel(q, r+1, 5)
        x3, y3 = grid:cornerToPixel(q, r, 5)
    end
    local width = 0.05
    love.graphics.setLineWidth(width)
    love.graphics.circle("fill", x1, y1, cellSide * width, 32)
    love.graphics.line(x, y, x1, y1)
    love.graphics.circle("fill", x2, y2, cellSide * width, 32)
    love.graphics.line(x, y, x2, y2)
    love.graphics.circle("fill", x3, y3, cellSide * width, 32)
    love.graphics.line(x, y, x3, y3)
end


function garden:draw()
    love.graphics.draw(mesh, 0.0, 0.0)
    --love.graphics.setColor(HSL(120.0, 0.35, 0.35))
    --love.graphics.circle("fill", 0.0, 0.0, gardenRadius, 128)
    
    love.graphics.setColor(HSL(120.0, 0.35, 0.40))
    self:drawCell(0, 0)
    for radius = 1, gridRadius do
        for i = 0, radius-1 do
            self:drawCell(i, -radius)
            self:drawCell(radius, -radius + i)
            self:drawCell(radius - i, i)
            self:drawCell(-i, radius)
            self:drawCell(-radius, radius-i)
            self:drawCell(-radius + i, -i)
        end
    end
    
    if self.mouseQ then
        love.graphics.setColor(HSL(120.0, 0.35, 0.25))
        self:drawCorner(self.mouseQ, self.mouseR, self.mouseCorner)
    end
end


---------------------------------------------------------------------------------------------------
-- Copyright (c) 2014 - Laurent Moussault <moussault.laurent@gmail.com>
