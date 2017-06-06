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
stringWallThickness = 2;
stringRecess = 5;
stringLength = 60;
photoresistorWidth = 5;
photoresistorLength = 4;
photoresistorWireSep = 3.5;
ledLaserDiameter = 6;
ledLaserLength = 10;
module photoresistor_holder() {
    difference() {
        cylinder(h = stringRecess + stringWallThickness * 2, d = 2 * stringWallThickness + photoresistorWidth + iFitAdjust_d, center = false);
        translate([0,0,stringWallThickness + .1])
            cylinder(h = stringRecess + stringWallThickness + 1, d = photoresistorWidth + iFitAdjust_d, center = false);
        for (i = [-1,1])
            translate([i * photoresistorWireSep / 2, 0, -1])
                cylinder(h = 20, d = 1, center = false);
    }
}
module led_holder() {
    difference() {
        cylinder(h = ledLaserLength + stringWallThickness * 2, d = 2 * stringWallThickness + ledLaserDiameter + iFitAdjust_d, center = false);
        translate([0,0,stringWallThickness + .1])
            cylinder(h = ledLaserLength + stringWallThickness + 1, d = ledLaserDiameter + iFitAdjust_d, center = false);
        for (i = [-1,1])
            translate([i * photoresistorWireSep / 2, 0, -1])
                cylinder(h = 20, d = 1, center = false);
    }
}
module string() {
    photoresistor_holder();
    translate([0, 0, stringLength])
        rotate([180, 0, 0])
            led_holder();
    difference() {
        translate([-(ledLaserDiameter + 2 * stringWallThickness)/2, - ledLaserDiameter, 0])
            cube([ledLaserDiameter + 2 * stringWallThickness, ledLaserDiameter / 2, stringLength ], center = false);
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
