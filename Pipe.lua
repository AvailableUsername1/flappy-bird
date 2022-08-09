Pipe = Class{}

local PIPE_IMAGE = love.graphics.newImage("pipe.png")

PIPE_HEIGHT = PIPE_IMAGE:getHeight()
PIPE_WIDTH = PIPE_IMAGE:getWidth()

PIPE_SCROLL = -60


function Pipe:init(orientation, y)
    self.x = x
    self.y = y
    self.orientation = orientation
end

function Pipe:render()
    love.graphics.draw(PIPE_IMAGE, math.floor(self.x + 0.5), math.floor(self.y), 0, 1,
    self.orientation == "bottom" and 1 or - 1)
end