//Speaker


speaker_begin	be      speaker_loop1    speaker_wait1    speaker_num1    //if waiting for resp=1 go to checker
                be      speaker_loop2    speaker_wait0    speaker_num1    //if waiting for resp=0 go to checker

                cp	0x80000042	speaker_data			//Copy data into speaker_sample

		cp	0x80000040	speaker_num1			//Set speaker_command to 1
                cp      speaker_wait1    speaker_num1                  //waiting for resp=1
speaker_loop1	bne     speaker_leave    0x80000041    speaker_num1    //is resp 1?
                cp      speaker_wait1    speaker_num0                  //not waiting for resp=1

		cp	0x80000040	speaker_num0			//Exit loop, set speaker_command to 0
                cp      speaker_wait0    speaker_num1                  //waiting for resp=0
speaker_loop2	bne     speaker_leave    0x80000041    speaker_num0    //is resp 0?
                cp      speaker_wait0    speaker_num0                  //not waiting resp=0


		
speaker_leave		ret	speaker_return					//Return




//Sample data
speaker_data	0

//Return value					
speaker_return	0

//Constant values
speaker_num0	0						
speaker_num1	1

//nonblocking
speaker_wait1 0 //waiting for resp=1
speaker_wait0 0 //waiting for resp=0

//Size of array
speaker_size	32

//Array of values
speaker_values  0		
		596500000
		992010000
		1053100000
		759250000
		209500000
		-410900000
		-892780000
		-1073700000
		-892780000
		-410900000
		209500000
		759250000
		1053100000
		992010000
		596500000
		0
		-596500000
		-992010000
		-1053100000
		-759250000
		-209500000
		410900000
		892780000
		1073700000
		892780000
		410900000
		-209500000
		-759250000
		-1053100000
		-992010000
		-596500000
