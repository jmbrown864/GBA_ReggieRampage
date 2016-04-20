
//{{BLOCK(kitchen_floor)

//======================================================================
//
//	kitchen_floor, 256x256@4, 
//	+ palette 256 entries, not compressed
//	+ 4 tiles (t|f|p reduced) not compressed
//	+ regular map (in SBBs), not compressed, 32x32 
//	Total size: 512 + 128 + 2048 = 2688
//
//	Time-stamp: 2016-04-05, 14:24:51
//	Exported by Cearn's GBA Image Transmogrifier, v0.8.3
//	( http://www.coranac.com/projects/#grit )
//
//======================================================================

#ifndef GRIT_KITCHEN_FLOOR_H
#define GRIT_KITCHEN_FLOOR_H

#define kitchen_floorTilesLen 128
extern const unsigned short kitchen_floorTiles[64];

#define kitchen_floorMapLen 2048
extern const unsigned short kitchen_floorMap[1024];

#define kitchen_floorPalLen 512
extern const unsigned short kitchen_floorPal[256];

#endif // GRIT_KITCHEN_FLOOR_H

//}}BLOCK(kitchen_floor)
