inGame = {}


---------------------------------------------------------------------------------------------------


function inGame:enter()
end


---------------------------------------------------------------------------------------------------


function inGame:leave()
end


---------------------------------------------------------------------------------------------------


function inGame:keypressed(key)
end


---------------------------------------------------------------------------------------------------


function inGame:update(dt, x, y)
    garden:update(dt, x, y)
end


---------------------------------------------------------------------------------------------------


function inGame:draw()
    garden:draw()
end


---------------------------------------------------------------------------------------------------
-- Copyright (c) 2014 - Laurent Moussault <moussault.laurent@gmail.com>