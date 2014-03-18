moves = Prototype:clone()


---------------------------------------------------------------------------------------------------



local function toIndex(q, r)
    return (q+gridRadius)*(2*gridRadius+1) + r+gridRadius
end


---------------------------------------------------------------------------------------------------


function moves:make()
    self.set = {}
    for q = -gridRadius, gridRadius do
        for r = -gridRadius, gridRadius do
            self.set[toIndex(q, r)] = {}
            local distanceToCenter = grid:distance(0, 0, q, r)
            local x, y, z = grid:cellToCube(q, r)
            if distanceToCenter <= gridRadius then
                if x < gridRadius and y > -gridRadius then self:add(q, r, q+1, r) end
                if y > -gridRadius and z < gridRadius then self:add(q, r, q, r+1) end
                if z < gridRadius and x > -gridRadius then self:add(q, r, q-1, r+1) end
                if x > -gridRadius and y < gridRadius then self:add(q, r, q-1, r) end
                if y < gridRadius and z > -gridRadius then self:add(q, r, q, r-1) end
                if z > -gridRadius and x < gridRadius then self:add(q, r, q+1, r-1) end
            end
        end
    end
end


---------------------------------------------------------------------------------------------------


function moves:add(originQ, originR, destinationQ, destinationR)
    local origin = self.set[toIndex(originQ, originR)]
    origin[#origin+1] = {destinationQ, destinationR}
end


---------------------------------------------------------------------------------------------------


function moves:contain(originQ, originR, destinationQ, destinationR)
    local origin = self.set[toIndex(originQ, originR)]
    for _,v in ipairs(origin) do
        if v[1] == destinationQ and v[2] == destinationR then
            return true
        end
    end
    return false
end


---------------------------------------------------------------------------------------------------


function moves:remove(originQ, originR, destinationQ, destinationR)
    local origin = self.set[toIndex(originQ, originR)]
    for i,v in ipairs(origin) do
        if v[1] == destinationQ and v[2] == destinationR then
            table.remove(origin, i)
        end
    end
    local destination = self.set[toIndex(destinationQ, destinationR)]
    for i,v in ipairs(destination) do
        if v[1] == originQ and v[2] == originR then
            table.remove(destination, i)
        end
    end
end



---------------------------------------------------------------------------------------------------
-- Copyright (c) 2014 - Laurent Moussault <moussault.laurent@gmail.com>
