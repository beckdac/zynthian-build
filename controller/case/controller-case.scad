$fn = 64;

// interference fit adjustment for 3D printer
iFitAdjust = .4;
iFitAdjust_d = .25;

// latch buttons
latchButtonDiameter = 13;
latchButtonHeight = 30;
module latch_button(color="green") {
    color(color)
        cylinder(h = latchButtonHeight, d = latchButtonDiameter, center = false);
}

// led momentary buttons
ledButtonDiameter = 25;
ledButtonHeight = 33;
module momentary_button(color="white") {
    color(color)
        cylinder(h = ledButtonHeight, d = ledButtonDiameter, center = false);
}

// encoders
encoderShaftDiameter = 8;
encoderShaftHeight = 18;
encoderShaftOffset = 9;
encoderWidth = 18;
encoderLength = 31;
encoderDepth = 8.2;
module encoder() {
    // encoder shaft
    cylinder(h = encoderShaftHeight, d = encoderShaftDiameter, center=false);
    // encoder base
    translate([-encoderWidth/2, -encoderShaftOffset, -encoderDepth/2])
        cube([encoderWidth, encoderLength, encoderDepth]);
}

// string
stringWallThickness = 1;
stringRecess = 5;
stringLength = 60;
photoresistorWidth = 5.5 + iFitAdjust_d;
photoresistorLength = photoresistorWidth;
photoresistorWireSep = 3.5;
ledLaserDiameter = 6.5 + iFitAdjust_d;
ledLaserLength = 10;
wireCasingDepth = 3;
stringWidth = ledLaserDiameter;
module photoresistor_holder() {
    difference() {
        cylinder(h = stringRecess + stringWallThickness * 2, d = 2 * stringWallThickness + photoresistorWidth + iFitAdjust_d, center = false);
        translate([0,0,-.1])
            cylinder(h = stringRecess + stringWallThickness * 2 + 1, d = photoresistorWidth + iFitAdjust_d, center = false);
        /*
        for (i = [-1,1])
            translate([i * photoresistorWireSep / 2, 0, -1])
                cylinder(h = 20, d = 1, center = false);
        */
    }
    rotate([0, 0, 180])
        translate([-(ledLaserDiameter + iFitAdjust_d + 2 * stringWallThickness)/2, -(ledLaserDiameter )/2 - 1, -(wireCasingDepth + stringWallThickness * 2)])
        difference() {
            cube([ledLaserDiameter + iFitAdjust_d + 2 * stringWallThickness, ledLaserDiameter + ledLaserDiameter / 2 + 1, wireCasingDepth + stringWallThickness * 2], center=false);
            translate([stringWallThickness, stringWallThickness * 2 + 1, stringWallThickness])
                cube([ledLaserDiameter + iFitAdjust_d , ledLaserDiameter + ledLaserDiameter / 2 - stringWallThickness, wireCasingDepth], center=false);
            translate([ledLaserDiameter / 2 + stringWallThickness, ledLaserDiameter / 2 + stringWallThickness, stringWallThickness])
                cylinder(h=wireCasingDepth + 2 * stringWallThickness, d = ledLaserDiameter + iFitAdjust, center=false);
        }
}
module led_holder() {
    difference() {
        cylinder(h = ledLaserLength + stringWallThickness * 2, d = 2 * stringWallThickness + ledLaserDiameter + iFitAdjust_d, center = false);
        translate([0,0,-.1])
            cylinder(h = ledLaserLength + stringWallThickness * 2 + 1, d = ledLaserDiameter + iFitAdjust_d, center = false);
        /*
        for (i = [-1,1])
            translate([i * photoresistorWireSep / 2, 0, -1])
                cylinder(h = 20, d = 1, center = false);
        */
    }
    translate([-(ledLaserDiameter + iFitAdjust_d + 2 * stringWallThickness)/2, -(ledLaserDiameter )/2 - 1, -(wireCasingDepth + stringWallThickness * 2)])
        difference() {
            cube([ledLaserDiameter + iFitAdjust_d + 2 * stringWallThickness, ledLaserDiameter + ledLaserDiameter / 2 + 1, wireCasingDepth + stringWallThickness * 2], center=false);
            translate([stringWallThickness, stringWallThickness * 2 + 1, stringWallThickness])
                cube([ledLaserDiameter + iFitAdjust_d , ledLaserDiameter + ledLaserDiameter / 2 - stringWallThickness, wireCasingDepth], center=false);
            translate([ledLaserDiameter / 2 + stringWallThickness, ledLaserDiameter / 2 + stringWallThickness, stringWallThickness])
                cylinder(h=wireCasingDepth + 2 * stringWallThickness, d = ledLaserDiameter + iFitAdjust, center=false);
        }
}
module string() {
 rotate([0, 0, 90])
  translate([0, -(wireCasingDepth + stringWallThickness * 2), ledLaserDiameter]) rotate([90, 0, 0])
   union() {
    photoresistor_holder();
    translate([0, 0, stringLength])
        rotate([180, 0, 0])
            led_holder();
    difference() {
        translate([-(ledLaserDiameter + 2 * stringWallThickness + iFitAdjust_d)/2, - ledLaserDiameter, 0])
            cube([ledLaserDiameter + iFitAdjust_d + 2 * stringWallThickness, ledLaserDiameter / 2, stringLength ], center = false);
        cylinder(h=100, d = ledLaserDiameter + iFitAdjust, center=false);
    }
   }
}

