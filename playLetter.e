playLetter.start
                     
                     call        timeDriver2.start           timeDriver2.ra
                     sub         playLetter.diff         timeDriver2.time        playLetter.time
                     blt         playLetter.loop         playLetter.diff         playLetter.stop  //keep playing if time diff isnt long enough         
playLetter.adjust    
                     add         symbol_i                symbol_i                test_num1       //iterate
                     cpfa        toBePlayed              0                       symbol_i
                     be          playLetter.done         toBePlayed              playLetter.neg1
                     
                     


playLetter.loop
                     cpfa	 speaker_data		 comm_values             playLetter_i	//Copy data for speaker
		     call	 speaker_begin		 speaker_return				//Call speaker_begin
		     be          playLetter.end          speaker_wait1           num1            //keeps sound normal
                     add         playLetter_i            playLetter_i            num1            //iterates sound data
                     bne         playLetter.end          playLetter_i            cvalues_size

                     cp          playLetter_i            test_num0

playLetter.end 
                     ret playLetter.ret
playLetter.done
                     cp          symbol_i                test_num0
                     cp          playLetter.playing      test_num0
                     ret playLetter.ret



playLetter.playing 1 //should letter be played rn?

toBePlayed 0  //current symbol from learn.letterIndex
symbol_i 0
playLetter_i 0

playLetter.time 0
playLetter.diff 0
playLetter.stop  0  //time to adjust or stop

playLetter.letterIndex 0

playLetter.isSpace 0

playLetter.neg1 -1

playLetter.ret 0
