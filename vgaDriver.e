//goal for vgaDriver: write to x,y coordinate given a color
//to call our driver, we setup x1, x2, y1, y2, rgb, vga_ret, and "call vga_start vga_ret"
//where vgaDriver.e is return address

vgaDriver.start		cp 0x80000062 vgaDriver.num1		
			cp 0x80000067 vgaDriver.rgb
		
//set vga_color_write to passed rgb value
			cp 0x80000063 vgaDriver.x1
			cp 0x80000065 vgaDriver.x2
			cp 0x80000064 vgaDriver.y1
			cp 0x80000066 vgaDriver.y2
//ready to have signal read

			cp 0x80000060 vgaDriver.num1		
vgaDriver.check		be vgaDriver.command0 0x80000061 vgaDriver.num1	

//if response, set command 0
vgaDriver.wait		be vgaDriver.check vgaDriver.num0 vgaDriver.num0		

//else, we go back to check again

vgaDriver.command0	cp 0x80000060 vgaDriver.num0		
//set command 0
vgaDriver.resp0		bne vgaDriver.resp0 0x80000061 vgaDriver.num0
			ret vgaDriver.end
			halt
		
vgaDriver.num0		0x0
vgaDriver.num1		0x1
vgaDriver.resp		0x0

//variables instantiated in other contexts
vgaDriver.x1		0x0
vgaDriver.x2		0x0
vgaDriver.y1		0x0
vgaDriver.y2		0x0
vgaDriver.rgb		0x0	//a true color 24-bit number that has each of our rgb values
vgaDriver.end		0x0
