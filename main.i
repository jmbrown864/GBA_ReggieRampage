# 1 "main.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "main.c"
# 17 "main.c"
# 1 "myLib.h" 1



typedef unsigned short u16;
# 40 "myLib.h"
extern unsigned short *videoBuffer;

extern unsigned short *frontBuffer;
extern unsigned short *backBuffer;




void setPixel3(int row, int col, unsigned short color);
void drawRect3(int row, int col, int height, int width, unsigned short color);
void fillScreen3(unsigned short color);
void drawImage3(const unsigned short* image, int row, int col, int height, int width);


void setPixel4(int row, int col, unsigned char colorIndex);
void drawRect4(int row, int col, int height, int width, unsigned char colorIndex);
void fillScreen4(unsigned char color);

void drawBackgroundImage4(const unsigned short* image);
void drawImage4(const unsigned short* image, int row, int col, int height, int width);
void drawSubImage4(const unsigned short* sourceImage, int sourceRow, int sourceCol,
       int row, int col, int height, int width);

void loadPalette(const unsigned short* palette);
void loadMap(const unsigned short * map, unsigned short mapLen, unsigned short palIndex, unsigned short sbb);
void initialize();

void waitForVblank();
void flipPage();
# 89 "myLib.h"
extern unsigned int oldButtons;
extern unsigned int buttons;
# 99 "myLib.h"
void DMANow(int channel, volatile const void* source, volatile void* destination, unsigned int control);






typedef volatile struct
{
        volatile const void *src;
        volatile void *dst;
        volatile unsigned int cnt;
} DMA;

extern DMA *dma;
# 138 "myLib.h"
enum {IDLE, CHASE, FLEE};
# 235 "myLib.h"
typedef struct { u16 tileimg[8192]; } charblock;
typedef struct { u16 tilemap[1024]; } screenblock;
# 293 "myLib.h"
typedef struct{
    unsigned short attr0;
    unsigned short attr1;
    unsigned short attr2;
    unsigned short fill;
}OBJ_ATTR;




void initialize();
void splash();
void instruct();
void game();
void win();
void lose();
void pause();

void animate();
void hideSprites();
void updateOAM();

void setupSounds();
void playSoundA(const unsigned char*, int, int);
void playSoundB(const unsigned char*, int, int);
void pauseSound();
void unpauseSound();
void stopSound();
void setupInterrupts();
void interruptHandler();
void updateVasePos();
void vaseCollision();
void resetGame();
# 18 "main.c" 2
# 1 "Reggie.h" 1
# 21 "Reggie.h"
extern const unsigned short ReggieTiles[16384];


extern const unsigned short ReggiePal[256];
# 19 "main.c" 2
# 1 "text.h" 1
# 10 "text.h"
void drawChar3(int row, int col, char ch, unsigned short color);
void drawString3(int row, int col, char *str, unsigned short color);


void drawChar4(int row, int col, char ch, unsigned char colorIndex);
void drawString4(int row, int col, char *str, unsigned char colorIndex);

extern const unsigned char fontdata_6x8[12288];
# 20 "main.c" 2
# 1 "kitchen_floor.h" 1
# 22 "kitchen_floor.h"
extern const unsigned short kitchen_floorTiles[64];


extern const unsigned short kitchen_floorMap[1024];


extern const unsigned short kitchen_floorPal[256];
# 21 "main.c" 2
# 1 "kitchen.h" 1
# 21 "kitchen.h"
extern const unsigned short kitchenTiles[528];


extern const unsigned short kitchenMap[1024];
# 22 "main.c" 2
# 1 "splash.h" 1
# 21 "splash.h"
extern const unsigned short splashBitmap[19200];


extern const unsigned short splashPal[256];
# 23 "main.c" 2
# 1 "instruct.h" 1
# 21 "instruct.h"
extern const unsigned short instructBitmap[19200];


extern const unsigned short instructPal[256];
# 24 "main.c" 2
# 1 "pause.h" 1
# 21 "pause.h"
extern const unsigned short pauseBitmap[19200];


extern const unsigned short pausePal[256];
# 25 "main.c" 2
# 1 "win.h" 1
# 21 "win.h"
extern const unsigned short winBitmap[19200];


extern const unsigned short winPal[256];
# 26 "main.c" 2
# 1 "TitleSong.h" 1
# 20 "TitleSong.h"
extern const unsigned char TitleSong[447027];
# 27 "main.c" 2
# 1 "GameSong.h" 1
# 20 "GameSong.h"
extern const unsigned char GameSong[195382];
# 28 "main.c" 2
# 1 "StartSFX.h" 1
# 20 "StartSFX.h"
extern const unsigned char StartSFX[127296];
# 29 "main.c" 2

unsigned int buttons;
unsigned int oldButtons;

int score = 0;