// display
OLEDWidth = 27.3;
OLEDDisplayHeight = 19;
OLEDScrewWidth = 20.7;
OLEDScrewHeight = 23.2;
OLEDScrewDiameter = 3;
OLEDDepth = 1;
OLEDDisplayDepth = 1;
module display() {
    difference() {
        union() {
            cube([OLEDWidth, OLEDWidth, OLEDDepth]);
            translate([0, (OLEDWidth - OLEDDisplayHeight) / 2, 1])
                cube([OLEDWidth, OLEDDisplayHeight, OLEDDisplayDepth]);
        }
        for (i = [0: 1])
            for (j = [0: 1])
                translate([(OLEDWidth - OLEDScrewWidth) / 2 + i * OLEDScrewWidth, (OLEDWidth - OLEDScrewHeight) / 2 + j * OLEDScrewHeight, -.1])
                    cylinder(h=boxThickness + 1, d=OLEDScrewDiameter);
    }
}

lidWidth = 100;
lidThickness = 2.5;
rowWidth = ledButtonDiameter + 10;
lidLength = rowWidth * 2 + ledButtonDiameter / 2;
controlOffset = 10;
lidScrewDiameter = 3.5;
lidScrewBoundaryOffset = 10;
module spoke_lid() {
    union() {
        difference () {
            cube([lidWidth, lidLength, lidThickness]);
            for (i = [0:1]) {
                translate([0, ledButtonDiameter + i * rowWidth, -lidThickness * 2]) {
            // led buttons
                    translate([ledButtonDiameter / 2 + controlOffset, 0, 0])
                        momentary_button();
            // encoders
                    translate([ledButtonDiameter / 2 + controlOffset + 2 * controlOffset + latchButtonDiameter / 2 + encoderLength / 4, 0, 0])
                    rotate([0, 0, 270])
                        encoder();
            // latch buttons
                    translate([ledButtonDiameter / 2 + controlOffset + 2 * controlOffset + latchButtonDiameter / 2 + encoderLength + 5, 0, 0])
                        latch_button();
            
                }
            }
            translate([lidScrewBoundaryOffset/2, lidScrewBoundaryOffset/2, -.1])
                cylinder(h=lidThickness * 2, d=lidScrewDiameter);
            translate([lidWidth - lidScrewBoundaryOffset/2, lidScrewBoundaryOffset/2, -.1])
                cylinder(h=lidThickness * 2, d=lidScrewDiameter);
            translate([lidScrewBoundaryOffset/2, lidLength - lidScrewBoundaryOffset/2, -.1])
                cylinder(h=lidThickness * 2, d=lidScrewDiameter);
            translate([lidWidth - lidScrewBoundaryOffset/2, lidLength - lidScrewBoundaryOffset/2, -.1])
                cylinder(h=lidThickness * 2, d=lidScrewDiameter);
        }
    }
}

