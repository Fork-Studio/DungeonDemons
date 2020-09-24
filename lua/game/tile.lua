Tile = class()
Tile.image, Tile.quad = nil, nil

function Tile:construct( path, quad )
    self.image, self.quad = type( path ) == "string" and image( path ) or path, quad
end

TILE_WOOD = Tile( "tiles/planks.png" )
TILE_LAVA = Tile( "tiles/lava.png" )

local stones_image = image( "tiles/wall_stone.png" )
local stones_quads = quads( stones_image )
TILE_STONE_TOP = Tile( stones_image, stones_quads[3] )