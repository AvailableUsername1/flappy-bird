PauseState = Class{__includes = BaseState}

function PauseState:enter(params)
    self.score = params.score
    self.pipePairs = params.pipePairs
    self.bird = params.bird
end

function PauseState:update(dt)
    if wasPressed("p") then
        scrolling = true
        gStateMachine:change("PlayState", {
            bird = self.bird,
            pipePairs = self.pipePairs,
            score = self.score
        })
    end
end

function PauseState:render()
    self.bird:render()
    for k, pair in pairs(self.pipePairs) do
        pair:render()
    end 

    love.graphics.setFont(flappyFont)
    love.graphics.print('Score: ' .. tostring(self.score), 8, 8)
end