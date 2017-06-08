$fn = 64;

// interference fit adjustment for 3D printer
iFitAdjust = .4;
iFitAdjust_d = .25;

// latch buttons
latchButtonDiameter = 13;
latchButtonHeight = 30;
module latch_button() {
    cylinder(h = latchButtonHeight, d = latchButtonDiameter, center = false);
}

// led momentary buttons
ledButtonDiameter = 24;
ledButtonHeight = 33;
module momentary_button() {
    cylinder(h = ledButtonHeight, d = ledButtonDiameter, center = false);
}

// encoders
encoderShaftDiameter = 7;
encoderShaftHeight = 18;
encoderWidth = 18;
encoderLength = 31;
encoderDepth = 8.2;
module encoder() {
    // encoder shaft
    cylinder(h = encoderShaftHeight, d = encoderShaftDiameter, center=false);
    // encoder base
    translate([-encoderWidth/2, -encoderLength/2, -encoderDepth/2])
        cube([encoderWidth, encoderLength, encoderDepth]);
}

// string
stringWallThickness = 1;
stringRecess = 5;
stringLength = 60;
photoresistorWidth = 6.5;
photoresistorLength = 6.5;
photoresistorWireSep = 3.5;
ledLaserDiameter = 8;
ledLaserLength = 10;
wireCasingDepth = 3;
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

// display
i2cOLEDWidth = 27;
i2cOLEDHeight = 16;
i2cOLEDScrewWidth = 20;
i2cOLEDScrewHeight = 22;
module display() {
}

module lid() {
    string();
}

lid();
