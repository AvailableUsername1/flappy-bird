PlayState = Class{__includes = BaseState}

function PlayState:enter(params)
    self.score = params.score
    self.pipePairs = params.pipePairs
    self.bird = params.bird
end

function PlayState:init()
    self.lastY = math.random(VIRTUAL_HEIGHT / 4, (VIRTUAL_HEIGHT * 3) / 4)
    self.spawnTimer = 0
    self.spawnInterval = math.random(1.5, 2.5)
end

function PlayState:update(dt)
    self.spawnTimer = self.spawnTimer + dt

    self.bird:update(dt)

    if self.spawnTimer > self.spawnInterval then
        y = math.max(50, math.min(self.lastY + math.random(-25, 25), VIRTUAL_HEIGHT - 50))
        self.lastY = y
        table.insert(self.pipePairs, PipePair(y))
        self.spawnTimer = 0
        self.spawnInterval = math.random(1.5, 2.5)
    end

    for k, pair in pairs(self.pipePairs) do
        pair:update(dt)

        for j, pipe in pairs(pair.pipes) do
            if self.bird:collides(pipe) then
                sounds.explosion:play()
                sounds.hurt:play()
                gStateMachine:change("ScoreState", {
                    score = self.score
                })
            end
        end

        if not pair.scored then
            if self.bird.x > pair.x + PIPE_WIDTH then
                pair.scored = true
                self.score = self.score + 1
                sounds.score:play()
            end
        end

        if pair.remove then
            table.remove(self.pipePairs, k)
        end
    end

    if self.bird.y > VIRTUAL_HEIGHT - 15 then
        sounds.explosion:play()
        sounds.hurt:play()
        gStateMachine:change('ScoreState', {
            score = self.score
        })
    end

    if wasPressed("p") then
        scrolling = false
        gStateMachine:change("PauseState", {
            bird = self.bird,
            pipePairs = self.pipePairs,
            score = self.score
        })
    end
end

function PlayState:render()
    self.bird:render()
    for k, pair in pairs(self.pipePairs) do
        pair:render()
    end 

    love.graphics.setFont(flappyFont)
    love.graphics.print('Score: ' .. tostring(self.score), 8, 8)
end