NPC = class( GameObject )
NPC.x, NPC.y = 0, 0
NPC.ang = 0

NPC.size_factor = 3
NPC.image = image( "demons/drakon.png" )

function NPC:init( image )
    self.image = image or self.image
    self.img_w, self.img_h = self.image:getDimensions()
end

function NPC:update( dt )
end

function NPC:draw()
    love.graphics.draw( self.image, self.x + self.img_h / 2 * self.size_factor, self.y + self.img_h / 2 * self.size_factor, self.ang, self.size_factor, self.size_factor, self.img_h / 2, self.img_h / 2 )
end