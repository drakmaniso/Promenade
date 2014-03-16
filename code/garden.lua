garden = Prototype:clone()


---------------------------------------------------------------------------------------------------


local cellSide = 0.5


-- The garden is a flat-topped hexagon.


local gardenRadius = (gridRadius + 0.75) * math.sqrt(3) * cellSide
local gardenHeight = math.sqrt(3.0) * gardenRadius
local gardenWidth = gardenRadius * 2.0

local color = {HSL(120.0, 0.35, 0.35)}

local vertices = 
{
    {
        0.0, 0.0,
        0.0, 0.0,
        unpack(color),
    },
    {
        -0.5*gardenRadius, -0.5*gardenHeight,
        -0.5*gardenRadius, -0.5*gardenHeight,
        unpack(color),
    },
    {
        0.5*gardenRadius, -0.5*gardenHeight,
        0.5*gardenRadius, -0.5*gardenHeight,
        unpack(color),
    },
    {
        gardenRadius, 0.0,
        gardenRadius, 0.0,
        unpack(color),
    },
    {
        0.5*gardenRadius, 0.5*gardenHeight,
        0.5*gardenRadius, 0.5*gardenHeight,
        unpack(color),
    },
    {
        -0.5*gardenRadius, 0.5*gardenHeight,
        -0.5*gardenRadius, 0.5*gardenHeight,
        unpack(color),
    },
    {
        -gardenRadius, 0.0,
        -gardenRadius, 0.0,
        unpack(color),
    },
    {
        -0.5*gardenRadius, -0.5*gardenHeight,
        -0.5*gardenRadius, -0.5*gardenHeight,
        unpack(color),
    },
}

local mesh = love.graphics.newMesh(vertices, nil, "fan")


---------------------------------------------------------------------------------------------------


function garden:initialize()
    self.mouseQ, self.mouseR, self.mouseCorner = {0, 0, 1}
    self.state = "alert"
end


---------------------------------------------------------------------------------------------------


function garden:mousepressed(x, y, button)
    if self.state == "alert" then
        if self.mouseQ then
            self.state = "selected"
            self.originQ, self.originR, self.originCorner = self.mouseQ, self.mouseR, self.mouseCorner
        end
    else
        self.state = "alert"
    end
end


---------------------------------------------------------------------------------------------------


function garden:update(dt, x, y)
    if self.state == "alert" then
        self.mouseQ, self.mouseR, self.mouseCorner = false, false, false
        local q, r, corner = grid:normalizeCorner(grid:pixelToCorner(x, y))
        local ox, oy = grid:cellToPixel(q, r)
        local dx, dy = ox-x, oy-y
        local d2 = dx*dx + dy*dy
        local distanceToCenter = grid:distance(0, 0, q, r)
        if distanceToCenter < gardenRadius then
            self.mouseQ, self.mouseR, self.mouseCorner = q, r, corner
        end
    elseif self.state == "selected" or self.state == "directed" then
        local ox, oy = grid:cornerToPixel(self.originQ, self.originR, self.originCorner)
        local dx, dy = ox-x, oy-y
        local d2 = dx*dx + dy*dy
        if 0.1*cellRadius < d2 and d2 < 3.0*cellRadius then
            self.state = "directed"
            local angle = math.atan2(dy, dx)
            self.middleQ, self.middleR, self.middleCorner = grid:neighborCorner(self.originQ, self.originR, self.originCorner, angle)
            self.destinationQ, self.destinationR, self.destinationCorner = grid:neighborCorner(self.middleQ, self.middleR, self.middleCorner, angle)
        else
            self.state = "selected"
        end
    end
end


---------------------------------------------------------------------------------------------------


function garden:drawCell(q, r)
    local x, y = grid:cellToPixel(q, r)
--    local l = 0.40
--    if (math.floor(q%3)+2*math.floor(r%3))%3 == 0 then
--        l = 0.40
--    elseif (math.floor(q%3)+2*math.floor(r%3))%3 == 1 then
--        l = 0.44
--    else
--        l = 0.48
--    end
--    love.graphics.setColor(HSL(120.0, 0.35, l))
--    love.graphics.arc("fill", x, y, cellSide * 1.0, -math.pi/2, 2.9999*math.pi/2, 6)
    love.graphics.circle("fill", x, y, cellSide * 0.75, 32)
end


function garden:drawCorner(q, r, c)
    local x, y = grid:cornerToPixel(q, r, c)
    love.graphics.circle("fill", x, y, cellSide * 0.20, 32)
end


function garden:draw()
    love.graphics.draw(mesh, 0.0, 0.0)
    --love.graphics.setColor(HSL(120.0, 0.35, 0.35))
    --love.graphics.circle("fill", 0.0, 0.0, gardenRadius, 128)
    
    love.graphics.setColor(HSL(120.0, 0.35, 0.40))
    self:drawCell(0, 0)
    for radius = 1, gridRadius do
        for i = 0, radius-1 do
            self:drawCell(i, -radius)
            self:drawCell(radius, -radius + i)
            self:drawCell(radius - i, i)
            self:drawCell(-i, radius)
            self:drawCell(-radius, radius-i)
            self:drawCell(-radius + i, -i)
        end
    end
    
    if self.state == "alert" and self.mouseQ then
        love.graphics.setColor(HSL(120.0, 0.35, 0.30))
        self:drawCorner(self.mouseQ, self.mouseR, self.mouseCorner)
    elseif self.state == "selected" then
        love.graphics.setColor(HSL(120.0, 0.35, 0.20))
        self:drawCorner(self.originQ, self.originR, self.originCorner)
    elseif self.state == "directed" then
        love.graphics.setColor(HSL(120.0, 0.35, 0.20))
        local x1, y1 = grid:cornerToPixel(self.originQ, self.originR, self.originCorner)
        local x2, y2 = grid:cornerToPixel(self.middleQ, self.middleR, self.middleCorner)
        local x3, y3 = grid:cornerToPixel(self.destinationQ, self.destinationR, self.destinationCorner)
        love.graphics.setLineWidth(0.2)
        love.graphics.setLineJoin("miter")
        love.graphics.line(x1, y1, x2, y2, x3, y3)
        self:drawCorner(self.originQ, self.originR, self.originCorner)
        self:drawCorner(self.destinationQ, self.destinationR, self.destinationCorner)
    end
end


---------------------------------------------------------------------------------------------------
-- Copyright (c) 2014 - Laurent Moussault <moussault.laurent@gmail.com>