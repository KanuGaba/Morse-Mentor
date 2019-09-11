//Speaker test


loop		be		reset			i			values_size		//Reset loop only when we reach the 
		cpfa		speaker_data		values			i			//Copy the data to be sent into s
		call		speakerDriver.start	speaker_return					//Call speaker_begin
		add		i			i			test_num1		//Increment i
		be		loop			loop_value		loop_value		//Jump back to loop
reset		cp              i                       k
                be		loop			loop_value		loop_value		//Jump back to loop


                					



//Incremented values
i		0
k               0

//Size of array
values_size	32

//Constant 1
test_num1	1

//Constant 0			
loop_value	0



//Array of values
values		0		
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
		


#include speakerDriver.e
