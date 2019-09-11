//this assembly program write an array of colors top the top row

		//loop from 0 to less than 0x24
		//copy from array at i
		//stage values for vga_start
		//call vga_start
		
			call fillblack.start  fillblack.end
vgaDrawTest.loop	be vgaDrawTest.end vgaDrawTest.i vgaDrawTest.elem_num
			cp vgaDriver.x1 vgaDrawTest.i
			cp vgaDriver.x2 vgaDrawTest.i
			cp vgaDriver.y1 vgaDriver.num0
			cp vgaDriver.y2 vgaDrawTest.num4
			cpfa vgaDriver.rgb vgaDrawTest.colorarr vgaDrawTest.i		
			call vgaDriver.start vgaDriver.end
			add vgaDrawTest.i vgaDrawTest.i vgaDriver.num1
			be vgaDrawTest.loop vgaDriver.num0 vgaDriver.num0

vgaDrawTest.end		halt

vgaDrawTest.num4		4
vgaDrawTest.i		0x0
vgaDrawTest.elem_num	36
vgaDrawTest.colorarr	0xff0000
		0xff0000
		0xff0000
		0xff0000
		0xff0000
		0xff0000
		0xff0000
                0xff0000
                0xff0000
                0xff0000
                0xff0000
                0xff0000
		0xff0000
		0xff00
		0xff00
		0xff00
		0xff00
                0xff00
                0xff00
		0xff00
                0xff00
                0xff00
		0xff00
                0xff00
                0xff00
		0xff
		0xff
		0xff
		0xff
		0xff
                0xff
                0xff
                0xff
		0xff
                0xff
                0xff
                0xff
#include fillblack.e









