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

function Map:isLava( tile )
    return tile >= TILE_LAVA_CENTER and tile <= TILE_LAVA_BOTTOM_LEFT_CORNER and not ( tile == TILE_LAVA_DIRT )
end

function Map:smooth()
    local function is_not_lava( tile )
        return not ( Tiles[tile].image == Tiles[TILE_LAVA_DIRT].image ) or tile == TILE_LAVA_DIRT
    end

    for y, yv in pairs( self.level ) do
        for x, xv in pairs( yv ) do
            local up = self:getTile( x, y - 1 )
            local down = self:getTile( x, y + 1 )
            local left = self:getTile( x - 1, y )
            local right = self:getTile( x + 1, y )
            
            --  > Lava
            if self:isLava( xv ) then
                up = is_not_lava( up )
                down = is_not_lava( down )
                left = is_not_lava( left )
                right = is_not_lava( right )
               
                --  > Top
                if up and left then
                    self.level[y][x] = TILE_LAVA_TOP_LEFT
                elseif up and right then
                    self.level[y][x] = TILE_LAVA_TOP_RIGHT
                elseif up then
                    self.level[y][x] = TILE_LAVA_TOP
                --  > Bottom
                elseif down and right then
                    self.level[y][x] = TILE_LAVA_BOTTOM_RIGHT
                elseif down and left then
                    self.level[y][x] = TILE_LAVA_BOTTOM_LEFT
                elseif down then
                    self.level[y][x] = TILE_LAVA_BOTTOM
                --  > Sides
                elseif right then
                    self.level[y][x] = TILE_LAVA_RIGHT
                elseif left then
                    self.level[y][x] = TILE_LAVA_LEFT
                --  > Corners
                elseif is_not_lava( self:getTile( x - 1, y - 1 ) ) then
                    self.level[y][x] = TILE_LAVA_TOP_LEFT_CORNER
                elseif is_not_lava( self:getTile( x + 1, y - 1 ) ) then
                    self.level[y][x] = TILE_LAVA_TOP_RIGHT_CORNER
                elseif is_not_lava( self:getTile( x - 1, y + 1 ) ) then
                    self.level[y][x] = TILE_LAVA_BOTTOM_LEFT_CORNER
                elseif is_not_lava( self:getTile( x + 1, y + 1 ) ) then
                    self.level[y][x] = TILE_LAVA_BOTTOM_RIGHT_CORNER
                --  > Reset
                else
                    self.level[y][x] = TILE_LAVA_CENTER
                end
            end
        end
    end
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
            xv = Tiles[xv]
            if xv.quad then
                love.graphics.draw( xv.image, xv.quad, x * REAL_SIZE, y * REAL_SIZE, 0, FACTOR, FACTOR )
            else
                love.graphics.draw( xv.image, x * REAL_SIZE, y * REAL_SIZE, 0, FACTOR, FACTOR )
            end
        end
    end
end