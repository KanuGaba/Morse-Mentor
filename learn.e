	
learn.start	cp fillScreen.color bgColor
		call fillScreen.start fillScreen.end

		cpdata learn.letterIndex 0
		cpdata learn.progressIndex 0
		cpdata learn.completed 0
		
		//draw a title bar that tells user their mode
		cpdata vgaDriver.x1 0
		cpdata vgaDriver.y1 0
		cp vgaDriver.x2 fillScreen.maxW
		cp vgaDriver.y2 learn.barHeight
		cpdata vgaDriver.rgb 0xff644e
		call vgaDriver.start vgaDriver.end

		// say that we are in learn mode
		cpdata drawWord.x 20
		cpdata drawWord.y 25
		cpdata drawWord.color 0xffffff
		cpdata drawWord.scale 4
		cp drawWord.wordAddr learn.w1
		call drawWord.start drawWord.end

		//"match the sound"
		cpdata drawWord.x 140
		cpdata drawWord.y 140
		cpdata drawWord.color 0
		cpdata drawWord.scale 3
		cp drawWord.wordAddr learn.w2
		call drawWord.start drawWord.end

		//draw the title letters that will be overwritten 
		//for each correct letter
		cpdata drawWord.x 20
		cpdata drawWord.y 400
		cpdata drawWord.color 0x555555
		cpdata drawWord.scale 3
		cp drawWord.wordAddr learn.lett1
		call drawWord.start drawWord.end

		cpdata drawWord.y 440
		cpdata drawWord.color 0x555555
		cpdata drawWord.scale 3
		cp drawWord.wordAddr learn.lett2
		call drawWord.start drawWord.end

		//draw our starting letter (consider how this same step will be ni loop)
		cpdata drawLetter.x 300
		cpdata drawLetter.y 210
		cpdata drawLetter.color 0
		cpdata drawLetter.scale 5
		cp drawLetter.letterIndex learn.letterIndex
		call drawLetter.start drawLetter.end
		//and the corresponding morse for that letter
		cp drawMorseLetter.height 10
		cpdata drawMorseLetter.x 300
		cpdata drawMorseLetter.y 290
		cp drawMorseLetter.letterIndex learn.letterIndex
		cpdata drawMorseLetter.color	0
		call drawMorseLetter.start drawMorseLetter.end
		//WARNING: MORSE WILL NOT ALWAYS BE CENTERED> CONSIDER CALCULATING OFFSET

		cpdata learn.isPressing 0

                


		//input loop
		//1:check if we return to main menu (cannot go to communicate from here)
learn.loop	cp switch 0x80000000

		//MAIN MODE: if switch bit 2 is set to 1
		//to look at 1st binary digit, perform x AND 1 then test for 1 < 1 
		cpdata switchFlag 1
		and switchFlag switchFlag switch
		blt learn.skipMain switchFlag num1 
		//once we leave learn mode, we should redraw everything in main
		be main.start num1 num1
learn.skipMain
		//check if user has new morse input that we have not computed
		//if so:check whether our current letters next component has been fulfilled
		//if the index of morse symbol components reaches the end, then INCREMENT our indexer
		//if update needed, then draw green over last letter, play a happy sound, then update..
		//...the requested letter

                bne             lrnmousecheck           playLetter.playing      test_num0       //dont always play letter sound
                call            playLetter.start        playLetter.ret
lrnmousecheck
		//call mouse driver to:check if press on
		call  	mouseDriver.start mouseDriver.ra		
                
                bne             skiplrnspeaker1         mouseDriver.button1    	num1
lrnspeaker	
                cp              playLetter.playing      test_num0
                cpfa		speaker_data		speaker_values		speaker_i	//Copy data for speaker
		call		speaker_begin		speaker_return				//Call speaker_begin
		be              skiplrnspeaker2         speaker_wait1           num1               //keeps sound normal
                add             speaker_i               speaker_i               num1              //iterates sound data
                bne             skiplrnspeaker2         speaker_i               speaker_size

skiplrnspeaker1 cp              speaker_i               vgaDriver.num0


