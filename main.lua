require "ext/lib/strict"
require "lib/hsl"
require "lib/hexgrid"

require "code/globals"

require "code/garden"

require "code/inGame"


---------------------------------------------------------------------------------------------------


local translationX, translationY, scale


---------------------------------------------------------------------------------------------------


function love.load(arg)
    if arg[#arg] == "-debug" then require("mobdebug").start() end    
    
    garden:initialize()
    
    love.graphics.setBackgroundColor(222, 222, 222)
    
    love.resize(love.window.getWidth(), love.window.getHeight())
    
    state = inGame
    state:enter()
end


---------------------------------------------------------------------------------------------------


function love.resize(width, height)
    translationX = width / 2
    translationY = height / 2
    viewHeight = (gridSize - 0.25) * (math.sqrt(3.0) * 0.5)
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


function love.update(dt)
    local x, y = love.mouse.getPosition()
    x = x - translationX
    y = y - translationY
    x = x / scale
    y = y / scale
    state:update(dt, x, y)
end


---------------------------------------------------------------------------------------------------


function love.draw()
    love.graphics.translate(translationX, translationY)
    love.graphics.scale(scale)
    state:draw()
end


---------------------------------------------------------------------------------------------------
-- Copyright (c) 2014 - Laurent Moussault <moussault.laurent@gmail.com>