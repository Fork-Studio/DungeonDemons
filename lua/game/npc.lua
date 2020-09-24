NPCs, NPC = {}, class( GameObject )
NPC.x, NPC.y = 0, 0
NPC.ang = 0
NPC.move_speed = 150

NPC.name = ""
NPC.selected = false
NPC.target = nil

NPC.image = image( "demons/drakon.png" )

function NPC:init( name, image )
    self.name = name

    --  > Image
    self.image = image or self.image
    self.img_w, self.img_h = self.image:getDimensions()
    self.w, self.h = self.img_w * FACTOR, self.img_h * FACTOR

    --  > NPCs
    NPCs[self.id] = self
end

function NPC:update( dt )
    if self.target and distance( self.x, self.y, self.target.x, self.target.y ) > SPRITE_SIZE then
        local dir = direction_angle( self.x, self.y, self.target.x, self.target.y )
        self.x = self.x + math.cos( dir ) * self.move_speed * dt
        self.y = self.y + math.sin( dir ) * self.move_speed * dt
    end
end

function NPC:draw()
    love.graphics.print( self.name, self.x, self.y - self.img_h / 4 * FACTOR )
    love.graphics.draw( self.image, self.x + self.img_h / 2 * FACTOR, self.y + self.img_h / 2 * FACTOR, self.ang, FACTOR, FACTOR, self.img_h / 2, self.img_h / 2 )
end

function NPC:destroy()
    NPCs[self.id] = nil
    GameObject.destroy( self )
end