// Function: mouseDriver
// Created by: Kanu Gaba

mouseDriver.start     cp     0x80000070             mouseDriver.one                         // Sets mouse_command to 1

mouseDriver.check1    bne    mouseDriver.off        0x80000071          mouseDriver.one     // If mouse_response == 1 goto read

mouseDriver.read      cp     mouseDriver.deltax     0x80000072                              // Read in mouse_deltax
                      cp     mouseDriver.deltay     0x80000073                              // Read in mouse_deltay
                      cp     mouseDriver.button1    0x80000074                              // Read in mouse_button1
                      cp     mouseDriver.button2    0x80000075                              // Read in mouse_button2
                      cp     mouseDriver.button3    0x80000076                              // Read in mouse_button3

mouseDriver.flag      cp     0x80000070             mouseDriver.zero                        // Sets mouse_command to 0

mouseDriver.check2    bne    mouseDriver.check2     0x80000071          mouseDriver.zero    // If mouse_response == 0 goto end
                      be     mouseDriver.end        0x80000071          mouseDriver.zero

mouseDriver.off       //cp     mouseDriver.deltax     mouseDriver.zero                        // Sets values to 0
                      //cp     mouseDriver.deltay     mouseDriver.zero                  
                    //cp     mouseDriver.button1    mouseDriver.none                        // Sets values to -1
                      //cp     mouseDriver.button2    mouseDriver.none                       
                      //cp     mouseDriver.button3    mouseDriver.none                        

mouseDriver.end       ret    mouseDriver.ra                                                 // Returns to function call


// constants

mouseDriver.none       -1
mouseDriver.zero       0     
mouseDriver.one        1
mouseDriver.deltax     0     // [0,639], pos is right
mouseDriver.deltay     0     // [0,479], pos is down
mouseDriver.button1    0     // left click, 0 or 1
mouseDriver.button2    0     // middle click, 0 or 1
mouseDriver.button3    0     // right click, 0 or 1
mouseDriver.x          0     // actual x location
mouseDriver.y          0     // actual y location
mouseDriver.ra         0     // return address
