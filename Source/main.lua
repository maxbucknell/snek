import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

local pd <const> = playdate
local gfx <const> = pd.graphics

import "snake"
import "background"
import "game"

game = Game()

function pd.update()
    gfx.sprite.update()
    pd.timer.updateTimers()

    game:update()
end
