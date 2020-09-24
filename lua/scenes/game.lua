Game = class( GameObject )
Game.map = nil
Game.selected_npc = nil

function Game:init()
    self.map = Map( 16, 16 )

    NPC( ( "Dorian" ):rep( 2 ) ).target = { x = 500, y = 400 }
end

function Game:update( dt )
end

function Game:keypress( key )
    if key == "r" then
        love.setScene( Menu )
    end
end

function Game:mousepress( button, x, y )
    if self.selected_npc then
        self.selected_npc.target = {
            x = x,
            y = y,
        }
    else
        for k, v in pairs( NPCs ) do
            if collide( x, y, 1, 1, v.x, v.y, v.w, v.h ) then
                self.selected_npc = v
                v.selected = true
                break
            end
        end
    end
end

function Game:draw()
    love.graphics.print( "Game Scene", 5, 25 )
end