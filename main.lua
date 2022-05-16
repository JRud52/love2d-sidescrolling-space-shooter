local launch_type = arg[2]
if launch_type == "test" or launch_type == "debug" then
    require "lldebugger"

    if launch_type == "debug" then
        lldebugger.start()
    end
end

function love.load()
    love.window.setMode(1500, 800, {})
    math.randomseed(os.time())

    Object = require "classic"
    require "sprite"
    require "player"
    require "enemy"
    require "bullet"
    require "entitymanager"

    Score = 0
    GameOver = false

    Player1 = Player(100, 100, love.graphics.newImage("images/ship.png", {}), 0.2)

    EnemyManager = EntityManager()
    BulletManager = EntityManager()

    EnemyImage = love.graphics.newImage("images/enemy.png", {})

    EnemyManager:spawn(Enemy(EnemyImage, 0.2))
    SpawnTimer = 0
    Min_Spawn_Interval = 20
    Max_Spawn_interval = 200
    SpawnInterval = math.random(Min_Spawn_Interval, Max_Spawn_interval)
end

local function checkCollision(a, b)
    --With locals it's common usage to use underscores instead of camelCasing
    local a_left = a.x
    local a_right = a.x + a.width
    local a_top = a.y
    local a_bottom = a.y + a.height

    local b_left = b.x
    local b_right = b.x + b.width
    local b_top = b.y
    local b_bottom = b.y + b.height

    --Directly return this boolean value without using if-statement
    return  a_right > b_left
        and a_left < b_right
        and a_bottom > b_top
        and a_top < b_bottom
end

function love.keypressed(key)
    if GameOver then
        return
    end

    if key == "space" then
        local bullet_x = Player1.x + Player1.width
        local bullet_y = Player1.y + Player1.height/2

        BulletManager:spawn(Bullet(bullet_x, bullet_y))
    end
end

function love.update(dt)
    if GameOver then 
        return
    end

    Player1:update(dt)
    BulletManager:update(dt)
    EnemyManager:update(dt)

    -- Collision checks
    for e, enemy in ipairs(EnemyManager.entityList) do
        for b, bullet in ipairs(BulletManager.entityList) do
            if checkCollision(bullet, enemy) then
                table.remove(EnemyManager.entityList, e)
                table.remove(BulletManager.entityList, b)
                Score = Score + 1
            end
        end

        if checkCollision(Player1, enemy) then
            GameOver = true
        end
    end

    -- Spawn Enemies
    if SpawnTimer >= SpawnInterval then
        EnemyManager:spawn(Enemy(EnemyImage, 0.2))
        SpawnTimer = 0
    end
    SpawnTimer = SpawnTimer + 1
    SpawnInterval = math.random(Min_Spawn_Interval, Max_Spawn_interval)
end

function love.draw()
    local background = love.graphics.newImage("images/stars.png", {})
    love.graphics.draw(background, 0, 0, 0, 1, 1)
    love.graphics.draw(background, 0, background:getHeight(), 0, 1, 1)

    Player1:draw()
    BulletManager:draw()
    EnemyManager:draw()

    if GameOver then
        love.graphics.print('Game Over ', 400, 400, 0, 10, 10)
    end
    love.graphics.print('Score ' .. Score, 10, 10, 0, 2, 2)
end

local love_errorhandler = love.errorhandler

function love.errorhandler(msg)
    if lldebugger then
        lldebugger.start() -- Add this
         error(msg, 2)
    else
        return love_errorhandler(msg)
    end
end
