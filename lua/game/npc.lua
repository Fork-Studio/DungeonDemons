NPCs, NPC = {}, class( GameObject )
NPC.x, NPC.y = 0, 0
NPC.ang = 0
NPC.move_speed = 150

NPC.name = ""
NPC.selected = false
NPC.target = nil

NPC.image = image( "demons/drakon.png" )
NPC.quads, NPC.quad_id = nil, 1
NPC.anim_time, NPC.anim_fps = 0, 6
NPC.scale_x, NPC.scale_y = 1, 1

function NPC:init( name, image )
    self.name = name

    --  > Image
    self.image = image or self.image
    self.quads = quads( self.image )
    self.img_w, self.img_h = self.image:getDimensions()
    self.w, self.h = self.img_w * FACTOR, self.img_h * FACTOR

    --  > NPCs
    NPCs[self.id] = self
end

function NPC:anim( dt )
    self.anim_time = self.anim_time + dt
    if self.anim_time >= 1 / self.anim_fps then
        self.quad_id = self.quad_id + 1 > #self.quads and 1 or self.quad_id + 1
        self.anim_time = 0
    end
end

function NPC:update( dt )
    --  > Travel to target
    if self.target and distance( self.x + self.h / 2, self.y + self.h / 2, self.target.x, self.target.y ) > 1 then
        local dir = direction_angle( self.x + self.h / 2, self.y + self.h / 2, self.target.x, self.target.y )
        self.x = self.x + math.cos( dir ) * self.move_speed * dt
        self.y = self.y + math.sin( dir ) * self.move_speed * dt

        --  > Look left
        if dir > math.pi / 2 or dir < -math.pi / 2 then
            self.scale_x = -1
        --  > Look right
        else
            self.scale_x = 1
        end

        self:anim( dt )
    end 
end

function NPC:draw()
    love.graphics.setColor( 1, 1, 1 )

    --  > Name
    local limit = 100
    love.graphics.printf( self.name, self.x - limit / 2 + self.h / 2, self.y - self.h / 4, limit, "center" )
    
    --  > Sprite
    love.graphics.draw( self.image, self.quads[self.quad_id], self.x + self.h / 2, self.y + self.h / 2, self.ang, FACTOR * self.scale_x, FACTOR * self.scale_y, self.img_h / 2, self.img_h / 2 )

    --  > Debug
    if DEBUG then
        love.graphics.setColor( 0, .7, 0 )

        --  > Position and size
        love.graphics.rectangle( "line", self.x, self.y, self.h, self.h )

        --  > Target
        if self.target then
            love.graphics.line( self.x + self.h / 2, self.y + self.h / 2, self.target.x, self.target.y )
        end
    end
end

function NPC:destroy()
    NPCs[self.id] = nil
    GameObject.destroy( self )
end