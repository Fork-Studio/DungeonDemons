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
end

function Game:update( dt )
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
    --  > Editing Mode
    if self.editing_mode then
        if button == 1 then
            local tile_x, tile_y = math.floor( x / REAL_SIZE ), math.floor( y / REAL_SIZE )
            self.map:setTile( tile_x, tile_y, self.editing_tiles[self.editing_tile_id] )
        end
    --  > Game Mode
    else
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
    end
end