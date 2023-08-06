local pd <const> = playdate
local gfx <const> = pd.graphics
local point <const> = pd.geometry.point

local COLLISION_GROUP <const> = 2
local SNAKE_COLLISION_GROUP <const> = 1

local tokenImage = gfx.image.new(8, 8)

gfx.pushContext(tokenImage)
gfx.fillPolygon(
    0, 4,
    4, 8,
    8, 4,
    4, 0
)
gfx.popContext()

class('Token').extends(gfx.sprite)

function Token:init()
    Token.super.init(self)

    self:setCenter(0, 0)
    self:setImage(tokenImage)
    self:setCollideRect(0, 0, self:getSize())

    self:setGroups({COLLISION_GROUP})
    self:setCollidesWithGroups({SNAKE_COLLISION_GROUP})
end

function Token:update()
    local colliding = self:overlappingSprites()

    if #colliding > 0 then
        game:tokenWasEaten()
    end
end