skiplrnspeaker2

		//1: if !isPressing and button1, then call timeDriver and repeat loop //new press start
		//if !isPressing and !button1 then DO NOTHING
		//if isPressing and button1 then DO NOTHING
		//2: if isPressing and !button1 then call timeDriver and check input from timeDriver // end of press
		be learn.loop mouseDriver.button1 learn.isPressing // the boring case with no change

		call timeDriver.start timeDriver.ra //always do this if we passed the last be
		be learn.newInput num1 learn.isPressing//if we ended pressing, then update to isPressing = 0
		//flip our pressing value
		cpdata learn.isPressing 1

		//if we are here and were in the state of being done with learn, reset the learn
		be learn.start learn.completed num1

		//redraw black letter in case it was red to indicate wrong input
		cpdata drawLetter.x 300
		cpdata drawLetter.y 210
		cpdata drawLetter.color 0
		cpdata drawLetter.scale 5
		cp drawLetter.letterIndex learn.letterIndex
		call drawLetter.start drawLetter.end
		
		be learn.loop num1 num1//go back to loop if we realize that we have a new press

learn.newInput	cpdata learn.isPressing 0//flip our pressing value			
		//at this point, we assume that new input was put in.
		//not necessarily meaning that we are on the next letter or have correct input!

		//expectedSymbol set
		cpfa learn.tempAddr morseLetters.letters learn.letterIndex
		add learn.tempAddr learn.tempAddr learn.progressIndex
		cpfa learn.expectedSymbol 0 learn.tempAddr

		bne learn.wrongSymbol timeDriver.isDah learn.expectedSymbol
		//correct symbol at this point: check if we completed word
		add learn.progressIndex learn.progressIndex num1
		
		add learn.tempAddr learn.tempAddr num1//quickly check if next symbol is -1 (end of array)
		cpfa learn.expectedSymbol 0 learn.tempAddr
		bne learn.loop learn.expectedSymbol learn.neg1//if next is not neg1, then we have not reached end
		

learn.nextLetter //if we reach this line, it is time to move to next letter

		//highlight letter we just finished!
		cp learn.tempOffset learn.letterIndex
		blt learn.sameX learn.letterIndex learn.num13
		sub learn.tempOffset learn.letterIndex learn.num13//offset back to start x on new row
learn.sameX	mult drawLetter.x learn.tempOffset learn.letterW
		add drawLetter.x drawLetter.x learn.num20
		cpdata drawLetter.y 400
		blt learn.sameY learn.letterIndex learn.num13 // if we are on < 13th letter, stay on y = 400
		add drawLetter.y drawLetter.y learn.num40
learn.sameY	cp drawLetter.letterIndex learn.letterIndex
		cpdata drawLetter.scale 3
		cpdata drawLetter.color 0xff00
		call drawLetter.start drawLetter.end

		add learn.letterIndex learn.letterIndex num1
		//set progressIndex back to 0, and get next letter info stuf
		cpdata learn.progressIndex 0

		 //cover old letter
		cpdata vgaDriver.x1 0
		cpdata vgaDriver.y1 200
		cpdata vgaDriver.x2 639
		cpdata vgaDriver.y2 310
		cp vgaDriver.rgb bgColor
		call vgaDriver.start vgaDriver.end

		//if we just finished letter z index 25, then display congrats!
		be learn.congrats learn.letterIndex learn.num25 

		//draw our next letter 
		cpdata drawLetter.x 300
		cpdata drawLetter.y 210
		cpdata drawLetter.color 0
		cpdata drawLetter.scale 5
		cp drawLetter.letterIndex learn.letterIndex
		call drawLetter.start drawLetter.end
		//and the corresponding morse for that letter
		cp drawMorseLetter.height 10
		cpdata drawMorseLetter.x 300
		cpdata drawMorseLetter.y 290
		cp drawMorseLetter.letterIndex learn.letterIndex
		cpdata drawMorseLetter.color	0
		call drawMorseLetter.start drawMorseLetter.end
	
                cp   playLetter.letterIndex   learn.letterIndex
                call timeDriver.start  timeDriver.ra
                cp   playLetter.time  timeDriver.time
                cpfa 	 symbol_i   morseLetters.letters    playLetter.letterIndex
                cpfa     toBePlayed              0          symbol_i

		//go back into loop to learn more
		be learn.loop num1 num1

