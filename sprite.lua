Sprite = Object.extend(Object)

function Sprite:new(x, y, sprite, scale)
    self.x = x
    self.y = y
    self.sprite = sprite
    self.scale = scale
    self.height = self.sprite:getHeight()
    self.width = self.sprite:getWidth()
    self.speed = 200
end

function Sprite:draw()
    love.graphics.draw(self.sprite, self.x, self.y, 0, self.scale, self.scale)
end
