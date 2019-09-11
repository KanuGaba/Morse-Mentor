		
fillScreen.start	cp vgaDriver.x1 vgaDriver.num0
			cp vgaDriver.x2 fillScreen.maxW
			cp vgaDriver.y1 vgaDriver.num0
			cp vgaDriver.y2 fillScreen.maxH
			cp vgaDriver.rgb fillScreen.color
			call vgaDriver.start vgaDriver.end
			ret fillScreen.end
			halt

fillScreen.end		0
fillScreen.maxW		0x27f
fillScreen.maxH		0x1df
fillScreen.color	0

#include vgaDriver.e

