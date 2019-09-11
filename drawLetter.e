		
drawLetter.start       cpfa drawLetter.pxIndex letters.letters drawLetter.letterIndex 

			//copy our given start x and y to incrementX and incrementY
			cp drawLetter.incrementX drawLetter.x
			cp drawLetter.incrementY drawLetter.y
			//set our max x and y to x+scale*width
			//and y+scale*height (not using -1) then scale
			mult drawLetter.maxX drawLetter.width drawLetter.scale
			add drawLetter.maxX drawLetter.maxX drawLetter.x
			mult drawLetter.maxY drawLetter.height drawLetter.scale
			add drawLetter.maxY drawLetter.maxY drawLetter.y

//we need to make x1 and x2 the same since we are drawing pixel by pixel
drawLetter.loop		cp vgaDriver.x1 drawLetter.incrementX		
			cp vgaDriver.x2 drawLetter.incrementX
			cp vgaDriver.y1 drawLetter.incrementY
			cp vgaDriver.y2 drawLetter.incrementY
			//assuming x1 and y1 are in the corner we want, 
			//we can then account for scaling by shifting x2 and y2
			add vgaDriver.x2 vgaDriver.x2 drawLetter.scale
			add vgaDriver.y2 vgaDriver.y2 drawLetter.scale

			//write the rgb value to the driver from the array
			cpfa vgaDriver.rgb 0 drawLetter.pxIndex
			//if we dont get a non-white background pixel, ignore it!
			bne drawLetter.skipPx vgaDriver.rgb vgaDriver.num0
			//else, we can reset rgb to be a custom color!
			cp vgaDriver.rgb drawLetter.color
			//call driver to draw that one pixel
			call vgaDriver.start vgaDriver.end
			
			//increment our incrementer
drawLetter.skipPx	add drawLetter.pxIndex drawLetter.pxIndex vgaDriver.num1
			//increment x
			add drawLetter.incrementX drawLetter.incrementX drawLetter.scale
			//if we havent reach maxX, loop again. else, see if y needs to be changed
			blt drawLetter.loop drawLetter.incrementX drawLetter.maxX 
			cp drawLetter.incrementX drawLetter.x
			//increment y
			add drawLetter.incrementY drawLetter.incrementY drawLetter.scale
			blt drawLetter.loop drawLetter.incrementY drawLetter.maxY 
			//if x and y have reached max, then its time to stop
			ret drawLetter.end
			halt
//not parameters
drawLetter.incrementX	0
drawLetter.incrementY	0
drawLetter.width	8
drawLetter.height	10
drawLetter.maxX		0
drawLetter.maxY		0	
drawLetter.pxIndex	0
drawLetter.letterAddr	0
	
//parameters passed in
drawLetter.end		0
drawLetter.x		0
drawLetter.y		0
drawLetter.letterIndex  0
drawLetter.scale	1
//optional if you dont want default white font
drawLetter.color	0xf8f8f8


#include letters.e

