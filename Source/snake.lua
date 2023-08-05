import "snake_segment"

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

function setupSegmentImage()
    gfx.pushContext(segmentImage)

    gfx.drawRect(-1, 1, 8, 6)
    gfx.drawRect(1, 2, 7, 4)
    gfx.fillRect(2, 0, 4, 8)

    gfx.popContext()
end

setupSegmentImage()

class('Snake').extends(Object)

function Snake:init(length, startingPosition)
    Snake.super.init(self)

    self.length = length
    self.needsToAddSegment = false

    local head = SnakeSegment()
    local tail = SnakeSegment()

    head:moveTo(startingPosition.x, startingPosition.y)
    tail:moveTo(head.x - 8, head.y)

    head.tailward = tail
    tail.headward = head

    self.head = head
    self.tail = tail

    for x = 3, self.length do
        self:addSegment()
    end
end

function Snake:addSegment()
    local new = SnakeSegment()
    local head = self.head

    new.tailward = head
    head.headward = new

    new:moveTo(head.x, head.y)
    new:moveBy(8, 0)

    self.head = new
end

function Snake:updateSegments()
    local newHead = self.tail
    local oldHead = self.head
    local newTail = newHead.headward

    newHead:moveTo(oldHead.x, oldHead.y)
    newHead:moveBy(8, 0)

    oldHead.headward = newHead
    newHead.tailward = head
    self.head = newHead

    newTail.tailward = nil
    newHead.headward = nil
    self.tail = newTail
end

function Snake:update()
    if self.needsToAddSegment then
        self:addSegment()
    else
        self:updateSegments()
    end
end

