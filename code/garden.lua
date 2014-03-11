garden = {}


---------------------------------------------------------------------------------------------------


local cellSide = 0.5


-- The garden is a flat-topped hexagon.


local gardenSide = (gridSize - 0.25) * math.sqrt(3) * cellSide
local gardenHeight = math.sqrt(3.0) * gardenSide
local gardenWidth = gardenSide * 2.0

local color = {HSL(120.0, 0.35, 0.35)}

local vertices = 
{
    {
        0.0, 0.0,
        0.0, 0.0,
        unpack(color),
    },
    {
        -0.5*gardenSide, -0.5*gardenHeight,
        -0.5*gardenSide, -0.5*gardenHeight,
        unpack(color),
    },
    {
        0.5*gardenSide, -0.5*gardenHeight,
        0.5*gardenSide, -0.5*gardenHeight,
        unpack(color),
    },
    {
        gardenSide, 0.0,
        gardenSide, 0.0,
        unpack(color),
    },
    {
        0.5*gardenSide, 0.5*gardenHeight,
        0.5*gardenSide, 0.5*gardenHeight,
        unpack(color),
    },
    {
        -0.5*gardenSide, 0.5*gardenHeight,
        -0.5*gardenSide, 0.5*gardenHeight,
        unpack(color),
    },
    {
        -gardenSide, 0.0,
        -gardenSide, 0.0,
        unpack(color),
    },
    {
        -0.5*gardenSide, -0.5*gardenHeight,
        -0.5*gardenSide, -0.5*gardenHeight,
        unpack(color),
    },
}

local mesh = love.graphics.newMesh(vertices, nil, "fan")


---------------------------------------------------------------------------------------------------


function garden:initialize()
    self.grid = PointyHexGrid:new(0.5)
    self.highlightedCell = {0, 0}
end


---------------------------------------------------------------------------------------------------


function garden:update(dt, x, y)
    self.highlightedCell = {self.grid:pixelToCell(x, y)}
    self.highlightedCorner = {self.grid:pixelToCorner(x, y)}
end


---------------------------------------------------------------------------------------------------


function garden:drawCell(q, r)
    local x, y = self.grid:cellToPixel(q, r)
    if q == self.highlightedCell[1] and r == self.highlightedCell[2] then
        love.graphics.setColor(HSL(120.0, 0.35, 0.60))
    else
        love.graphics.setColor(HSL(120.0, 0.35, 0.40))
    end
    love.graphics.circle("fill", x, y, cellSide * 0.7, 32)
end


function garden:drawCorner(q, r, c)
    local x, y = self.grid:cornerToPixel(q, r, c)
--    if q == self.highlightedCell[1] and r == self.highlightedCell[2] then
--        love.graphics.setColor(HSL(120.0, 0.35, 0.60))
--    else
--        love.graphics.setColor(HSL(120.0, 0.35, 0.40))
--    end
    love.graphics.setColor(HSL(120.0, 0.35, 0.20))
    love.graphics.circle("fill", x, y, cellSide * 0.2, 32)
end


function garden:draw()
    love.graphics.draw(mesh, 0.0, 0.0)
    
    self:drawCell(0, 0)
    for radius = 1, gridSize-1 do
        for i = 0, radius-1 do
            self:drawCell(i, -radius)
            self:drawCell(radius, -radius + i)
            self:drawCell(radius - i, i)
            self:drawCell(-i, radius)
            self:drawCell(-radius, radius-i)
            self:drawCell(-radius + i, -i)
        end
    end
    
    self:drawCorner(unpack(self.highlightedCorner))
end


---------------------------------------------------------------------------------------------------
-- Copyright (c) 2014 - Laurent Moussault <moussault.laurent@gmail.com>