learn.congrats	//finished all letters
		cpdata learn.letterIndex 0
		cpdata learn.progressIndex 0
		cpdata learn.completed 1
		
		cpdata drawWord.x 140
		cpdata drawWord.y 200
		cpdata drawWord.color 0
		cpdata drawWord.scale 4
		cp drawWord.wordAddr learn.w3
		call drawWord.start drawWord.end
	
		be learn.loop num1 num1

learn.wrongSymbol
		//INCORRECT symbol at this point: make a disturbing sound and mark the morse as red
		cpdata learn.progressIndex 0

		//draw our starting letter (consider how this same step will be ni loop)
		cpdata drawLetter.x 300
		cpdata drawLetter.y 210
		cpdata drawLetter.color 0xff0000
		cpdata drawLetter.scale 5
		cp drawLetter.letterIndex learn.letterIndex
		call drawLetter.start drawLetter.end
		
		//cover old command 
		cpdata vgaDriver.x1 0
		cpdata vgaDriver.y1 90
		cpdata vgaDriver.x2 639
		cpdata vgaDriver.y2 310
		cp vgaDriver.rgb bgColor
		call vgaDriver.start vgaDriver.end

		//repeat our learn loop
		be learn.loop num1 num1
		ret learn.end
		halt

//non-parameters
learn.neg1		-1
learn.tempAddr		0
learn.expectedSymbol	-1 // tells us expected next symbol. 0 for dit, 1 dah
learn.isPressing	0
learn.letterIndex	0
learn.progressIndex	0 // keeps track of letter we have learned so far
learn.letterW		48//change
learn.num13		13
learn.num40		40
learn.num20		20
learn.num25		25
learn.tempOffset	0
learn.completed		0
learn.letters	'a'
		'b'
		'c'
		'd'
		'e'
		'f'
		'g'
		'h'
		'i'
		'j'
		'k'
		'l'
		'm'
		'n'
		'o'
		'p'
		'q'
		'r'
		's'
		't'
		'u'
		'v'
		'w'
		'x'
		'y'
		'z'
		-1

learn.barHeight	90

//parameters
learn.end	0

learn.w3	learn.lw3
learn.lw3	'c'
		'o'
		'n'
		'g'
		'r'
		'a'
		't'
		'u'
		'l'
		'a'
		't'
		'i'
		'o'
		'n'
		's'
		-1

learn.w1 	learn.lw1
learn.lw1	'l'
		'e'
		'a'
		'r'
		'n'
		'`'
		'm'
		'o'
		'd'
		'e'
		-1

learn.w2	learn.lw2
learn.lw2	'm'
		'a'
		't'
		'c'
		'h'
		'`'
		't'
		'h'
		'e'
		'`'
		's'
		'o'
		'u'
		'n'
		'd'
		-1

learn.lett1 	learn.l1
learn.l1	'a'
		'`'
		'b'
		'`'
		'c'
		'`'
		'd'
		'`'
		'e'
		'`'
		'f'
		'`'
		'g'
		'`'
		'h'
		'`'
		'i'
		'`'
		'j'
		'`'
		'k'
		'`'
		'l'
		'`'
		'm'
		-1


learn.lett2 	learn.l2
learn.l2	'n'
		'`'
		'o'
		'`'
		'p'
		'`'
		'q'
		'`'
		'r'
		'`'
		's'
		'`'
		't'
		'`'
		'u'
		'`'
		'v'
		'`'
		'w'
		'`'
		'x'
		'`'
		'y'
		'`'
		'z'
		-1

#include timeDriver.e
#include mouseDriver.e
#include playLetter.e
#include timeDriver2.e
//#include drawWord.e
//#include drawMorse.e