module string_lid() {
    union() {
        difference () {
            union() {
                cube([lidWidth, lidLength, lidThickness]);
            }
            translate([lidScrewBoundaryOffset/2, lidScrewBoundaryOffset/2, -.1])
                cylinder(h=lidThickness * 2, d=lidScrewDiameter);
            translate([lidWidth - lidScrewBoundaryOffset/2, lidScrewBoundaryOffset/2, -.1])
                cylinder(h=lidThickness * 2, d=lidScrewDiameter);
            translate([lidScrewBoundaryOffset/2, lidLength - lidScrewBoundaryOffset/2, -.1])
                cylinder(h=lidThickness * 2, d=lidScrewDiameter);
            translate([lidWidth - lidScrewBoundaryOffset/2, lidLength - lidScrewBoundaryOffset/2, -.1])
                cylinder(h=lidThickness * 2, d=lidScrewDiameter);
            for (i = [0:7])
                translate([15 + stringWidth * i * 1.5, 5, -.01])
                    rotate([0, 0, 90])
                        hull() string();
        }
        for (i = [0:7])
            translate([15 + stringWidth * i * 1.5, 5, 0])
                rotate([0, 0, 90])
                    string();
   }
}

boxHeight = 45;
screwTabDim = 10;
boxThickness = lidThickness;
boxWidth = lidWidth;
boxLength = lidLength;
boxScrewDiameter = lidScrewDiameter;
module spoke_box() {
    difference() {
        union() {
             difference () {
                union() {
                    cube([lidWidth, lidLength, lidThickness]);
                    for (i = [0,1])
                        for (j = [0,1]) {
                            translate([i * lidWidth - i * screwTabDim, j * lidLength - j * screwTabDim, 0])
                                cube([screwTabDim, screwTabDim, boxHeight]);
                    }
                    cube([boxWidth, boxThickness, boxHeight]);
                    translate([0, boxLength - boxThickness, 0])
                        cube([boxWidth, boxThickness, boxHeight]);
                    cube([boxThickness, boxLength, boxHeight]);
                    translate([boxWidth - screwTabDim, 0, 0])
                        cube([screwTabDim, boxLength, screwTabDim]);
                }
                for (i = [0,1])
                    for (j = [0,1]) {
                        translate([i * boxWidth - i * screwTabDim + screwTabDim / 2, j * boxLength - j * screwTabDim + screwTabDim / 2, boxHeight - 9])
                            cylinder(h=20, d = lidScrewDiameter);
                    }
                for (i = [1, 2])
                    translate([boxWidth - screwTabDim / 2, i * boxLength / 3, boxThickness])
                        cylinder(h=screwTabDim + .1 - boxThickness, d=boxScrewDiameter);
                translate([boxWidth - screwTabDim / 2, screwTabDim + .1, (boxHeight / 3) * 2])
                    rotate([90, 0, 0])
                        cylinder(h=screwTabDim + .1 - boxThickness, d=boxScrewDiameter);
                translate([boxWidth - screwTabDim / 2, boxLength - boxThickness, (boxHeight / 3) * 2])
                    rotate([90, 0, 0])
                        cylinder(h=screwTabDim + .1 - boxThickness, d=boxScrewDiameter);
            }
        }
    }
}

