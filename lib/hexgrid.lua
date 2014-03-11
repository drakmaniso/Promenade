require "lib/instantiate"

PointyHexGrid = {} -- aka Horizontal Hexagonal Grid

FlatHexGrid = {} -- aka Vertical Hexagonal Grid


---------------------------------------------------------------------------------------------------


local sqrt3 = math.sqrt(3.0)


---------------------------------------------------------------------------------------------------


PointyHexGrid.new = instantiate

function PointyHexGrid:reset(side)
    self.side = side
end


FlatHexGrid.new = instantiate

function FlatHexGrid:reset(side)
    self.side = side
end


---------------------------------------------------------------------------------------------------


function PointyHexGrid:cubeToCell(x, y, z)
    return x, z
end


---------------------------------------------------------------------------------------------------


function PointyHexGrid:cellToCube(q, r)
    return q, -q-r, r
end


---------------------------------------------------------------------------------------------------


function PointyHexGrid:round(q, r)
    local x, y, z = self:cellToCube(q, r)
    local ix, iy, iz = math.floor(x+0.5), math.floor(y+0.5), math.floor(z+0.5)
    local dx, dy, dz = math.abs(ix-x), math.abs(iy-y), math.abs(iz-z)
    
    if dx > dy and dx > dz then
        ix = -iy-iz
    elseif dz > dy then
        iz = -ix-iy
    end
    
    return ix, iz
end


function PointyHexGrid:roundCube(x, y, z)
    local ix, iy, iz = math.floor(x+0.5), math.floor(y+0.5), math.floor(z+0.5)
    local dx, dy, dz = math.abs(ix-x), math.abs(iy-y), math.abs(iz-z)
    
    if dx > dy and dx > dz then
        ix = -iy-iz
    elseif dy > dz then
        iy = -ix-iz
    else
        iz = -ix-iy
    end
    
    return ix, iy, iz
end


---------------------------------------------------------------------------------------------------


function PointyHexGrid:cellToPixel(q, r)
    return self.side * sqrt3 * (q + r / 2.0),
           self.side * 3.0/2.0 * r
end


---------------------------------------------------------------------------------------------------


function PointyHexGrid:pixelToCell(x, y)
    local q = (1.0/3.0*sqrt3 * x - 1.0/3.0 * y) / self.side
    local r = 2.0/3.0 * y / self.side
    --return math.floor(q+0.5), math.floor(r+0.5)
    return self:round(q, r)
end


---------------------------------------------------------------------------------------------------
-- Copyright (c) 2014 - Laurent Moussault <moussault.laurent@gmail.com>