local pd <const> = playdate
local gfx <const> = pd.graphics

class('Background').extends(gfx.sprite)

function Background:init(frame)
    Background.super.init(self)

    local backgroundImage = gfx.image.new(400, 240)

    gfx.pushContext(backgroundImage)
    gfx.drawRect(
        frame.x - 1,
        frame.y - 1,
        frame.width + 2,
        frame.height + 2
    )
    gfx.popContext()

    self:setImage(backgroundImage)

    self:setCenter(0, 0)
    self:moveTo(0, 0)
    self:setZIndex(-32768)

    self:add()
end
