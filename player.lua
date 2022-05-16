Player = Sprite.extend(Sprite)

function Player:new(x, y, sprite, scale)
    Player.super.new(self, x, y, sprite, scale)
    self.height = 60
    self.width = 90
end

function Player:update(dt)
    if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
        self.x = self.x + self.speed * dt
    end
    if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
        self.x = self.x - self.speed * dt
    end
    if love.keyboard.isDown("up") or love.keyboard.isDown("w") then
        self.y = self.y - self.speed * dt
    end
    if love.keyboard.isDown("down") or love.keyboard.isDown("s") then
        self.y = self.y + self.speed * dt
    end

    if self.x < 0 then
        self.x = 0
    elseif self.x + self.width > love.graphics.getWidth() then
        self.x = love.graphics.getWidth() - self.width
    end

    if self.y < 0 then
        self.y = 0
    elseif self.y + self.height > love.graphics.getHeight() then
        self.y = love.graphics.getHeight() - self.height
    end

end
