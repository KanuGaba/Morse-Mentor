start 	
sendl      call    sendDriver       send_end                     //call send
           add     send_i           send_i             one           //increment i
	
           bne     sendl            send_i             length        //keep sending until done

           cp      send_i                zero                        //reset i



recl       add     proplength       pwlength      one           //add one to length to include enter

recloop	   blt     r_proto          pwlength      send_i             //skip checking index i if i>pwlength
           cpfa    thischar         password      send_i             //record char at index i of pw
           call    receiveDriver    receiveEnd                  //call receive
           add     send_i           send_i             one           //increment i

	   

           blt     pwcheck          pwlength      send_i             //skip checking index i if i>pwlength
           be      pwcheck          checker       enterkey      //allows program to end if enter is hit early
           bne     mkwrong          checker       thischar      //if entry char != pw char mark wrong
pwcheck    bne     recloop          checker       enterkey      //keep looping until user hits enter
           bne     badpw            send_i             proplength    //final entry is wrong if i!=pwlength
           be      badpw            wrong         one           //final entry is wrong if a char was wrong

correct    cp      0x80000002       ongreen                     //correct pw, turn on green LEDs
           call    fin              temp                        //go back to tester 


fin							        //done with receive      
	
           halt


mkwrong    cp      wrong            one                         //set wrong to true
           call    recloop          temp                        //go back to wait until enter key hit
           halt

badpw      cp      0x80000001       onred                       //wrong pw, turn on red LEDs
           call    fin              temp                        //go back to tester
	   halt


on 1
onred 0x3ffff
ongreen 0xff
off 0

one 1
i 0
temp 0
zero 0
sendEnd 0
receiveEnd 0

msg	'h'
	'e'
	'l'
	'l'
	'o'
length 5



password 'b'
	'r'
	'i'
	'a'
	'n'
pwlength 5

checker 0
wrong 0
enterkey 10
proplength 1
thischar 0

#include receiveDriver.e
#include sendDriver.e
