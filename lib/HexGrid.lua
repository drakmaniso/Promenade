require "lib/Prototype"

PointyHexGrid = Prototype:clone() -- aka Horizontal Hexagonal Grid

FlatHexGrid = Prototype:clone() -- aka Vertical Hexagonal Grid


---------------------------------------------------------------------------------------------------


local pi = math.pi


---------------------------------------------------------------------------------------------------


local sqrt3 = math.sqrt(3.0)


---------------------------------------------------------------------------------------------------


function PointyHexGrid:make(radius)
    self.radius = radius
    self.width = sqrt3 * radius
    self.height = 2.0 * radius
end


function FlatHexGrid:make(radius)
    self.radius = radius
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
    return self.radius * sqrt3 * (q + r / 2.0),
           self.radius * 3.0/2.0 * r
end


---------------------------------------------------------------------------------------------------


function PointyHexGrid:pixelToCell(x, y)
    local q = (1.0/3.0*sqrt3 * x - 1.0/3.0 * y) / self.radius
    local r = 2.0/3.0 * y / self.radius
    --return math.floor(q+0.5), math.floor(r+0.5)
    return self:round(q, r)
end


---------------------------------------------------------------------------------------------------


function PointyHexGrid:cornerToPixel(q, r, c)
    local x, y = self:cellToPixel(q, r)
    if     c == 1 then return  x+0.0           , y-self.radius
    elseif c == 2 then return  x+self.width/2.0, y-self.radius/2.0
    elseif c == 3 then return  x+self.width/2.0, y+self.radius/2.0
    elseif c == 4 then return  x+0.0           , y+self.radius
    elseif c == 5 then return  x-self.width/2.0, y+self.radius/2.0
    elseif c == 6 then return  x-self.width/2.0, y-self.radius/2.0
    end
end


---------------------------------------------------------------------------------------------------


function PointyHexGrid:pixelToCorner(x, y)
    local q, r = self:pixelToCell(x, y)
    local ox, oy = self:cellToPixel(q, r)
    local dx, dy = x-ox, y-oy
    local angle = math.atan2(dy, dx)
    local corner = math.floor(2.0 + angle/(pi/3.0)) % 6 + 1
    return q, r, corner
end


---------------------------------------------------------------------------------------------------


function PointyHexGrid:normalizeCorner(q, r, corner)
    if     corner == 2 then return q+1, r-1, 4
    elseif corner == 3 then return q, r+1, 1
    elseif corner == 5 then return q-1, r+1, 1
    elseif corner == 6 then return q, r-1, 4
    else                    return q, r, corner
    end
end


---------------------------------------------------------------------------------------------------


function PointyHexGrid:distance(q1, r1, q2, r2)
    return (math.abs(q1 - q2) + math.abs(r1 - r2) + math.abs(q1 + r1 - q2 - r2)) / 2.0
end


---------------------------------------------------------------------------------------------------


function PointyHexGrid:neighborCorner(q, r, corner, angle)
    
    if corner == 1 then
        
        angle = (angle - pi/6.0) % (2.0*pi)
        if angle < 2.0*pi/3.0 then
            return q+1, r-1, 6
        elseif angle < 4.0*pi/3.0 then
            return q, r, 2
        else
            return q, r, 6
        end
        
    elseif corner == 2 then
        
        angle = (angle + pi/6.0) % (2.0*pi)
        if angle < 2.0*pi/3.0 then
            return q, r, 1
        elseif angle < 4.0*pi/3.0 then
            return q+1, r, 1
        else
            return q, r, 3
        end
    
    elseif corner == 3 then
        
        angle = (angle - pi/6.0) % (2.0*pi)
        if angle < 2.0*pi/3.0 then
            return q, r, 2
        elseif angle < 4.0*pi/3.0 then
            return q+1, r, 4
        else
            return q, r, 4
        end
        
    elseif corner == 4 then
        
        angle = (angle + pi/6.0) % (2.0*pi)
        if angle < 2.0*pi/3.0 then
            return q, r, 5
        elseif angle < 4.0*pi/3.0 then
            return q, r, 3
        else
            return q, r+1, 5
        end
    
    elseif corner == 5 then
        
        angle = (angle - pi/6.0) % (2.0*pi)
        if angle < 2.0*pi/3.0 then
            return q, r, 6
        elseif angle < 4.0*pi/3.0 then
            return q, r, 4
        else
            return q-1, r, 4
        end
        
    elseif corner == 6 then
        
        angle = (angle + pi/6.0) % (2.0*pi)
        if angle < 2.0*pi/3.0 then
            return q, r-1, 5
        elseif angle < 4.0*pi/3.0 then
            return q, r, 1
        else
            return q, r, 5
        end
        
    else
        return false, false, false
    end
end


---------------------------------------------------------------------------------------------------
-- Copyright (c) 2014 - Laurent Moussault <moussault.laurent@gmail.com>
