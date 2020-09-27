--  > Tile
local id = 0
Tile, Tiles = class(), {}
Tile.image, Tile.quad = nil, nil
Tile.id = 0

function Tile:construct( path, quad )
    self.image, self.quad = type( path ) == "string" and image( path ) or path, quad

    id = id + 1
    self.id = id

    Tiles[self.id] = self
    return self.id
end

--  > Tiles
local function tiles( image, quads )
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
TILE_LAVA_BOTTOM_LEFT_CORNER = tiles( _image, quads( _image ) )

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
TILE_STONE_BLOCK = tiles( _image, quads( _image ) )

--  Grass
TILE_GRASS = Tile( "tiles/grass.png" )