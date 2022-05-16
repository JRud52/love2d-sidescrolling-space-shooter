EntityManager = Object.extend(Object)

function EntityManager:new()
    self.entityList = {}
end

function EntityManager:spawn(entity)
    table.insert(self.entityList, entity)
end

function EntityManager:update(dt)
    for i, entity in ipairs(self.entityList) do
        entity:update(dt)

        if entity.x < 0 or entity.x + entity.width > love.graphics.getWidth() then
            table.remove(self.entityList, i)
        end
    end
end

function EntityManager:draw()
    for _, entity in ipairs(self.entityList) do
        entity:draw()
    end
end
