//Speaker test


loop		be		reset			i			values_size		//Reset loop only when we reach the 
		cpfa		speaker_data		values			i			//Copy the data to be sent into s
		call		speaker_begin		speaker_return					//Call speaker_begin
		add		i			i			test_num1		//Increment i
		be		loop			loop_value		loop_value		//Jump back to loop
reset		cp              i                       k
                be		loop			loop_value		loop_value		//Jump back to loop


                					



//Incremented values
i		0
k               0

//Size of array
values_size	19

//Constant 1
test_num1	1

//Constant 0			
loop_value	0



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


#include speaker.e
