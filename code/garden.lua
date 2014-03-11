garden = {}


---------------------------------------------------------------------------------------------------


-- The garden is a flat-topped hexagon.

local cellSize = 0.5
local cellHeight = cellSize * 2.0
local cellWidth = math.sqrt(3.0) * cellSize

local gardenSize = (gridSize - 0.25) * cellWidth
local gardenHeight = math.sqrt(3.0) * gardenSize
local gardenWidth = gardenSize * 2.0

local color = {HSL(120.0, 0.35, 0.35)}

local vertices = 
{
    {
        0.0, 0.0,
        0.0, 0.0,
        unpack(color),
    },
    {
        -0.5*gardenSize, -0.5*gardenHeight,
        -0.5*gardenSize, -0.5*gardenHeight,
        unpack(color),
    },
    {
        0.5*gardenSize, -0.5*gardenHeight,
        0.5*gardenSize, -0.5*gardenHeight,
        unpack(color),
    },
    {
        gardenSize, 0.0,
        gardenSize, 0.0,
        unpack(color),
    },
    {
        0.5*gardenSize, 0.5*gardenHeight,
        0.5*gardenSize, 0.5*gardenHeight,
        unpack(color),
    },
    {
        -0.5*gardenSize, 0.5*gardenHeight,
        -0.5*gardenSize, 0.5*gardenHeight,
        unpack(color),
    },
    {
        -gardenSize, 0.0,
        -gardenSize, 0.0,
        unpack(color),
    },
    {
        -0.5*gardenSize, -0.5*gardenHeight,
        -0.5*gardenSize, -0.5*gardenHeight,
        unpack(color),
    },
}

local mesh = love.graphics.newMesh(vertices, nil, "fan")


---------------------------------------------------------------------------------------------------


local function drawCell(q, r)
    love.graphics.circle(
        "fill", 
        cellSize * math.sqrt(3) * (q + r / 2.0),
        cellSize * 3.0/2.0 * r, 
        cellSize * 0.7, 
        32
    )
end


function garden:draw()
    love.graphics.draw(mesh, 0.0, 0.0)
    
    love.graphics.setColor(HSL(120.0, 0.35, 0.40))
    drawCell(0, 0)
    for radius = 1, gridSize-1 do
        for i = 0, radius-1 do
            drawCell(i, -radius)
            drawCell(radius, -radius + i)
            drawCell(radius - i, i)
            drawCell(-i, radius)
            drawCell(-radius, radius-i)
            drawCell(-radius + i, -i)
        end
    end
end


---------------------------------------------------------------------------------------------------
-- Copyright (c) 2014 - Laurent Moussault <moussault.laurent@gmail.com>