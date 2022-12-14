Bird = Class{}

local GRAVITY = 20

function Bird:init()
    self.image = love.graphics.newImage("bird.png")
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.x = VIRTUAL_WIDTH / 2 - self.width / 2
    self.y = VIRTUAL_HEIGHT / 2 - self.height / 2

    self.dy = 0
end

function Bird:update(dt)
    self.dy = self.dy + GRAVITY * dt

    if wasPressed("space") then
        self.dy = -5
        sounds.jump:play()
    end

    self.y = self.y + self.dy
end

function Bird:collides(pipe)
    if pipe.orientation == "bottom" then
        if self.x + self.width - 2 > pipe.x and self.x + 2 < pipe.x + PIPE_WIDTH and self.y + self.height - 2 > pipe.y then
            return true
        end
    elseif pipe.orientation == "top" then
        if self.x + self.width - 2 > pipe.x and self.x + 2 < pipe.x + PIPE_WIDTH and self.y + 2 < pipe.y then
            return true
        end
    else
        return false
    end
end

function Bird:render()
    love.graphics.draw(self.image, self.x, self.y)
end