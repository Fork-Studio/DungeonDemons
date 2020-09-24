Map = class( GameObject )
Map.level = {}
Map.w, Map.h = 0, 0

function Map:init( w, h )
    for y = 0, h - 1 do
        self.level[y] = {}
        for x = 0, w - 1 do
            self.level[y][x] = TILE_GRASS
        end
    end

    self.w, self.h = w, h
end

function Map:getTile( tile_x, tile_y )
    return self.level[tile_y] and self.level[tile_y][tile_x]
end

function Map:setTile( tile_x, tile_y, tile )
    if self:getTile( tile_x, tile_y ) then
        self.level[tile_y][tile_x] = tile
    end
end

function Map:draw()
    love.graphics.setColor( 1, 1, 1 )

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