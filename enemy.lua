Enemy = Sprite.extend(Sprite)

function Enemy:new(sprite, scale)
    local min_amp = 50
    self.height = 90
    self.width = 90

    self.x = love.graphics.getWidth() - self.width
    self.y = math.random(self.height + min_amp, love.graphics.getHeight() - self.height - min_amp)

    local max_amp = math.min(self.y, love.graphics.getWidth() - self.y)

    Enemy.super.new(self, self.x, self.y, sprite, scale)
    self.height = 90
    self.width = 90

    self.mid_y = self.y

    self.number_of_ticks = 0
    self.amplitude = math.random(min_amp, max_amp)
    self.frequency = math.random(10, 30)
    self.speed = math.random(150, 300)
end

function Enemy:update(dt)
    self.number_of_ticks = self.number_of_ticks + 1

    self.x = self.x - self.speed * dt
    self.y = self.amplitude * math.sin((self.number_of_ticks * 0.5 * math.pi / self.frequency) * 0.5) + self.mid_y
end
