
// we draw a sequence of boxes and circles given a string of alphabet and spaces 
//(yes, spaces are allowed for the sake of clarity in this project)

drawMorse.start		cpfa 	drawMorse.letterIndex		0 			drawMorse.wordAddr
			//if we reach a negative index value, then end early
			be 	drawMorse.quit			drawMorse.letterIndex 	drawMorse.neg1
			sub 	drawMorse.letterIndex 		drawMorse.letterIndex 	drawMorse.97

			//test for negative number again. if ascii for ` is noticed, we get 96 - 97 = -1 --> whitespace
			be 	drawMorse.blank			drawMorse.letterIndex 	drawMorse.neg1

			cp 	drawMorseLetter.x		drawMorse.x
			cp 	drawMorseLetter.y		drawMorse.y
			
			//set our letter drawer index to one we just got
			cp 	drawMorseLetter.letterIndex	drawMorse.letterIndex
			cp 	drawMorseLetter.height 		drawMorse.height
			cp 	drawMorseLetter.color		drawMorse.color
			call 	drawMorseLetter.start 		drawMorseLetter.end

			//increment to next letter
drawMorse.blank		add 	drawMorse.wordAddr	 	drawMorse.wordAddr 	vgaDriver.num1

			// move x drawing position by the width of a dit
			cp 	drawMorse.x 			vgaDriver.x2
			//must make space for separate letters
			add 	drawMorse.x 			drawMorse.x 		drawMorseLetter.ditWidth
			add 	drawMorse.x 			drawMorse.x 		drawMorseLetter.ditWidth
			be 	drawMorse.start	 		drawMorse.neg1 		drawMorse.neg1


drawMorse.quit		ret drawMorse.end
			halt


//input parameters
drawMorse.end		0
drawMorse.wordAddr	0
drawMorse.x		0
drawMorse.y		0
//drawMorse.scale		1 //work on scaling later
drawMorse.color		0

//not inputs
drawMorse.letterIndex	0
drawMorse.height	10
drawMorse.neg1		-1
drawMorse.97		97

#include drawMorseLetter.e
