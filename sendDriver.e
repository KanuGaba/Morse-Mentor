send_start 
              be      send_loop1    send_wait1    send_num1    //if waiting for resp=1 go to checker
              be      send_loop2    send_wait0    send_num1    //if waiting for resp=0 go to checker

              cpfa    0x800000a2    send_msg      send_i       //put char from msg into send_data

              cp      0x800000a0    send_num1 	               //command on
              cp      send_wait1    send_num1                  //waiting for resp=1
send_loop1    bne     send_leave    0x800000a1    send_num1    //is resp 1?
              cp      send_wait1    send_num0                  //not waiting for resp=1


              cp      0x800000a0    send_num0                  //command off
              cp      send_wait0    send_num1                  //waiting for resp=0
send_loop2    bne     send_leave    0x800000a1    send_num0    //is resp 0?
              cp      send_wait0    send_num0                  //not waiting resp=0


send_leave    ret     send_end                                 //go back to test program
              


//constants
send_num0 0
send_num1 1

//nonblocking stuff
send_wait1 0 //waiting for resp=1
send_wait0 0 //waiting for resp=0

//other notes
send_msg 0 //stores message to be sent
send_i 0 //stores index of current letter of message
send_end 0

