beds = Prototype:clone()


---------------------------------------------------------------------------------------------------



local function toIndex(q, r, corner)
    return (q+gridRadius)*(2*gridRadius+1)*6 + (r+gridRadius)*6 + corner
end


---------------------------------------------------------------------------------------------------


function beds:make()
    self.set = {}
    for q = -gridRadius, gridRadius do
        for r = -gridRadius, gridRadius do
            local distanceToCenter = grid:distance(0, 0, q, r)
            if distanceToCenter <= gridRadius then
                if not (distanceToCenter > gridRadius-1 and r <=0) then
                    self.set[toIndex(q, r, 1)] = true
                end
                if not (distanceToCenter > gridRadius-1 and r >=0) then
                    self.set[toIndex(q, r, 4)] = true
                end
            end
        end
    end
end


---------------------------------------------------------------------------------------------------


function beds:contain(q, r, corner)
    q, r, corner = grid:normalizeCorner(q, r, corner)
    return self.set[toIndex(q, r, corner)]
end


---------------------------------------------------------------------------------------------------


function beds:remove(q, r, corner)
    q, r, corner = grid:normalizeCorner(q, r, corner)
    self.set[toIndex(q, r, corner)] = nil
end


---------------------------------------------------------------------------------------------------
-- Copyright (c) 2014 - Laurent Moussault <moussault.laurent@gmail.com>
