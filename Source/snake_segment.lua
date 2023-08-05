local pd <const> = playdate
local gfx <const> = pd.graphics
local point <const> = pd.geometry.point

--   01234567
--  ┌────────┐
-- 0│  ████  │
-- 1│███████ │
-- 2│ ███████│
-- 3│ ███████│
-- 4│ ███████│
-- 5│ ███████│
-- 6│███████ │
-- 7│  ████  │
--  └────────┘

local segmentImage = gfx.image.new(8, 8)

gfx.pushContext(segmentImage)

gfx.drawRect(-1, 1, 8, 6)
gfx.drawRect(1, 2, 7, 4)
gfx.fillRect(2, 0, 4, 8)

gfx.popContext()

class('SnakeSegment').extends(gfx.sprite)

function SnakeSegment:init()
    SnakeSegment.super.init(self)

    self:setImage(segmentImage)
    self:add()

    self.tailward = nil
    self.headward = nil
end
