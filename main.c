/**********************************

In my game you are the cat, Reggie. Your goal is to
destroy as many things in the room as possible before
your humans get home (the timer runs out). If you get
a certain number of points you will advance to the next
room (the next level).

Right now, Reggie is a rectangle with arrows indivcating
the direction he is facing. There are also rectangles that
represent different pieces of destructable furniture.

Hold down the left arrow key (for a bit) to win :)

**********************************/

#include "myLib.h"
#include "Reggie.h"
#include "text.h"
#include "kitchen_floor.h"
#include "kitchen.h"
#include "splash.h"
#include "instruct.h"
#include "pause.h"
#include "win.h"
#include "TitleSong.h"
#include "GameSong.h"
#include "StartSFX.h"

unsigned int buttons;
unsigned int oldButtons;

int score = 0;

int hOff = 0;
int vOff = 0;
int sbb;
int seed = 0;

OBJ_ATTR shadowOAM[128];

#define ROWMASK 0xFF
#define COLMASK 0x1FF

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

//game states
enum {SPLASH, INSTRUCT, GAME, WIN, LOSE, PAUSE};
int state;

//color indices - TEMPORARY
enum {BLACKINDEX, REDINDEX, BLUEINDEX, GREENINDEX, WHITEINDEX};

int main()
{
	hideSprites();
	initialize();

	setupSounds();
	setupInterrupts();
    playSoundA(TitleSong,TITLESONGLEN,TITLESONGFREQ);
    soundA.loops = 1;

	state = SPLASH;

	while(1)
	{
		oldButtons = buttons;
		buttons = BUTTONS;

		//fillScreen4(BLACKINDEX);

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
	//REGGIE DATA
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
		vase[i].bigRow = 100; //replace with 'seed'
		vase[i].bigCol = 100 * i; //replace with 'seed'
		vase[i].hide = 0;
		vase[i].aniState = 0;
	}
}

