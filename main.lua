require "lib/strict"

require "code/globals"

require "code/garden"

require "code/inGame"


---------------------------------------------------------------------------------------------------


local translationX, translationY, scale


---------------------------------------------------------------------------------------------------


function love.load()
    love.graphics.setBackgroundColor(222, 222, 222)
    
    love.resize(love.window.getWidth(), love.window.getHeight())
    
    state = inGame
    state:enter()
end


---------------------------------------------------------------------------------------------------


function love.resize(width, height)
    translationX = width / 2
    translationY = height / 2
    viewHeight = 6.0
    scale = height / (2.0*viewHeight)
    viewWidth = (width / scale) / 2.0
end


---------------------------------------------------------------------------------------------------


function love.keypressed(key)
    if key == "f11" then
        love.window.setFullscreen(not love.window.getFullscreen())
    elseif key == "escape" then
        love.event.push("quit")
    end
    state:keypressed(key)
end


---------------------------------------------------------------------------------------------------


function love.draw()
    love.graphics.translate(translationX, translationY)
    love.graphics.scale(scale)
    state:draw()
end


---------------------------------------------------------------------------------------------------
-- Copyright (c) 2014 - Laurent Moussault <moussault.laurent@gmail.com>