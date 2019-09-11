//timeDriver

timeDriver.start     sub    timeDriver.delta_t    0x80000005            timeDriver.time
                     cp     timeDriver.time       0x80000005
                     blt    timeDriver.dit        timeDriver.delta_t    timeDriver.ms
                     be     timeDriver.dah        timeDriver.num0       timeDriver.num0  
                    
timeDriver.dit       cp     timeDriver.isDah      timeDriver.num0
                     be     timeDriver.return     timeDriver.num0       timeDriver.num0

timeDriver.dah       cp     timeDriver.isDah      timeDriver.num1
                     be     timeDriver.return     timeDriver.num0       timeDriver.num0

timeDriver.return    ret    timeDriver.ra



// Variables

timeDriver.num0       0
timeDriver.num1       1
timeDriver.ra         0
timeDriver.time       0    // Last retrieved time
timeDriver.delta_t    0    // Change in time
timeDriver.isDah      0    // 0 is dit, 1 is dah
timeDriver.ms         1200  // Less than 150 ms is a dit
