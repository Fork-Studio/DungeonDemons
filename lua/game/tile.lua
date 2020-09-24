--  > Tile
Tile = class()
Tile.image, Tile.quad = nil, nil

function Tile:construct( path, quad )
    self.image, self.quad = type( path ) == "string" and image( path ) or path, quad
end

--  > Tiles
function Tiles( image, quads )
    local tiles = {}

    for i, v in ipairs( quads ) do
        tiles[i] = Tile( image, v )
    end

    return unpack( tiles )
end

--  > Game Tiles
TILE_WOOD = Tile( "tiles/planks.png" )

--  Lava
local _image = image( "tiles/lava.png" )
TILE_LAVA_CENTER, 
TILE_LAVA_LEFT, 
TILE_LAVA_RIGHT, 
TILE_LAVA_BOTTOM, 
TILE_LAVA_TOP, 
TILE_LAVA_BOTTOM_LEFT, 
TILE_LAVA_BOTTOM_RIGHT, 
TILE_LAVA_TOP_RIGHT,
TILE_LAVA_TOP_LEFT,
TILE_LAVA_DIRT,
TILE_LAVA_TOP_RIGHT_CORNER,
TILE_LAVA_TOP_LEFT_CORNER,
TILE_LAVA_BOTTOM_RIGHT_CORNER,
TILE_LAVA_BOTTOM_LEFT_CORNER = Tiles( _image, quads( _image ) )

--  Stone
local _image = image( "tiles/wall_stone.png" )
TILE_STONE_LEFT,
TILE_STONE_RIGHT,
TILE_STONE_TOP,
TILE_STONE_BOTTOM,
TILE_STONE_BOTTOM_LEFT,
TILE_STONE_BOTTOM_RIGHT,
TILE_STONE_TOP_RIGHT,
TILE_STONE_TOP_LEFT,
TILE_STONE_BLOCK = Tiles( _image, quads( _image ) )

--  Grass
TILE_GRASS = Tile( "tiles/grass.png" )