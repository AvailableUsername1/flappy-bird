require "Pipe"

PipePair = Class{}


function PipePair:init(y)
    self.x = VIRTUAL_WIDTH + 32
    self.y = y

    self.gap_height = math.random(50, 100)

    self.pipes = {
        ["upper"] = Pipe("top", y - self.gap_height, x),
        ["lower"] = Pipe("bottom", y, x)
    }

    self.remove = false
    self.scored = false
end

function PipePair:update(dt)
    if self.x > -PIPE_WIDTH then
        self.x = self.x + PIPE_SCROLL * dt
        self.pipes["upper"].x = self.x
        self.pipes["lower"].x = self.x
    else
        self.remove = true
    end
end

function PipePair:render()
    for k, pipe in pairs(self.pipes) do
        pipe:render()
    end
end