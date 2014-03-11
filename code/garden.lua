garden = {}


---------------------------------------------------------------------------------------------------


-- The garden is a flat-topped hexagon.

local size = 5.0
local width = size * 2.0
local height = math.sqrt(3.0) * size

local color = {64, 128, 64}

local vertices = 
{
    {
        0.0, 0.0,
        0.0, 0.0,
        unpack(color),
    },
    {
        -0.5*size, -0.5*height,
        -0.5*size, -0.5*height,
        unpack(color),
    },
    {
        0.5*size, -0.5*height,
        0.5*size, -0.5*height,
        unpack(color),
    },
    {
        size, 0.0,
        size, 0.0,
        unpack(color),
    },
    {
        0.5*size, 0.5*height,
        0.5*size, 0.5*height,
        unpack(color),
    },
    {
        -0.5*size, 0.5*height,
        -0.5*size, 0.5*height,
        unpack(color),
    },
    {
        -size, 0.0,
        -size, 0.0,
        unpack(color),
    },
    {
        -0.5*size, -0.5*height,
        -0.5*size, -0.5*height,
        unpack(color),
    },
}

local mesh = love.graphics.newMesh(vertices, nil, "fan")


---------------------------------------------------------------------------------------------------


function garden:draw()
    love.graphics.draw(mesh, 0, 0)
end


---------------------------------------------------------------------------------------------------
-- Copyright (c) 2014 - Laurent Moussault <moussault.laurent@gmail.com>