int hOff = 0;
int vOff = 0;
int sbb;
int seed = 0;

OBJ_ATTR shadowOAM[128];




typedef struct
{
 int row;
 int col;
 int bigRow;
 int bigCol;
 int rdel;
 int cdel;
 int width;
 int height;
 int aniCounter;
 int aniState;
 int prevAniState;
 int frameDirection;
    int currFrame;
    int hide;
} SPRITE;

SPRITE reggie;

int numVases = 1;
SPRITE vase[2];

typedef struct{
    const unsigned char* data;
    int length;
    int frequency;
    int isPlaying;
    int loops;
    int duration;
    int priority;
    int vbCount;
}SOUND;

SOUND soundA;
SOUND soundB;

void animate();
void hideSprites();
void updateOAM();

enum {REGGIERIGHT, REGGIELEFT, REGGIEIDLE};


enum {SPLASH, INSTRUCT, GAME, WIN, LOSE, PAUSE};
int state;


enum {BLACKINDEX, REDINDEX, BLUEINDEX, GREENINDEX, WHITEINDEX};

int main()
{
 hideSprites();
 initialize();

 setupSounds();
 setupInterrupts();
    playSoundA(TitleSong,447027,11025);
    soundA.loops = 1;

 state = SPLASH;

 while(1)
 {
  oldButtons = buttons;
  buttons = *(volatile unsigned int *)0x04000130;



  switch(state)
  {
   case SPLASH:
    splash();
   break;

   case INSTRUCT:
    instruct();
   break;

   case GAME:
    game();
   break;

   case WIN:
    win();
   break;

   case LOSE:
    lose();
   break;

   case PAUSE:
    pause();
   break;
  }

  waitForVblank();
 }

 return 0;
}

void initialize()
{

 reggie.width = 32;
 reggie.height = 16;
 reggie.rdel = 1;
 reggie.cdel = 1;
 reggie.row = 160/2-reggie.width/2;
 reggie.col = 160/2-reggie.height/2;
 reggie.aniCounter = 0;
 reggie.currFrame = 0;
 reggie.aniState = REGGIERIGHT;

 for (int i = 0; i < numVases; i++)
 {
  vase[i].width = 8;
  vase[i].height = 16;
  vase[i].bigRow = 100;
  vase[i].bigCol = 100 * i;
  vase[i].hide = 0;
  vase[i].aniState = 0;
 }
}

void splash()
{
 *(unsigned short *)0x4000000 = 4 | (1<<10) | (1<<4);
 loadPalette(splashPal);




 drawBackgroundImage4(splashBitmap);
 flipPage();
 drawBackgroundImage4(splashBitmap);

 seed++;

 if ((!(~(oldButtons)&((1<<3))) && (~buttons & ((1<<3)))))
 {
  pauseSound();
  srand(seed);
  *(unsigned short *)0x4000000 = 4 | (1<<10) | (1<<4);
  state = INSTRUCT;
 }
}

void instruct()
{
 unpauseSound();

 loadPalette(instructPal);

 drawBackgroundImage4(instructBitmap);
 flipPage();
 drawBackgroundImage4(instructBitmap);




 if ((!(~(oldButtons)&((1<<2))) && (~buttons & ((1<<2)))))
 {
  *(unsigned short *)0x4000000 = 4 | (1<<10) | (1<<4);
  state = SPLASH;
 }

 if ((!(~(oldButtons)&((1<<3))) && (~buttons & ((1<<3)))))
 {
  stopSound();
  playSoundA(GameSong, 195382, 11025);
  playSoundB(StartSFX, 127296, 11025);

  *(unsigned short *)0x4000000 = 0 | (1<<8) | (1<<9) | (1 << 12);
  *(volatile unsigned short*)0x4000008 = 0<<14 | 1 << 2 | 27 << 8;
  *(volatile unsigned short*)0x400000A = 0<<14 | 0 << 2 | 29 << 8;

  loadPalette(kitchen_floorPal);
  DMANow(3, kitchen_floorTiles, &((charblock *)0x6000000)[0], (128/2));
  DMANow(3, kitchen_floorMap, &((screenblock *)0x6000000)[29], (2048/2));
  DMANow(3, kitchenTiles, &((charblock *)0x6000000)[1], (1056/2));

  loadMap(kitchenMap, (2048/2), 1, 27);

  DMANow(3, ReggieTiles, &((charblock *)0x6000000)[4], 32768/2);
  DMANow(3, ReggiePal, ((unsigned short*)(0x5000200)), 512/2);

  state = GAME;
 }
}

