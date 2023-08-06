import "token"

local pd <const> = playdate
local gfx <const> = pd.graphics

local INITIAL_LENGTH <const> = 5

local BORDER <const> = 4
local HEADER <const> = 32

local FRAME = pd.geometry.rect.new(
    BORDER,
    BORDER + HEADER,
    400 - BORDER * 2,
    240 - HEADER - BORDER * 2
)

local START_LOCATION <const> = pd.geometry.point.new(
    FRAME.x + 64,
    FRAME.y + 96
)

class('Game').extends(Object)

local STATE <const> = {
    playing = 1,
    over = 2
}

function Game:init()
    self.background = Background(FRAME)
    self.snake = Snake(
        INITIAL_LENGTH,
        START_LOCATION,
        FRAME
    )

    self.token = Token()
    self.token:add()

    math.randomseed(pd.getSecondsSinceEpoch())

    self.score = 0
    self.counter = 1
    self.speed = 5
    self.state = STATE.playing

    self:repositionToken()
end

function Game:update()
    if self.state ~= STATE.playing then
        return
    end

    self.snake:handleInput()
    self.counter += 1

    if self.counter > (30 // self.speed) then
        self.counter = 0
        self.snake:update()
    end
end

function Game:tokenWasEaten()
    self.score += self.speed
    print(self.score)

    self:repositionToken()

    self.snake.needsToAddSegment = true
end

function Game:repositionToken()
    local x = 0
    local y = 0

    repeat
        x = math.random(0, (FRAME.width // 8) - 1) * 8 + FRAME.x
        y = math.random(0, (FRAME.height // 8) - 1) * 8 + FRAME.y
    until #gfx.sprite.querySpritesAtPoint(x, y) == 0

    self.token:moveTo(x, y)
end

function Game:over()
    print('Sad reacts only :-(')

    self.state = STATE.over
end
