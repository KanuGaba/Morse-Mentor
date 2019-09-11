receive_start   
                 be      receive_loop1    receive_wait1    receive_num1    //if waiting for resp=1 go to checker
                 be      receive_loop2    receive_wait0    receive_num1    //if waiting for resp=0 go to checker

                 cp      0x80000090       receive_num1                     //command on
                 cp      receive_wait1    receive_num1                     //waiting for resp=1
receive_loop1    bne     receive_leave    0x80000091       receive_num1    //is response 1?
                 cp      receive_wait1    receive_num0                     //not waiting for resp=1

                 cp      receive_data     0x80000092                       //record receive_data

                 cp 	 0x80000090       receive_num0                     //command off
                 cp      receive_wait0    receive_num1                     //waiting for resp=0
receive_loop2    bne     receive_leave    0x800000a1       receive_num0    //is response 0?
                 cp      receive_wait0    receive_num0                     //not waiting for resp=0
           
receive_leave    ret     receive_end                                       //return to tester
                 


//constants
receive_num0 0
receive_num1 1


//nonblocking stuff
receive_wait1 0 //waiting for response=1 when this is 1
receive_wait0 0 //waiting for response=0 when this is 1

//other notes
receive_data 0 //stores received data

receive_end 0
