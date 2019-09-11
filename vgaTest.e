 //To test your device driver, write a trivial test program that initializes     the input parameters (if any), calls the device driver, displays the output     parameters (if any) to the hex digits, then halts

		cp vgaDriver.x1 vgaDriver.num0
		cp vgaDriver.x2 vgaTest.max_w
		cp vgaDriver.y1 vgaDriver.num0
		cp vgaDriver.y2 vgaTest.max_h
		cp vgaDriver.rgb vgaDriver.num0
		call vgaDriver.start vgaTest.end
vgaTest.end	halt

vgaTest.max_w		0x2f
vgaTest.max_h		0x2f

//include driver at END
#include vgaDriver.e

