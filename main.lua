push = require "push"

Class = require "class"

require "Bird"
require "PipePair"

require "StateMachine"
require "states/BaseState"
require "states/PlayState"
require "states/TitleScreenState"
require "states/ScoreState"
require "states/CountdownState"
require "states/PauseState"

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

local background = love.graphics.newImage("background.png")
backgroundScroll = 0

local ground = love.graphics.newImage("ground.png")
groundScroll = 0

backgroundSpeed = 30
groundSpeed = 60

BACKGROUND_LOOPING_POINT = 413

scrolling = true

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")

    love.window.setTitle("Fifty Bird")

    smallFont = love.graphics.newFont('font.ttf', 8)
    mediumFont = love.graphics.newFont('flappy.ttf', 14)
    flappyFont = love.graphics.newFont('flappy.ttf', 28)
    hugeFont = love.graphics.newFont('flappy.ttf', 56)
    love.graphics.setFont(flappyFont)

    gStateMachine = StateMachine {
        ["PlayState"] = function() return PlayState() end,
        ["TitleScreenState"] = function() return TitleScreenState() end, 
        ["ScoreState"] = function() return ScoreState() end,
        ["CountdownState"] = function() return CountdownState() end,
        ["PauseState"] = function() return PauseState() end
    }
    gStateMachine:change("TitleScreenState")

    sounds = {
        ['jump'] = love.audio.newSource('jump.wav', 'static'),
        ['explosion'] = love.audio.newSource('explosion.wav', 'static'),
        ['hurt'] = love.audio.newSource('hurt.wav', 'static'),
        ['score'] = love.audio.newSource('score.wav', 'static'),
        ['music'] = love.audio.newSource('marios_way.mp3', 'static')
    }
  
    sounds['music']:setLooping(true)
    sounds['music']:play()

    love.keyboard.pressedKeys = {}

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    love.keyboard.pressedKeys[key] = true

    if key == "escape" then
        love.event.quit()
    end
end

function wasPressed(key)
    return love.keyboard.pressedKeys[key]
end

function love.update(dt)
    if scrolling then
        backgroundScroll = (backgroundScroll + backgroundSpeed * dt) % BACKGROUND_LOOPING_POINT
        groundScroll = (groundScroll + groundSpeed * dt) % VIRTUAL_WIDTH
    end

    gStateMachine:update(dt)
    

    love.keyboard.pressedKeys = {}
end

function love.draw()
    push:start()
    
    love.graphics.draw(background, -backgroundScroll, 0)

    gStateMachine:render()

    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 16)

    push:finish()
end