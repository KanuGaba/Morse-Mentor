	
comm.start	//cp fillScreen.color bgColor
		call fillScreen.start fillScreen.end

		//draw a title bar that tells user their mode
		cpdata vgaDriver.x1 0
		cpdata vgaDriver.y1 0
		cp vgaDriver.x2 fillScreen.maxW
		cp vgaDriver.y2 comm.barHeight
		cpdata vgaDriver.rgb 0xff644e
		call vgaDriver.start vgaDriver.end

		// say that we are in comm mode
		cpdata drawWord.x 20
		cpdata drawWord.y 25
		cpdata drawWord.color 0xffffff
		cpdata drawWord.scale 4
		cp drawWord.wordAddr comm.w1
		call drawWord.start drawWord.end

		//input loop
		//1:check if we return to main menu (cannot go to communicate from here)

comm.loop	cp switch 0x80000000

		//MAIN MODE: if switch bit 1 is set to 1
		cpdata switchFlag 1
		and switchFlag switchFlag switch
		bne comm.skipMain num1 switchFlag
		//once we leave comm mode, we should redraw everything in main
		be main.start num1 num1
		

comm.skipMain
                
//RECEIVING
                blt             postdraw                drawMorseLetter.x       vgawidth
                cpdata          drawMorseLetter.x       0
                add             drawMorseLetter.y       drawMorseLetter.y       drawMorseLetter.height
                add             drawMorseLetter.y       drawMorseLetter.y       drawMorseLetter.height
                blt             postdraw                drawMorseLetter.y       vgaheight
                call            fillScreen.start        fillScreen.end
                cpdata          drawMorseLetter.y       0
postdraw                
                call            receive_start           receive_end
                cp              rec_speaker             receive_data
checkrec        bne             comm_reset                   rec_speaker             test_num1               //only play speaker if told

                bne             comm_loop               new_draw                test_num1              //only draw if new symbol
                cp              new_draw                test_num0
                //call            fillScreen.start        fillScreen.end
                call            timeDriver.start         timeDriver.ra                                  //mark time 
                blt             comm_loop               timeDriver.delta_t      spacetime          //skip if time diff < limit
                //DRAW SPACE HERE
                be              comm_loop               drawMorseLetter.x       test_num0
                add             drawMorseLetter.x       drawMorseLetter.x       drawMorseLetter.height



comm_loop	cpfa		speaker_data		speaker_values	        speaker_i			//Copy data for speaker
		call		speaker_begin		speaker_return					//Call speaker_begin
		be              after                   speaker_wait1           test_num1                //keeps sound normal
                add             speaker_i               speaker_i               test_num1               //iterates sound data
                bne             after                   speaker_i               speaker_size
                
comm_reset      cp              speaker_i               test_num0

                be              after                   rec_speaker             test_num1               //skip if speaker is on
                be              after                   new_draw                test_num1               //skip if already drawn
                cp              new_draw                test_num1                                       //no more drawing while speaker off this time
                call            timeDriver.start        timeDriver.ra                               //mark time
                
                be              drawdah                 timeDriver.isDah        test_num1               //draw dah if dah         
              
drawdit         //DRAW DIT
                cpdata          drawMorseLetter.letterIndex    4
                //cpdata          drawMorseLetter.x              100
                //cpdata          drawMorseLetter.y              100
                cpdata          drawMorseLetter.color          0
                //cpdata          drawMorseLetter.height         20
                call            drawMorseLetter.start          drawMorseLetter.end                    
                add             drawMorseLetter.x       drawMorseLetter.x       drawMorseLetter.height 
                add             drawMorseLetter.x       drawMorseLetter.x       drawMorseLetter.height
                be              after                   test_num0               test_num0               //skip drawdah
drawdah         //DRAW DAH
                
                cpdata          drawMorseLetter.letterIndex    19
                //cpdata          drawMorseLetter.x              100
                //cpdata          drawMorseLetter.y              100
                cpdata          drawMorseLetter.color          0
                //cpdata          drawMorseLetter.height         20
                call            drawMorseLetter.start          drawMorseLetter.end  
                add             drawMorseLetter.x       drawMorseLetter.x       drawMorseLetter.height 
                add             drawMorseLetter.x       drawMorseLetter.x       drawMorseLetter.height
                add             drawMorseLetter.x       drawMorseLetter.x       drawMorseLetter.height
                add             drawMorseLetter.x       drawMorseLetter.x       drawMorseLetter.height
after           cp              0x80000002              rec_speaker                                     //green LED when speaker on

//SENDING
                be              sendresp                send_wait1             test_num1
                call            mouseDriver.start       mouseDriver.ra                                 //update mouse info
                
                be              test_end                speaker_on             mouseDriver.button1     //if already same skip send
                cp              0x80000001              mouseDriver.button1                            //red LED
                cp              send_msg                mouseDriver.button1                            //sending new mouse data
                cp              speaker_on              mouseDriver.button1                            
sendresp        call            send_start              send_end
                
test_end




		
		//repeat our comm loop
		be comm.loop num1 num1
		
		ret comm.end
		halt


//remove these once you connect to main since these already
//exist in main.e

comm.barHeight	90

//parameters
comm.end	0

comm.w1		comm.lw1
comm.lw1	'c'
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
		'm'
		'o'
		'd'
		'e'
		-1

//#include drawWord.e
//#include drawMorse.e


//Incremented values
speaker_i		0

//Constant
test_num1	1
test_num0       0 

//play speaker?
speaker_on 0 // T/F currently sending on signal

new_draw 1
spacetime 0     //time limit for spaces
rec_speaker 0   
ongreen 0xff

vgaheight 480
vgawidth  600
