Map = class( GameObject )
Map.level = {}

function Map:init( w, h )
    for y = 0, h do
        self.level[y] = {}
        for x = 0, w do
            self.level[y][x] = math.random( 1, 2 ) == 1 and TILE_WOOD or TILE_LAVA
        end
    end
end

function Map:draw()
    for y, yv in pairs( self.level ) do
        for x, xv in pairs( yv ) do
            if xv.quad then
                love.graphics.draw( xv.image, xv.quad, x * REAL_SIZE, y * REAL_SIZE, 0, FACTOR, FACTOR )
            else
                love.graphics.draw( xv.image, x * REAL_SIZE, y * REAL_SIZE, 0, FACTOR, FACTOR )
            end
        end
    end
end