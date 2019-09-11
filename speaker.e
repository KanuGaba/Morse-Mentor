//Speaker


speaker_begin	be      speaker_loop1    speaker_wait1    speaker_num1    //if waiting for resp=1 go to checker
                be      speaker_loop2    speaker_wait0    speaker_num1    //if waiting for resp=0 go to checker

                cp	0x80000042	speaker_data			//Copy data into speaker_sample

		cp	0x80000040	speaker_num1			//Set speaker_command to 1

speaker_loop1	be	speaker_loop1	0x80000041	speaker_num0	//Loop, wait for speaker_response to be 1

		cp	0x80000040	speaker_num0			//Exit loop, set speaker_command to 0

speaker_loop2	be	speaker_loop2	0x80000041	speaker_num1	//Loop, wait for speaker_response to be 0
		
		ret	speaker_return					//Return

//Sample data
speaker_data	0

//Return value					
speaker_return	0

//Constant values
speaker_num0	0						
speaker_num1	1
