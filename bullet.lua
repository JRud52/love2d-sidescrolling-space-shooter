Bullet = Object.extend(Object)

function Bullet:new(x, y)
    self.x = x
    self.y = y
    self.height = 10
    self.width = 20
    self.speed = 500
end

function Bullet:update(dt) 
    self.x = self.x + self.speed * dt
end

function Bullet:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end
