
	cp	drawLetter.color	vgaDriver.num0
	cp 	fillScreen.color	green
	call	fillScreen.start 	fillScreen.end
	cp 	drawWord.x 		testOffset
	cp 	drawWord.y 		testOffset
	cp 	drawWord.wordAddr 	word
	call 	drawWord.start 		drawWord.end
	halt

//word must end in a -1
word 		testHello
green		0xf7f3be
testHello	'u'
		'`'
		'r'
		'`'
		'p'
		'o'
		'o'
		'p'
		-1

testOffset 	16

#include drawWord.e