void splash()
{
	REG_DISPCTL = MODE4 | BG2_ENABLE | BACKBUFFER;
	loadPalette(splashPal);

	// drawString4(50, 50, "SPLASH", WHITEINDEX);
	// drawString4(60, 50, "Hit enter to continue", WHITEINDEX);

	drawBackgroundImage4(splashBitmap);
	flipPage();
	drawBackgroundImage4(splashBitmap);

	seed++;

	if (BUTTON_PRESSED(BUTTON_START)) //enter
	{
		pauseSound();
		srand(seed);
		REG_DISPCTL = MODE4 | BG2_ENABLE | BACKBUFFER;
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
	// drawString4(50, 50, "INSTRUCT", WHITEINDEX);
	// drawString4(60, 50, "Select to go back.", WHITEINDEX);
	// zdrawString4(70, 50, "Start to continue.", WHITEINDEX);

	if (BUTTON_PRESSED(BUTTON_SELECT)) //backspace
	{
		REG_DISPCTL = MODE4 | BG2_ENABLE | BACKBUFFER;
		state = SPLASH;
	}

	if (BUTTON_PRESSED(BUTTON_START)) //enter
	{
		stopSound();
		playSoundA(GameSong, GAMESONGLEN, GAMESONGFREQ);
		playSoundB(StartSFX, STARTSFXLEN, STARTSFXFREQ);

		REG_DISPCTL = MODE0 | BG0_ENABLE | BG1_ENABLE | SPRITE_ENABLE;
		REG_BG0CNT = BG_SIZE0 | CBB(1) | SBB(27);
		REG_BG1CNT = BG_SIZE0 | CBB(0) | SBB(29);

		loadPalette(kitchen_floorPal);
		DMANow(3, kitchen_floorTiles, &CHARBLOCKBASE[0], (kitchen_floorTilesLen/2));
		DMANow(3, kitchen_floorMap, &SCREENBLOCKBASE[29], (kitchen_floorMapLen/2));
		DMANow(3, kitchenTiles, &CHARBLOCKBASE[1], (kitchenTilesLen/2));
		// DMANow(3, kitchenMap, &SCREENBLOCKBASE[27], (kitchenMapLen/2));
		loadMap(kitchenMap, (kitchenMapLen/2), 1, 27);

		DMANow(3, ReggieTiles, &CHARBLOCKBASE[4], ReggieTilesLen/2);
		DMANow(3, ReggiePal, SPRITE_PALETTE, ReggiePalLen/2);

		state = GAME;
	}
}

void game()
{
	animate();
	updateOAM();
	DMANow(3, shadowOAM, OAM, 512);

	REG_BG0HOFS = hOff;
	REG_BG1HOFS = hOff;
	REG_BG0VOFS = vOff;
	REG_BG1VOFS = vOff;

	updateVasePos();
	vaseCollision();

	if (BUTTON_HELD(BUTTON_RIGHT))
	{
		hOff++;

		if (hOff == 200)
		{
			stopSound();
			REG_DISPCTL = MODE4 | BG2_ENABLE | BACKBUFFER;
			state = WIN;
		}
	}

	if (BUTTON_HELD(BUTTON_DOWN))
	{
		if (vOff < 160) vOff++;
	}

	if (BUTTON_HELD(BUTTON_LEFT))
	{
		hOff--;
	}

	if (BUTTON_HELD(BUTTON_UP))
	{
		vOff--;
	}

	if (BUTTON_PRESSED(BUTTON_START)) //enter
	{
		REG_DISPCTL = MODE4 | BG2_ENABLE | BACKBUFFER;
		state = PAUSE;
	}
}

void win()
{
	loadPalette(winPal);
	drawBackgroundImage4(winBitmap);
	flipPage();
	drawBackgroundImage4(winBitmap);
	// drawString4(50, 50, "WIN", WHITEINDEX);

	if (BUTTON_PRESSED(BUTTON_START)) //enter
	{

		REG_DISPCTL = MODE4 | BG2_ENABLE | BACKBUFFER;
		state = SPLASH;
	}
}

void lose()
{
	drawString4(50, 50, "LOSE", WHITEINDEX);

	if (BUTTON_PRESSED(BUTTON_START)) //enter
	{
		REG_DISPCTL = MODE4 | BG2_ENABLE | BACKBUFFER;
		state = SPLASH;
	}
}

void pause()
{
	// REG_DISPCTL = MODE4 | BG2_ENABLE | BACKBUFFER;
	loadPalette(pausePal);

	// drawString4(50, 50, "PAUSE", WHITEINDEX);
	// drawString4(60, 50, "Start to continue.", WHITEINDEX);
	// drawString4(70, 50, "Select to restart.", WHITEINDEX);

	drawBackgroundImage4(pauseBitmap);
	flipPage();
	drawBackgroundImage4(pauseBitmap);

	/* NOT WORKING!!!! */
	if (BUTTON_PRESSED(BUTTON_SELECT)) //backspace
	{
		REG_DISPCTL = MODE4 | BG2_ENABLE | BACKBUFFER;
		resetGame();
		state = SPLASH;
	}

	if (BUTTON_PRESSED(BUTTON_START)) //enter
	{

		REG_DISPCTL = MODE0 | BG0_ENABLE | BG1_ENABLE | SPRITE_ENABLE;
		REG_BG0CNT = BG_SIZE0 | CBB(1) | SBB(27);
		REG_BG1CNT = BG_SIZE0 | CBB(0) | SBB(29);

		loadPalette(kitchen_floorPal);
		DMANow(3, kitchen_floorTiles, &CHARBLOCKBASE[0], (kitchen_floorTilesLen/2));
		DMANow(3, kitchen_floorMap, &SCREENBLOCKBASE[29], (kitchen_floorMapLen/2));
		DMANow(3, kitchenTiles, &CHARBLOCKBASE[1], (kitchenTilesLen/2));
		// DMANow(3, kitchenMap, &SCREENBLOCKBASE[27], (kitchenMapLen/2));
		loadMap(kitchenMap, (kitchenMapLen/2), 1, 27);

		DMANow(3, ReggieTiles, &CHARBLOCKBASE[4], ReggieTilesLen/2);
		DMANow(3, ReggiePal, SPRITE_PALETTE, ReggiePalLen/2);

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

    if(BUTTON_HELD(BUTTON_RIGHT))
	{
		reggie.aniState = REGGIERIGHT;
	}

    if(BUTTON_HELD(BUTTON_LEFT))
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
		shadowOAM[i].attr0 = ATTR0_HIDE;
	}
}

void updateOAM() 
{
	shadowOAM[0].attr0 = (ROWMASK & reggie.row) | ATTR0_4BPP | ATTR0_WIDE;
	shadowOAM[0].attr1 = (COLMASK & reggie.col) | ATTR1_SIZE32;
	shadowOAM[0].attr2 = SPRITEOFFSET16(2*reggie.currFrame, 3*reggie.aniState);

	for (int i = 0; i < numVases; i++)
	{
		shadowOAM[i+1].attr0 = (ROWMASK & vase[i].row) | ATTR0_4BPP | ATTR0_TALL;
		if (vase[i].hide)
		{
			shadowOAM[i+1].attr0 |= ATTR0_HIDE;
		}
		shadowOAM[i+1].attr1 = (COLMASK & vase[i].col) | ATTR1_SIZE8;
		if (vase[i].aniState == 0)
		{
			shadowOAM[i+1].attr2 = SPRITEOFFSET16(0, 8);
		} else {
			shadowOAM[i+1].attr2 = SPRITEOFFSET16(0, 9);
		}
	}
}

void setupSounds()
{
    REG_SOUNDCNT_X = SND_ENABLED;

	REG_SOUNDCNT_H = SND_OUTPUT_RATIO_100 | 
                     DSA_OUTPUT_RATIO_100 | 
                     DSA_OUTPUT_TO_BOTH | 
                     DSA_TIMER0 | 
                     DSA_FIFO_RESET |
                     DSB_OUTPUT_RATIO_100 | 
                     DSB_OUTPUT_TO_BOTH | 
                     DSB_TIMER1 | 
                     DSB_FIFO_RESET;

	REG_SOUNDCNT_L = 0;
}

void playSoundA( const unsigned char* sound, int length, int frequency) {
        // dma[1].cnt = 0;
	
        // int ticks = PROCESSOR_CYCLES_PER_SECOND/frequency;
	
        // DMANow(1, sound, REG_FIFO_A, DMA_DESTINATION_FIXED | DMA_AT_REFRESH | DMA_REPEAT | DMA_32);
	
        // REG_TM0CNT = 0;
	
        // REG_TM0D = -ticks;
        // REG_TM0CNT = TIMER_ON;
	
        // soundA.data = sound;
        // soundA.length = length;
        // soundA.frequency = frequency;
        // soundA.duration = ((VBLANK_FREQ*length)/frequency);
        // soundA.isPlaying = 1;
        // soundA.vbCount = 0;         
}


void playSoundB( const unsigned char* sound, int length, int frequency) {
        // dma[2].cnt = 0;

        // int ticks = PROCESSOR_CYCLES_PER_SECOND/frequency;

        // DMANow(2, sound, REG_FIFO_B, DMA_DESTINATION_FIXED | DMA_AT_REFRESH | DMA_REPEAT | DMA_32);

        // REG_TM1CNT = 0;
	
        // REG_TM1D = -ticks;
        // REG_TM1CNT = TIMER_ON;
	
        // soundB.data = sound;
        // soundB.length = length;
        // soundB.frequency = frequency;
        // soundB.duration = ((VBLANK_FREQ*length)/frequency);
        // soundB.isPlaying = 1;
        // soundB.vbCount = 0;
}

void pauseSound()
{
	REG_TM0CNT = 0;
	soundA.isPlaying = 0;

	REG_TM1CNT = 0;
	soundB.isPlaying = 0;
}

void unpauseSound()
{
	REG_TM0CNT = TIMER_ON;
	soundA.isPlaying = 1;

	REG_TM1CNT = TIMER_ON;
	soundB.isPlaying = 1;
}

void stopSound()
{
    dma[1].cnt = 0;
    REG_TM0CNT = 0;
    soundA.isPlaying = 0;

    dma[2].cnt = 0;
    REG_TM1CNT = 0;
    soundB.isPlaying = 1;
}

void setupInterrupts()
{
	REG_IME = 0;
	REG_INTERRUPT = (unsigned int) interruptHandler;

	REG_IE |= INT_VBLANK;
	REG_DISPSTAT |= INT_VBLANK_ENABLE;
	REG_IME = 1;
}

void interruptHandler()
{
	REG_IME = 0;
	if(REG_IF & INT_VBLANK)
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
					REG_TM0CNT = 0;
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
					REG_TM1CNT = 0;
					soundB.isPlaying = 0;
				}
			}

			soundB.vbCount++;
		}

		REG_IF = INT_VBLANK; 
	}

	REG_IME = 1;
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
		//Reggie right, vase left
		if ((reggie.col + reggie.width > vase[i].col) && (reggie.col < vase[i].col + vase[i].width) && 
		   (reggie.row < vase[i].row + vase[i].height) && (reggie.row + reggie.height > vase[i].row))
		{
			vase[i].aniState = 1;
		}

		//Reggie left, vase right
		if ((vase[i].col + vase[i].width > reggie.col) && (reggie.col + reggie.width > vase[i].col) && 
			(reggie.row < vase[i].row + vase[i].height) && (reggie.row + reggie.height > vase[i].row))

		{
			vase[i].aniState = 1;
		}

		//Reggie top, vase bottom
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