beds = Prototype:clone()


---------------------------------------------------------------------------------------------------


function beds:make()
    self.set = {}
    for q = -gridRadius, gridRadius do
        self.set[gridRadius+q] = {}
        for r = -gridRadius, gridRadius do
            local distanceToCenter = grid:distance(0, 0, q, r)
            self.set[gridRadius+q][gridRadius+r] = {}
            self.set[gridRadius+q][gridRadius+r][1] = distanceToCenter <= gridRadius and not (distanceToCenter > gridRadius-1 and r <=0)
            self.set[gridRadius+q][gridRadius+r][4] = distanceToCenter <= gridRadius and not (distanceToCenter > gridRadius-1 and r >=0)
        end
    end
end


---------------------------------------------------------------------------------------------------


function beds:isAvalaible(q, r, corner)
    q, r, corner = grid:normalizeCorner(q, r, corner)
    return self.set[gridRadius+q] and self.set[gridRadius+q][gridRadius+r] and self.set[gridRadius+q][gridRadius+r][corner]
end


---------------------------------------------------------------------------------------------------


function beds:remove(q, r, corner)
    q, r, corner = grid:normalizeCorner(q, r, corner)
    if self.set[gridRadius+q] and self.set[gridRadius+q][gridRadius+r] then
        self.set[gridRadius+q][gridRadius+r][corner] = false
    end
end


---------------------------------------------------------------------------------------------------
-- Copyright (c) 2014 - Laurent Moussault <moussault.laurent@gmail.com>
