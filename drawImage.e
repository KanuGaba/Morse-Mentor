		
drawImage.start         cpfa drawImage.pxIndex images.images drawImage.imageIndex 

			//copy our given start x and y to incrementX and incrementY
			cp drawImage.incrementX drawImage.x
			cp drawImage.incrementY drawImage.y
			//set our max x and y to x+scale*width
			//and y+scale*height (not using -1) then scale
			mult drawImage.maxX drawImage.width drawImage.scale
			add drawImage.maxX drawImage.maxX drawImage.x
			mult drawImage.maxY drawImage.height drawImage.scale
			add drawImage.maxY drawImage.maxY drawImage.y

drawImage.loop		cp vgaDriver.x1 drawImage.incrementX		
			cp vgaDriver.x2 drawImage.incrementX
			cp vgaDriver.y1 drawImage.incrementY
			cp vgaDriver.y2 drawImage.incrementY
			//assuming x1 and y1 are in the corner we want, 
			//we can then account for scaling by shifting x2 and y2
			add vgaDriver.x2 vgaDriver.x2 drawImage.scale
			add vgaDriver.y2 vgaDriver.y2 drawImage.scale

			//write the rgb value to the driver from the array
			cpfa vgaDriver.rgb 0 drawImage.pxIndex
			
			//if we don't ignore white, then draw
			be drawImage.draw drawImage.ignoreWhite drawImage.num0
			blt drawImage.skip drawImage.whiteThresh vgaDriver.rgb
			//call driver to draw that one pixel
drawImage.draw		call vgaDriver.start vgaDriver.end
			
			//increment our incrementer
drawImage.skip		add drawImage.pxIndex drawImage.pxIndex vgaDriver.num1
			//increment x
			add drawImage.incrementX drawImage.incrementX drawImage.scale
			//if we havent reach maxX, loop again. else, see if y needs to be changed
			blt drawImage.loop drawImage.incrementX drawImage.maxX 
			cp drawImage.incrementX drawImage.x
			//increment y
			add drawImage.incrementY drawImage.incrementY drawImage.scale
			blt drawImage.loop drawImage.incrementY drawImage.maxY 
			//if x and y have reached max, then its time to stop
			ret drawImage.end
			halt
//not parameters
drawImage.incrementX	0
drawImage.incrementY	0
drawImage.maxX		0
drawImage.maxY		0	
drawImage.pxIndex	0
drawImage.letterAddr	0
drawImage.num0		0
drawImage.whiteThresh	0xf6f6f6	

//parameters passed in
drawImage.end		0
drawImage.x		0
drawImage.y		0
drawImage.width		0
drawImage.height	0
drawImage.imageIndex  	0
drawImage.ignoreWhite	0
drawImage.scale		1
//optional if you dont want default white font
drawImage.color	0xf8f8f8

#include images.e
