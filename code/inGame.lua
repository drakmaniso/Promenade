inGame = Prototype:clone()


---------------------------------------------------------------------------------------------------


function inGame:enter()
    beds:make()
    walkers[1] = Walker:clone()
end


---------------------------------------------------------------------------------------------------


function inGame:leave()
end


---------------------------------------------------------------------------------------------------


function inGame:keypressed(key)
end


---------------------------------------------------------------------------------------------------


function inGame:mousepressed(x, y, button)
    garden:mousepressed(x, y, button)
    walkers[1]:mousepressed(x, y, button)
end


---------------------------------------------------------------------------------------------------


function inGame:update(dt, x, y)
    garden:update(dt, x, y)
    walkers[1]:update(dt, x, y)
end


---------------------------------------------------------------------------------------------------


function inGame:draw()
    garden:draw()
    walkers[1]:draw()
    for _,flower in ipairs(flowers) do
        flower:draw()
    end
end


---------------------------------------------------------------------------------------------------
-- Copyright (c) 2014 - Laurent Moussault <moussault.laurent@gmail.com>
