comm_start  
                
                cpdata          drawMorseLetter.y       0
                cpdata          drawMorseLetter.height  20
                sub             drawMorseLetter.x       test_num0               drawMorseLetter.height
                call            fillScreen.start        fillScreen.end
                add             spacetime               timeDriver.ms           timeDriver.ms

comm_main
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



comm_loop	cpfa		speaker_data		values			speaker_i			//Copy data for speaker
		call		speaker_begin		speaker_return					//Call speaker_begin
		be              after                   speaker_wait1           test_num1                //keeps sound normal
                add             speaker_i               speaker_i               test_num1               //iterates sound data
                bne             after                   speaker_i               values_size
                
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
                cpdata          drawMorseLetter.color          0xffffff
                //cpdata          drawMorseLetter.height         20
                call            drawMorseLetter.start          drawMorseLetter.end                    
                add             drawMorseLetter.x       drawMorseLetter.x       drawMorseLetter.height 
                add             drawMorseLetter.x       drawMorseLetter.x       drawMorseLetter.height
                be              after                   test_num0               test_num0               //skip drawdah
drawdah         //DRAW DAH
                
                cpdata          drawMorseLetter.letterIndex    19
                //cpdata          drawMorseLetter.x              100
                //cpdata          drawMorseLetter.y              100
                cpdata          drawMorseLetter.color          0xffffff
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
                
test_end        be              comm_main               test_num1               test_num1               //just keep looping
                halt				




//Incremented values
speaker_i		0

//Size of array
values_size	19

//Constant
test_num1	1
test_num0       0 

//play speaker?
speaker_on 0 // T/F currently sending on signal



//Array of values
values		0		
		363717072
		684428797
		924214714
		1054722904
		1060522280
		940927133
		710078208
		395270728
		33727045
		-331804471
		-658103937
		-906590206
		-1047882644
		-1065275049
		-956710970
		-735026858
		-426434300
		-67420806
new_draw 1
spacetime 0     //time limit for spaces
rec_speaker 0   
ongreen 0xff

vgaheight 480
vgawidth  600

//#include speaker.e
#include speakerNBDriver.e
#include mouseDriver.e
#include sendDriver.e
#include receiveDriver.e
#include timeDriver.e
#include vgaDriver.e
#include drawMorseLetter.e
#include fillScreen.e
