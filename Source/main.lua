import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "snake"

local pd <const> = playdate
local gfx <const> = pd.graphics

local INITIAL_LENGTH <const> = 5
local START_LOCATION <const> = pd.geometry.point.new(60, 60)

local snake = Snake(
    INITIAL_LENGTH,
    START_LOCATION
)

function playdate.update()
    gfx.sprite.update()
    pd.timer.updateTimers()
end

function setup()
    local function callback()
        snake:update()
    end

    pd.timer.keyRepeatTimerWithDelay(1000, 1000, callback)
end

setup()
