require "lua.game.tile"

print( TILE_LAVA_CENTER )

Game = class( GameObject )
Game.map = nil
Game.editing_mode, Game.editing_tiles, Game.editing_tile_id = false, {
    TILE_LAVA_CENTER,
    TILE_LAVA_DIRT,
    TILE_STONE_BLOCK,
}, 1
Game.selected_npc = nil

function Game:init()
    self.map = Map( 16, 16 )

    NPC( ( "Dorian" ):rep( 2 ) ).target = { x = 500, y = 400 }
    NPC( "bruh", image( "demons/godus.png" ) )
end

function Game:update( dt )
     --  > Editing Mode
     if self.editing_mode then
        --  > Get tile
        local tile
        if love.mouse.isDown( 1 ) then
            tile = self.editing_tiles[self.editing_tile_id]
        elseif love.mouse.isDown( 2 ) then
            tile = TILE_GRASS
        end

        if tile then
            --  > Get position
            local tile_x, tile_y = self:getMouseTilePosition()

            --  > Change map tile
            self.map:setTile( tile_x, tile_y, tile )
        end
    end
end

function Game:getMouseTilePosition()
    local mouse_x, mouse_y = love.mouse.getPosition() 
    return math.floor( mouse_x / REAL_SIZE ), math.floor( mouse_y / REAL_SIZE )
end

function Game:keypress( key )
    if key == "escape" then
        love.setScene( Menu )
    elseif key == "p" then
        self.editing_mode = not self.editing_mode
        if not self.editing_mode then
            if self.selected_npc then
                self.selected_npc.selected = false
                self.selected_npc = nil
            end
        end
    end
end

function Game:wheelmove( x, y )
    if y > 0 then
        self.editing_tile_id = self.editing_tile_id + y > #self.editing_tiles and 1 or self.editing_tile_id + y
    else
        self.editing_tile_id = self.editing_tile_id + y < 1 and #self.editing_tiles or self.editing_tile_id + y
    end
end

function Game:mousepress( button, x, y )
    --  > Game Mode
    if not self.editing_mode then
        if button == 1 then
            if self.selected_npc then
                self.selected_npc.target = {
                    x = x,
                    y = y,
                }
            else
                for k, v in pairs( NPCs ) do
                    if collide( x, y, 1, 1, v.x, v.y, v.w, v.h ) then
                        self.selected_npc = v
                        self.selected_npc.selected = true
                        break
                    end
                end
            end
        elseif button == 2 then
            if self.selected_npc then
                self.selected_npc.selected = false
                self.selected_npc = nil
            end
        end
    end
end

function Game:draw()
    --  > Editing Mode
    if self.editing_mode then
        love.graphics.setColor( 1, 1, 1 )

        --  > Grid
        for x = 0, self.map.w do
            love.graphics.line( x * REAL_SIZE, 0, x * REAL_SIZE, self.map.h * REAL_SIZE )
        end
        for y = 0, self.map.h do
            love.graphics.line( 0, y * REAL_SIZE, self.map.w * REAL_SIZE, y * REAL_SIZE )
        end

        --  > Tile Preview
        local tile = self.editing_tiles[self.editing_tile_id]
        local tile_x, tile_y = self:getMouseTilePosition()

        love.graphics.setColor( 1, 1, 1, .75 )
        if tile.quad then
            love.graphics.draw( tile.image, tile.quad, tile_x * REAL_SIZE, tile_y * REAL_SIZE, 0, FACTOR, FACTOR )
        else
            love.graphics.draw( tile.image, tile_x * REAL_SIZE, tile_y * REAL_SIZE, 0, FACTOR, FACTOR )
        end
    end
end