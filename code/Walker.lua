Walker = Prototype:clone()


---------------------------------------------------------------------------------------------------
    
    
function Walker:make()    
    local side = math.random(1, 6)
    if     side == 1 then self.q = gridRadius/2; self.r = -gridRadius
    elseif side == 2 then self.q = gridRadius; self.r = -gridRadius/2
    elseif side == 3 then self.q = gridRadius/2; self.r = gridRadius/2
    elseif side == 4 then self.q = -gridRadius/2; self.r = gridRadius
    elseif side == 5 then self.q = -gridRadius; self.r = gridRadius/2
    elseif side == 6 then self.q = -gridRadius/2; self.r = -gridRadius/2
    end
end


---------------------------------------------------------------------------------------------------


function Walker:mousepressed(x, y, button)
    if self.destinationQ then
        self.q, self.r = self.destinationQ, self.destinationR
        self.destinationQ, self.destinationR = nil, nil
    end
end


---------------------------------------------------------------------------------------------------


function Walker:update(dt, x, y)
    self.destinationQ, self.destinationR = nil
    local mouseQ, mouseR = grid:pixelToCell(x, y)
    local ox, oy = grid:cellToPixel(mouseQ, mouseR)
    local dx, dy = ox-x, oy-y
    if 
        moves:contain(self.q, self.r, mouseQ, mouseR)
        and dx*dx + dy*dy < 0.25*0.25
    then
        self.destinationQ, self.destinationR = mouseQ, mouseR
    end
end


---------------------------------------------------------------------------------------------------


function Walker:draw()
    local x, y = grid:cellToPixel(self.q, self.r)
    
    if self.destinationQ then
        local x2, y2 = grid:cellToPixel(self.destinationQ, self.destinationR)
        love.graphics.setColor(HSL(120.0, 0.25, 0.75))
        love.graphics.setLineWidth(0.05)
        love.graphics.line(x, y, x2, y2)
    end
    
    love.graphics.setColor(HSL(270, 0.50, 0.30))
    love.graphics.circle("fill", x, y, 0.25, 32)
end


---------------------------------------------------------------------------------------------------
-- Copyright (c) 2014 - Laurent Moussault <moussault.laurent@gmail.com>
