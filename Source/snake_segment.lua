local pd <const> = playdate
local gfx <const> = pd.graphics
local point <const> = pd.geometry.point

local COLLISION_GROUP <const> = 1

local segmentImage = gfx.image.new(8, 8)

gfx.pushContext(segmentImage)
gfx.fillRoundRect(0, 0, 8, 8, 2)
gfx.popContext()

class('SnakeSegment').extends(gfx.sprite)

function SnakeSegment:init(frame)
    SnakeSegment.super.init(self)

    self.lowerX = frame.x
    self.upperX = frame.x + frame.width - 8
    self.lowerY = frame.y
    self.upperY = frame.y + frame.height - 8

    self:setCenter(0, 0)

    self:setImage(segmentImage)
    self:setCollideRect(0, 0, self:getSize())
    self:add()

    self:setGroups({COLLISION_GROUP})
    self:setCollidesWithGroups({COLLISION_GROUP})

    self.tailward = nil
    self.headward = nil
end

function SnakeSegment:boundToFrame()
    local x = self.x
    local y = self.y

    if x < self.lowerX then
        x = self.upperX
    elseif x > self.upperX then
        x = self.lowerX
    end

    if y < self.lowerY then
        y = self.upperY
    elseif y > self.upperY then
        y = self.lowerY
    end

    self:moveTo(x, y)
end

function SnakeSegment:isCollidingWithSelf()
    local colliding = self:overlappingSprites()

    return #colliding > 0
end