pentagonRadius = boxLength / (2.0 * sin(180. / 5.));
pentagonR = (1/10) * sqrt(25 + 10 * sqrt(5)) * boxLength;
module pentagon_core() {
    difference() {
        union() {
            cylinder(h=boxThickness, r=pentagonRadius, $fn=5);
            translate([-pentagonR, 0, 0])
                    translate([0, -boxLength / 2, 0])
                        cube([screwTabDim, boxLength, screwTabDim]);
            rotate([0, 0,  36])
                translate([pentagonR - screwTabDim, 0, 0])
                    translate([0, -boxLength / 2, 0])
                        cube([screwTabDim, boxLength, screwTabDim]);
            rotate([0, 0,  2 * 36])
                translate([-pentagonR, 0, 0])
                    translate([0, -boxLength / 2, 0])
                        cube([screwTabDim, boxLength, screwTabDim]);
            rotate([0, 0,  3 * 36])
                translate([pentagonR - screwTabDim, 0, 0])
                    translate([0, -boxLength / 2, 0])
                        cube([screwTabDim, boxLength, screwTabDim]);
            rotate([0, 0,  4 * 36])
                translate([-pentagonR, 0, 0])
                    translate([0, -boxLength / 2, 0])
                        cube([screwTabDim, boxLength, screwTabDim]);
            for (i = [0:4])
                rotate([0, 0, i * 72])
                    for (j = [-1, 1])
                        translate([-pentagonR + screwTabDim / 2, j * boxLength / 2 - j * screwTabDim / 2, 0])   
                            translate([0, 0, boxHeight/2])
                                cube([screwTabDim, screwTabDim, boxHeight], center=true);
        }
        for (i = [0:4])
            rotate([0, 0, i * 72])
                translate([-pentagonR + screwTabDim / 2, 0, 0]) {
                    translate([0, -boxLength / 3 / 2, boxThickness])
                        cylinder(h=screwTabDim + .1 - boxThickness, d=boxScrewDiameter);
                    translate([0, boxLength / 3 / 2, boxThickness])
                        cylinder(h=screwTabDim + .1 - boxThickness, d=boxScrewDiameter);
                }
        for (i = [0:4])
            rotate([0, 0, i * 72])
                for (j = [-1, 1])
                    translate([-pentagonR + screwTabDim / 2, j * boxLength / 2 - (j == -1 ? -1 * screwTabDim : screwTabDim / 4), 0])   
                        translate([0, 0, (boxHeight / 3) * 2])
                            rotate([90, 0, 0])
                                #cylinder(h=screwTabDim + .1 - boxThickness, d=boxScrewDiameter);
         for (i = [0:4])
            rotate([0, 0, i * 72])
                translate([pentagonRadius - (screwTabDim / 3) * 2, 0, boxHeight - 9.9])
                    cylinder(h=10, d=boxScrewDiameter);
   }
}

module pentagon_lid() {
    difference() {
        union() {
            cylinder(h=boxThickness, r=pentagonRadius, $fn=5);
        }
        for (i = [0:4])
            rotate([0, 0, i * 72])
                translate([pentagonRadius - (screwTabDim / 3) * 2, 0, -.1])
                    cylinder(h=10, d=boxScrewDiameter);
        translate([-OLEDWidth / 2, 0, 0]) rotate([0, 0, -18]) {
            translate([0, (OLEDWidth - OLEDDisplayHeight) / 2, -.1])
                cube([OLEDWidth, OLEDDisplayHeight, boxThickness + .2]);
                for (i = [0: 1])
                    for (j = [0: 1])
                        translate([(OLEDWidth - OLEDScrewWidth) / 2 + i * OLEDScrewWidth, (OLEDWidth - OLEDScrewHeight) / 2 + j * OLEDScrewHeight, -.1])
                            cylinder(h=boxThickness + 1, d=OLEDScrewDiameter);
        }
        for (i = [3:4])
            rotate([0, 0, i * 72])
                translate([pentagonRadius - (screwTabDim / 3) * 2, 0, -.1])
                    #cylinder(h=10, d=boxScrewDiameter);
    }
//    display();
}

module screw_tab() {
    difference() {
        cube([screwTabDim, 2 * screwTabDim, boxThickness]);
        for (i = [0,1])
            translate([screwTabDim / 2, screwTabDim / 2 + i * screwTabDim, -.1])
                cylinder(h=10, d=boxScrewDiameter);
    }
}

module case() {
    //translate([0, 0, boxHeight + boxThickness]) spoke_lid();
    //string_lid();
    //spoke_box();
    //screw_tab();
    //pentagon_core();
    //translate([0, 0, boxHeight + boxThickness]) 
        pentagon_lid();
    //display();
}

case();