void game()
{
 animate();
 updateOAM();
 DMANow(3, shadowOAM, ((OBJ_ATTR*)(0x7000000)), 512);

 *(volatile unsigned short *)0x04000010 = hOff;
 *(volatile unsigned short *)0x04000014 = hOff;
 *(volatile unsigned short *)0x04000012 = vOff;
 *(volatile unsigned short *)0x04000016 = vOff;

 updateVasePos();
 vaseCollision();

 if ((~(*(volatile unsigned int *)0x04000130) & ((1<<4))))
 {
  hOff++;

  if (hOff == 200)
  {
   stopSound();
   *(unsigned short *)0x4000000 = 4 | (1<<10) | (1<<4);
   state = WIN;
  }
 }

 if ((~(*(volatile unsigned int *)0x04000130) & ((1<<7))))
 {
  if (vOff < 160) vOff++;
 }

 if ((~(*(volatile unsigned int *)0x04000130) & ((1<<5))))
 {
  hOff--;
 }

 if ((~(*(volatile unsigned int *)0x04000130) & ((1<<6))))
 {
  vOff--;
 }

 if ((!(~(oldButtons)&((1<<3))) && (~buttons & ((1<<3)))))
 {
  *(unsigned short *)0x4000000 = 4 | (1<<10) | (1<<4);
  state = PAUSE;
 }
}

void win()
{
 loadPalette(winPal);
 drawBackgroundImage4(winBitmap);
 flipPage();
 drawBackgroundImage4(winBitmap);


 if ((!(~(oldButtons)&((1<<3))) && (~buttons & ((1<<3)))))
 {

  *(unsigned short *)0x4000000 = 4 | (1<<10) | (1<<4);
  state = SPLASH;
 }
}

void lose()
{
 drawString4(50, 50, "LOSE", WHITEINDEX);

 if ((!(~(oldButtons)&((1<<3))) && (~buttons & ((1<<3)))))
 {
  *(unsigned short *)0x4000000 = 4 | (1<<10) | (1<<4);
  state = SPLASH;
 }
}

void pause()
{

 loadPalette(pausePal);





 drawBackgroundImage4(pauseBitmap);
 flipPage();
 drawBackgroundImage4(pauseBitmap);


 if ((!(~(oldButtons)&((1<<2))) && (~buttons & ((1<<2)))))
 {
  *(unsigned short *)0x4000000 = 4 | (1<<10) | (1<<4);
  resetGame();
  state = SPLASH;
 }

 if ((!(~(oldButtons)&((1<<3))) && (~buttons & ((1<<3)))))
 {

  *(unsigned short *)0x4000000 = 0 | (1<<8) | (1<<9) | (1 << 12);
  *(volatile unsigned short*)0x4000008 = 0<<14 | 1 << 2 | 27 << 8;
  *(volatile unsigned short*)0x400000A = 0<<14 | 0 << 2 | 29 << 8;

  loadPalette(kitchen_floorPal);
  DMANow(3, kitchen_floorTiles, &((charblock *)0x6000000)[0], (128/2));
  DMANow(3, kitchen_floorMap, &((screenblock *)0x6000000)[29], (2048/2));
  DMANow(3, kitchenTiles, &((charblock *)0x6000000)[1], (1056/2));

  loadMap(kitchenMap, (2048/2), 1, 27);

  DMANow(3, ReggieTiles, &((charblock *)0x6000000)[4], 32768/2);
  DMANow(3, ReggiePal, ((unsigned short*)(0x5000200)), 512/2);

  state = GAME;
 }
}

void animate()
{
    reggie.aniState = REGGIEIDLE;

    if(reggie.aniCounter % 20 == 0)
    {
  reggie.aniCounter = 0;
  if (reggie.currFrame == 2) reggie.currFrame = 0;
  else reggie.currFrame++;
    }

    if((~(*(volatile unsigned int *)0x04000130) & ((1<<4))))
 {
  reggie.aniState = REGGIERIGHT;
 }

    if((~(*(volatile unsigned int *)0x04000130) & ((1<<5))))
 {
  reggie.aniState = REGGIELEFT;
 }

    if(reggie.aniState == REGGIEIDLE)
 {
        reggie.currFrame = 0;
        reggie.aniState = reggie.prevAniState;
 }
    else
 {
  reggie.prevAniState = reggie.aniState;
        reggie.aniCounter++;
 }
}

void hideSprites()
{
 for (int i = 0; i < 128; i++)
 {
  shadowOAM[i].attr0 = (2 << 8);
 }
}

void updateOAM()
{
 shadowOAM[0].attr0 = (0xFF & reggie.row) | (0 << 13) | (1 << 14);
 shadowOAM[0].attr1 = (0x1FF & reggie.col) | (2 << 14);
 shadowOAM[0].attr2 = (2*reggie.currFrame)*32+(3*reggie.aniState);

 for (int i = 0; i < numVases; i++)
 {
  shadowOAM[i+1].attr0 = (0xFF & vase[i].row) | (0 << 13) | (2 << 14);
  if (vase[i].hide)
  {
   shadowOAM[i+1].attr0 |= (2 << 8);
  }
  shadowOAM[i+1].attr1 = (0x1FF & vase[i].col) | (0 << 14);
  if (vase[i].aniState == 0)
  {
   shadowOAM[i+1].attr2 = (0)*32+(8);
  } else {
   shadowOAM[i+1].attr2 = (0)*32+(9);
  }
 }
}

