		
drawMorseLetter.start   cpfa drawMorseLetter.symbolIndex morseLetters.letters drawMorseLetter.letterIndex 

			//copy our given start x and y to incrementX and incrementY
			cp drawMorseLetter.incrementX drawMorseLetter.x
			cp drawMorseLetter.incrementY drawMorseLetter.y

			cp drawMorseLetter.dahWidth drawMorseLetter.height
			mult drawMorseLetter.dahWidth drawMorseLetter.dahWidth drawMorseLetter.num3
			cp drawMorseLetter.ditWidth drawMorseLetter.height 

			//set our max x and y to x+scale*width
			//and y+scale*height (not using -1) then scale
			//mult drawMorseLetter.maxX drawMorseLetter.width drawMorseLetter.scale
			//add drawMorseLetter.maxX drawMorseLetter.maxX drawMorseLetter.x
			//mult drawMorseLetter.maxY drawMorseLetter.height drawMorseLetter.scale
			//add drawMorseLetter.maxY drawMorseLetter.maxY drawMorseLetter.y

//we need to make x1 and x2 the same since we are drawing pixel by pixel
drawMorseLetter.loop	cp vgaDriver.x1 drawMorseLetter.incrementX		
			cp vgaDriver.x2 drawMorseLetter.incrementX
			cp vgaDriver.y1 drawMorseLetter.incrementY
			cp vgaDriver.y2 drawMorseLetter.incrementY
			
			//now that we set the position to start drawing from
			//we can read the next dit or dah 0 or 1 for a letter

			cpfa drawMorseLetter.code 0 drawMorseLetter.symbolIndex
			//if -1, then quit this letter
			be drawMorseLetter.quit drawMorseLetter.code drawMorseLetter.neg1

			//at this point, code is 1 or 0. if 1, then lets draw vga
			be drawMorseLetter.dit drawMorseLetter.code drawMorseLetter.num0
		
			//start setting up rectangle for 1 dah
			cp vgaDriver.x1 drawMorseLetter.incrementX		
			cp vgaDriver.x2 drawMorseLetter.incrementX
			add vgaDriver.x2 vgaDriver.x2 drawMorseLetter.dahWidth

			cp vgaDriver.y1 drawMorseLetter.incrementY
			cp vgaDriver.y2 drawMorseLetter.incrementY
			add vgaDriver.y2 vgaDriver.y2 drawMorseLetter.height

			//set color
			cp vgaDriver.rgb drawMorseLetter.color
			//call the driver to 
			call vgaDriver.start vgaDriver.end

			//if we reach this point, break away to avoid drawing a dit
			be drawMorseLetter.skipDit drawMorseLetter.neg1 drawMorseLetter.neg1

			//start setting up rectangle for 1 dit
drawMorseLetter.dit	cp vgaDriver.x1 drawMorseLetter.incrementX		
			cp vgaDriver.x2 drawMorseLetter.incrementX
			add vgaDriver.x2 vgaDriver.x2 drawMorseLetter.ditWidth

			cp vgaDriver.y1 drawMorseLetter.incrementY
			cp vgaDriver.y2 drawMorseLetter.incrementY
			add vgaDriver.y2 vgaDriver.y2 drawMorseLetter.height

			//set color
			cp vgaDriver.rgb drawMorseLetter.color
			//call the driver to 
			call vgaDriver.start vgaDriver.end

drawMorseLetter.skipDit	
			//increment our incrementer
			add drawMorseLetter.symbolIndex drawMorseLetter.symbolIndex vgaDriver.num1

			//move x for next character in same word
			cp drawMorseLetter.incrementX vgaDriver.x2
			add drawMorseLetter.incrementX drawMorseLetter.incrementX drawMorseLetter.ditWidth

			//repeat loop
			be drawMorseLetter.loop drawMorseLetter.num0 drawMorseLetter.num0

drawMorseLetter.quit	ret drawMorseLetter.end
			halt



//not parameters
drawMorseLetter.incrementX	0
drawMorseLetter.incrementY	0
drawMorseLetter.maxX		0
drawMorseLetter.symbolIndex	0
drawMorseLetter.letterAddr	0
drawMorseLetter.neg1		-1
drawMorseLetter.dahWidth	30
drawMorseLetter.ditWidth	30
drawMorseLetter.num3		3
drawMorseLetter.num0		0
drawMorseLetter.code		99
	
//parameters passed in
drawMorseLetter.end		0
drawMorseLetter.x		0
drawMorseLetter.y		0
drawMorseLetter.letterIndex  	0
drawMorseLetter.height		10

//optional if you dont want default white font
drawMorseLetter.color	0


#include morseLetters.e
#include drawImage.e

