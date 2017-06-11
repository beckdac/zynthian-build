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
ledButtonDiameter = 24;
ledButtonHeight = 33;
module momentary_button(color="white") {
    color(color)
        cylinder(h = ledButtonHeight, d = ledButtonDiameter, center = false);
}

// encoders
encoderShaftDiameter = 7;
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
    OLEDWidth = 27;
i2cOLEDHeight = 16;
i2cOLEDScrewWidth = 20;
i2cOLEDScrewHeight = 22;
module display() {
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

module case() {
    //spoke_lid();
    string_lid();
}

case();
