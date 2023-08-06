import "snake_segment"

local pd <const> = playdate
local gfx <const> = pd.graphics
local point <const> = pd.geometry.point

class('Snake').extends(Object)

local VECTORS = {
    up = pd.geometry.vector2D.new(0, -8),
    right = pd.geometry.vector2D.new(8, 0),
    down = pd.geometry.vector2D.new(0, 8),
    left = pd.geometry.vector2D.new(-8, 0),
}

function Snake:init(length, startingPosition, frame)
    Snake.super.init(self)

    self.length = length
    self.frame = frame
    self.needsToAddSegment = false
    self.direction = VECTORS.right
    self.isChangingDirection = false
    self.isStopped = false

    local head = SnakeSegment(self.frame)
    local tail = SnakeSegment(self.frame)

    tail:moveTo(startingPosition.x, startingPosition.y)
    head:moveTo(tail.x + self.direction.dx, tail.y + self.direction.dy)

    head.tailward = tail
    tail.headward = head

    self.head = head
    self.tail = tail

    for x = 3, self.length do
        self:addSegment()
    end
end

function Snake:addSegment()
    local new = SnakeSegment(self.frame)
    local head = self.head

    new.tailward = head
    head.headward = new

    new:moveTo(head.x, head.y)
    new:moveBy(self.direction.dx, self.direction.dy)

    self.head = new

    self.needsToAddSegment = false
end

function Snake:updateSegments()
    local newHead = self.tail
    local oldHead = self.head
    local newTail = newHead.headward

    local oldX = newHead.x
    local oldY = newHead.y

    newHead:moveTo(oldHead.x, oldHead.y)
    newHead:moveBy(self.direction.dx, self.direction.dy)
    newHead:boundToFrame()

    if newHead:isCollidingWithSelf() then
        newHead:moveTo(oldX, oldY)
        game:over()

        return
    end

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

    self.isChangingDirection = false
end

function Snake:handleInput()
    if self.isChangingDirection then
        return
    end

    if pd.buttonJustPressed(pd.kButtonUp) and self.direction ~= VECTORS.down then
        self.isChangingDirection = true
        self.direction = VECTORS.up
    elseif pd.buttonJustPressed(pd.kButtonRight) and self.direction ~= VECTORS.left then
        self.isChangingDirection = true
        self.direction = VECTORS.right
    elseif pd.buttonJustPressed(pd.kButtonDown) and self.direction ~= VECTORS.up then
        self.isChangingDirection = true
        self.direction = VECTORS.down
    elseif pd.buttonJustPressed(pd.kButtonLeft) and self.direction ~= VECTORS.right then
        self.isChangingDirection = true
        self.direction = VECTORS.left
    end
end
