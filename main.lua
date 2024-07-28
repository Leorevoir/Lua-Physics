--
-- EPITECH PROJECT, 2024
-- physics
-- File description:
-- main.lua
--

local love = require("love")

-- Classe Ball
Ball = {}
Ball.__index = Ball


function Ball:new(x, y, radius)
    local instance = setmetatable({}, Ball)
    instance.x = x
    instance.y = y
    instance.radius = radius
    instance.vy = 0
    return instance
end


function Ball:update(dt)
    self.y = self.y + self.vy * dt
    self.vy = self.vy + GRAVITY * dt

    if self.y + self.radius > love.graphics.getHeight() then
        self.y = love.graphics.getHeight() - self.radius
        self.vy = -self.vy * RESTITUTION

        if math.abs(self.vy) < 1 then -- si vitesse trop faible, stop
            self.vy = 0
        end
    end
end


function Ball:draw()
    love.graphics.circle("fill", self.x, self.y, self.radius)
end


function love.load() -- init de tout
    love.window.setTitle("EPITECH gravity hub project")
    love.window.setMode(1920, 1080)

    BALLS = {}
    GRAVITY = 500
    FALLING = false
    RESTITUTION = 0.7
end


local function draw_balls()
    for _, ball in ipairs(BALLS) do
        ball:draw()
    end
end


function love.draw() -- display
    draw_balls()
end


function love.keyreleased(key)
    if key == "space" then
        FALLING = not FALLING
    end
end


function love.update(dt)
    if FALLING then
        for _, ball in ipairs(BALLS) do
            ball:update(dt)
        end
    end
end


function love.mousepressed(x, y, button)
    if button == 1 then -- clic gauche
        local ball = Ball:new(x, y, 20)
        table.insert(BALLS, ball)
    end
end
