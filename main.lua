--  > Pixel-Art Filter
love.graphics.setDefaultFilter( "nearest" )

--  > Global Variables
SPRITE_SIZE, REAL_SIZE = 16, 48
FACTOR = REAL_SIZE / SPRITE_SIZE
DEBUG = false

--  > Dependencies
require "lua.libs.require"
require "lua.libs.*"
require "lua.scenes.*"
require "lua.*"
require "lua.game.*"

--  > Framework
function love.load()
    math.randomseed( os.time() )
    love.setScene( Game )
end

function love.setScene( scene, ... )
    if love._scene then love._scene:destroy() end
    GameObjects.reset()

    local args = { ... }
    timer( 0, function() 
        love._scene = scene( unpack( args ) )
    end )
end

function love.update( dt )
    GameObjects.call( "update", dt )

    --  > Timers
    for k, v in pairs( Timers ) do
        v.time = v.time + dt
        if v.time >= v.max_time then
            v.callback()
            Timers[k] = nil
        end
    end
end

function love.keypressed( key )
    GameObjects.call( "keypress", key )
end

function love.mousepressed( x, y, button )
    GameObjects.call( "mousepress", button, x, y )
end

function love.wheelmoved( x, y )
    GameObjects.call( "wheelmove", x, y )
end

function love.draw()
    GameObjects.call( "draw" )
    --  > TODO: make only one call to scene draw func
    love._scene:draw()
    
    love.graphics.origin()
    love.graphics.setColor( 1, 1, 1 )
    love.graphics.print( love.timer.getFPS() .. " FPS", 5, 5 )
end
