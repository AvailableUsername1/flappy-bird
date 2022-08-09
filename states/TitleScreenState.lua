TitleScreenState = Class{__includes = BaseState}

function TitleScreenState:update(dt)
    if wasPressed("enter") or wasPressed("return") then
        gStateMachine:change("CountdownState")
    end
end

function TitleScreenState:render()
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Fifty Bird', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Press Enter', 0, 100, VIRTUAL_WIDTH, 'center')
end