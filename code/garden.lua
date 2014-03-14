garden = {}


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


function garden:update(dt, x, y)
    self.mouseQ, self.mouseR, self.mouseCorner = false, false, false
    local q, r, corner = grid:pixelToCorner(x, y)
    local ox, oy = grid:cellToPixel(q, r)
    local dx, dy = ox-x, oy-y
    local d2 = dx*dx + dy*dy
    local distanceToCenter = grid:distance(0, 0, q, r)
    if distanceToCenter < gardenRadius then
        if d2 < 0.7*cellSide*0.7*cellSide then
            self.mouseQ, self.mouseR = q, r
        else
            self.mouseQ, self.mouseR, self.mouseCorner = q, r, corner
        end
    end
end


---------------------------------------------------------------------------------------------------


function garden:drawCell(q, r)
    local x, y = grid:cellToPixel(q, r)
    love.graphics.circle("fill", x, y, cellSide * 0.7, 32)
end


function garden:drawCorner(q, r, c)
    local x, y = grid:cornerToPixel(q, r, c)
    love.graphics.circle("fill", x, y, cellSide * 0.2, 32)
end


function garden:draw()
    love.graphics.draw(mesh, 0.0, 0.0)
    
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
    
    if self.mouseCorner then
        love.graphics.setColor(HSL(120.0, 0.35, 0.30))
        self:drawCorner(self.mouseQ, self.mouseR, self.mouseCorner)
    elseif self.mouseQ then
--        love.graphics.setColor(HSL(120.0, 0.35, 0.50))
--        self:drawCell(self.mouseQ, self.mouseR)
    end
end


---------------------------------------------------------------------------------------------------
-- Copyright (c) 2014 - Laurent Moussault <moussault.laurent@gmail.com>