void setupSounds()
{
    *(volatile u16 *)0x04000084 = (1<<7);

 *(volatile u16*)0x04000082 = (1<<1) |
                     (1<<2) |
                     (3<<8) |
                     0 |
                     (1<<11) |
                     (1<<3) |
                     (3<<12) |
                     (1<<14) |
                     (1<<15);

 *(u16*)0x04000080 = 0;
}

void playSoundA( const unsigned char* sound, int length, int frequency) {
# 453 "main.c"
}


void playSoundB( const unsigned char* sound, int length, int frequency) {
# 474 "main.c"
}

void pauseSound()
{
 *(volatile unsigned short*)0x4000102 = 0;
 soundA.isPlaying = 0;

 *(volatile unsigned short*)0x4000106 = 0;
 soundB.isPlaying = 0;
}

void unpauseSound()
{
 *(volatile unsigned short*)0x4000102 = (1<<7);
 soundA.isPlaying = 1;

 *(volatile unsigned short*)0x4000106 = (1<<7);
 soundB.isPlaying = 1;
}

void stopSound()
{
    dma[1].cnt = 0;
    *(volatile unsigned short*)0x4000102 = 0;
    soundA.isPlaying = 0;

    dma[2].cnt = 0;
    *(volatile unsigned short*)0x4000106 = 0;
    soundB.isPlaying = 1;
}

void setupInterrupts()
{
 *(unsigned short*)0x4000208 = 0;
 *(unsigned int*)0x3007FFC = (unsigned int) interruptHandler;

 *(unsigned short*)0x4000200 |= 1 << 0;
 *(unsigned short*)0x4000004 |= 1 << 3;
 *(unsigned short*)0x4000208 = 1;
}

void interruptHandler()
{
 *(unsigned short*)0x4000208 = 0;
 if(*(volatile unsigned short*)0x4000202 & 1 << 0)
 {
  if (soundA.isPlaying)
  {
   if (soundA.vbCount >= soundA.duration)
   {
    if (soundA.loops)
    {
     playSoundA(soundA.data, soundA.length, soundA.frequency);
    }
    else
    {
     dma[1].cnt = 0;
     *(volatile unsigned short*)0x4000102 = 0;
     soundA.isPlaying = 0;
    }
   }

   soundA.vbCount++;
  }

  if (soundB.isPlaying)
  {
   if (soundB.vbCount >= soundB.duration)
   {
    if (soundB.loops)
    {
     playSoundB(soundB.data, soundB.length, soundB.frequency);
    }
    else
    {
     dma[2].cnt = 0;
     *(volatile unsigned short*)0x4000106 = 0;
     soundB.isPlaying = 0;
    }
   }

   soundB.vbCount++;
  }

  *(volatile unsigned short*)0x4000202 = 1 << 0;
 }

 *(unsigned short*)0x4000208 = 1;
}

void updateVasePos()
{
 for (int i = 0; i < numVases; i++)
 {
  vase[i].row = vase[i].bigRow - vOff;
  vase[i].col = vase[i].bigCol - hOff;

  if (vase[i].row < 0 || vase[i].col + vase[i].width < 0 || vase[i].row > 160 || vase[i].col > 240)
  {
   vase[i].hide = 1;
  } else {
   vase[i].hide = 0;
  }
 }
}

void vaseCollision()
{
 for (int i = 0; i < numVases; i++)
 {

  if ((reggie.col + reggie.width > vase[i].col) && (reggie.col < vase[i].col + vase[i].width) &&
     (reggie.row < vase[i].row + vase[i].height) && (reggie.row + reggie.height > vase[i].row))
  {
   vase[i].aniState = 1;
  }


  if ((vase[i].col + vase[i].width > reggie.col) && (reggie.col + reggie.width > vase[i].col) &&
   (reggie.row < vase[i].row + vase[i].height) && (reggie.row + reggie.height > vase[i].row))

  {
   vase[i].aniState = 1;
  }


  if ((reggie.row < vase[i].row + vase[i].height) && (reggie.col < vase[i].col) &&
   (reggie.col + reggie.width > vase[i].col + vase[i].width && (reggie.row + reggie.height > vase[i].row)))
  {
   vase[i].aniState = 1;
  }
 }
}

void resetGame()
{
 initialize();
 hOff = 0;
 vOff = 0;
 score = 0;
}
