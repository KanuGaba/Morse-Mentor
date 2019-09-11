
// we need main.start to redraw all of main menu if leaving a mode
main.start
//draw background
welcomeScreen	cp fillScreen.color bgColor
		call fillScreen.start fillScreen.end


		//say morse mentor
		cpdata drawWord.scale 5
		cp drawWord.x w1X
		cp drawWord.y w1Y
		cp drawWord.wordAddr word1
		cpdata drawWord.color 0
		call drawWord.start drawWord.end
		
		//say hello
		cpdata drawWord.scale 5
		cp drawWord.x helloX
		cp drawWord.y helloY
		cp drawWord.wordAddr helloWord
		cpdata drawWord.color 0xff
		call drawWord.start drawWord.end

		// and in morse
		//cpdata drawMorse.scale 1
		cp drawMorse.height 10
		cp drawMorse.x morseHelloX
		cp drawMorse.y morseHelloY
		cp drawMorse.wordAddr helloWord
		cpdata drawMorse.color	0xff
		call drawMorse.start drawMorse.end

		//give instruction to pick mode
		cpdata drawWord.scale 2
		cp drawWord.x w2X
		cp drawWord.y w2Y
		cp drawLetter.color vgaDriver.num0
		cp drawWord.wordAddr word2
		cpdata drawWord.color 0
		call drawWord.start drawWord.end

		
		//go into some kind of loop that waits for switch activation
main.loop	cp switch 0x80000000

		//LEARN MODE: if switch bit 2 is set to 1
		//to look at 2nd binary digit, perform x AND 10 then test for 10 < 1 
		cpdata switchFlag 2
		and switchFlag switchFlag switch
		blt main.skipLearn switchFlag num1
		call learn.start learn.end
		//once we leave learn mode, we should redraw everything in main
		be main.start num1 num1

main.skipLearn
		//COMMUNICATE MODE: if switch bit 3 is set to 1
		cpdata switchFlag 4
		and switchFlag switchFlag switch
		blt main.skipComm switchFlag num1
		call comm.start comm.end
		//once we leave learn mode, we should redraw everything in main
		//though note that the program wont ever reach the below line
		be main.start num1 num1
main.skipComm



		//this goes back to beginning of main.loop
		be main.loop num1 num1

                halt				

//: device inputs
switch		-1

//: Incremented values
i		0
k               0

//: All constants
num1		1

//: looping variables and flags
//to be taken from a bit in switch
switchFlag	0


//visual settings
bgColor		0xf7f3be

morseHelloX	50
morseHelloY	280


helloX	220
helloY	180
helloWord	hello
hello	 	'h'
		'e'
		'l'
		'l'
		'o'
		-1

w1X		80
w1Y		30
word1		w1
w1		'm'
		'o'
		'r'
		's'
		'e'
		'`'
		'm'
		'e'
		'n'
		't'
		'o'
		'r'
		-1

w2X		32
w2Y		400
word2		w2
w2		's'
		'e'
		'l'
		'e'
		'c'
		't'
		'`'
		'l'
		'e'
		'a'
		'r'
		'n'
		'`'
		'o'
		'r'
		'`'
		'c'
		'o'
		'm'
		'm'
		'u'
		'n'
		'i'
		'c'
		'a'
		't'
		'e'
		'`'
		't'
		'o'
		'`'
		'b'
		'e'
		'g'
		'i'
		'n'
		-1

		




#include drawWord.e
#include drawMorse.e
#include fillScreen.e
#include learn.e
#include comm.e

#include speakerNBDriver.e
#include sendDriver.e
#include receiveDriver.e
