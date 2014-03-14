Walker = {}


---------------------------------------------------------------------------------------------------


Walker.new = instantiate
    
function Walker:reset()
    self.state = "rest"
    
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
    if self.state == "hovered" then
        self.state = "selected"
    elseif self.state == "selected" then
        if self.destinationQ then
            self.q, self.r = self.destinationQ, self.destinationR
            self.destinationQ, self.destinationR = nil, nil
        end
        self.state = "rest"
    end
end


---------------------------------------------------------------------------------------------------


function Walker:update(dt, x, y)
    if self.state == "selected" then
        self.destinationQ, self.destinationR = nil
        if garden.mouseQ and grid:distance(garden.mouseQ, garden.mouseR, self.q, self.r) == 1 then
            self.destinationQ, self.destinationR = garden.mouseQ, garden.mouseR
        end
    else
        local wx, wy = grid:cellToPixel(self.q, self.r)
        local dx, dy = wx-x, wy-y
        if dx*dx + dy*dy < 0.25*0.25 then
            self.state = "hovered"
        else
            self.state = "rest"
        end
   end
end


---------------------------------------------------------------------------------------------------


function Walker:draw()
    local x, y = grid:cellToPixel(self.q, self.r)
    
    if self.destinationQ then
        local x2, y2 = grid:cellToPixel(self.destinationQ, self.destinationR)
        love.graphics.setColor(0, 0, 0)
        love.graphics.setLineWidth(0.02)
        love.graphics.line(x, y, x2, y2)
    end
    
    if self.state == "hovered" then
        love.graphics.setColor(HSL(270, 0.50, 0.40))
    elseif self.state == "selected" then
        love.graphics.setColor(HSL(270, 0.50, 0.50))
    else
        love.graphics.setColor(HSL(270, 0.50, 0.30))
    end
    love.graphics.circle("fill", x, y, 0.25, 32)
end


---------------------------------------------------------------------------------------------------
-- Copyright (c) 2014 - Laurent Moussault <moussault.laurent@gmail.com>