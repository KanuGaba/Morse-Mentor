
//call fillblack.start fillblack.end
drawWord.start		cp 	drawLetter.color drawWord.color
			cp 	drawLetter.x drawWord.x
			cp	drawLetter.y drawWord.y
			cp	drawLetter.scale drawWord.scale
			mult 	drawWord.letterWidth drawWord.scale drawLetter.width

drawWord.loop		cpfa 	drawLetter.letterIndex		0 			drawWord.wordAddr
//if we reach a negative index value, then end early
			be 	drawWord.quit			drawLetter.letterIndex 	drawWord.neg1

			sub 	drawLetter.letterIndex 		drawLetter.letterIndex 	drawWord.97
//test for negative number again. if ascii for ` is noticed, we get 96 - 97 = -1 --> whitespace
			be 	drawWord.blank			drawLetter.letterIndex 	drawWord.neg1
			call 	drawLetter.start 		drawLetter.end
//add drawWord.index drawWord.index vgaDriver.num1
drawWord.blank		add 	drawWord.wordAddr	 	drawWord.wordAddr 	vgaDriver.num1
// move x by the width of a letter
			add 	drawLetter.x 			drawLetter.x 		drawWord.letterWidth
			be 	drawWord.loop 			vgaDriver.num0 		vgaDriver.num0
drawWord.quit		ret 	drawWord.end
			halt

#include drawLetter.e

//input parameters
drawWord.end		0
drawWord.wordAddr	0
drawWord.x		0
drawWord.y		0
drawWord.scale		1
drawWord.letterWidth	0
drawWord.color		0

//not inputs
drawWord.neg1		-1
drawWord.index 		0
drawWord.97		97


