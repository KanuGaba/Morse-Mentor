// File: mouseTest
// Created by: Kanu Gaba

mouseTest.start      call    mouseDriver.start    mouseDriver.ra                               // Call the driver

mouseTest.valid      be      mouseTest.start      mouseDriver.button1    mouseDriver.none      // Checks if response was 0

mouseTest.compute    add     mouseDriver.x        mouseDriver.x          mouseDriver.deltax    // Add the change in x to the total x
                     add     mouseDriver.y        mouseDriver.y          mouseDriver.deltay    // Add the change in y to the total y

mouseTest.range1     blt     mouseTest.update1    mouseDriver.x          mouseDriver.zero      // Checks the ranges
mouseTest.range2     blt     mouseTest.update2    mouseDriver.y          mouseDriver.zero
mouseTest.range3     blt     mouseTest.update3    mouseTest.x_max        mouseDriver.x
mouseTest.range4     blt     mouseTest.update4    mouseTest.y_max        mouseDriver.y

mouseTest.loop1	     cp      0x80000004           mouseDriver.x                                // Updates Hex
                     cp      0x80000003           mouseDriver.y
                     be      mouseDriver.start    mouseDriver.zero       mouseDriver.zero      // Loops

mouseTest.update1    cp      mouseDriver.x        mouseDriver.zero                             // Fixes out of range
                     be      mouseTest.range2     mouseDriver.zero       mouseDriver.zero

mouseTest.update2    cp      mouseDriver.y        mouseDriver.zero
                     be      mouseTest.range3     mouseDriver.zero       mouseDriver.zero

mouseTest.update3    cp      mouseDriver.x        mouseTest.x_max
                     be      mouseTest.range4     mouseDriver.zero       mouseDriver.zero

mouseTest.update4    cp      mouseDriver.y        mouseTest.y_max
                     be      mouseTest.loop1      mouseDriver.zero       mouseDriver.zero


//constants

mouseTest.x_max    639
mouseTest.y_max    479


#include mouseDriver.e
