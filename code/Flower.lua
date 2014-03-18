Flower = Prototype:clone()


---------------------------------------------------------------------------------------------------


function Flower:make(q, r, corner)
    self.q, self.r, self.corner = q, r, corner
    beds:remove(q, r, corner)
    if corner == 1 then
        beds:remove(q, r-1, 2)
        beds:remove(q, r, 2)
        beds:remove(q, r, 6)
        moves:remove(q, r, q, r-1)
        moves:remove(q, r, q+1, r-1)
        moves:remove(q, r-1, q+1, r-1)
    elseif corner == 4 then
        beds:remove(q, r, 3)
        beds:remove(q, r+1, 5)
        beds:remove(q, r, 5)
        moves:remove(q, r, q, r+1)
        moves:remove(q, r, q-1, r+1)
        moves:remove(q, r+1, q-1, r+1)
    end
end


---------------------------------------------------------------------------------------------------


function Flower:drawAt(q, r, corner, width)
    local x, y = grid:cornerToPixel(q, r, corner)
    local x1, y1, x2, y2, x3, y3
    if corner == 1 then
        x1, y1 = grid:cornerToPixel(q, r-1, 2)
        x2, y2 = grid:cornerToPixel(q, r, 2)
        x3, y3 = grid:cornerToPixel(q, r, 6)
    elseif corner == 4 then
        x1, y1 = grid:cornerToPixel(q, r, 3)
        x2, y2 = grid:cornerToPixel(q, r+1, 5)
        x3, y3 = grid:cornerToPixel(q, r, 5)
    end
    love.graphics.setLineWidth(width)
    love.graphics.circle("fill", x1, y1, cellRadius * width, 32)
    love.graphics.line(x, y, x1, y1)
    love.graphics.circle("fill", x2, y2, cellRadius * width, 32)
    love.graphics.line(x, y, x2, y2)
    love.graphics.circle("fill", x3, y3, cellRadius * width, 32)
    love.graphics.line(x, y, x3, y3)
end


---------------------------------------------------------------------------------------------------


function Flower:draw()
    love.graphics.setColor(HSL(120.0, 0.35, 0.20))
    self:drawAt(self.q, self.r, self.corner, 0.20)
end


---------------------------------------------------------------------------------------------------
-- Copyright (c) 2014 - Laurent Moussault <moussault.laurent@gmail.com>
