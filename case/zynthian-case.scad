$fn = 64;

// interference fit adjustment for 3D printer
iFitAdjust = .4;
iFitAdjust_d = .25;

// waveshare 5" knock off
displayScreenWidth = 118;
displayScreenHeight = 70;
displayScreenThickness = 3;
displayBoardWidth = 122;
displayBoardHeight = 78.5;
displayBoardThickness = 7;
displayDepth = 22;
displayScrewDiameter = 3;
module display() {
    // screen
    %translate([-displayScreenWidth / 2, -displayScreenHeight / 2, 0])
        cube([displayScreenWidth, displayScreenHeight, displayScreenThickness], center=false);
    // board
    %translate([-displayBoardWidth / 2, -displayBoardHeight / 2, -displayBoardThickness])
        cube([displayBoardWidth, displayBoardHeight, displayBoardThickness], center=false);
    // corner tabs
    for (i = [-1,1])
        for (j = [-1,1]) {
            translate([i * displayBoardWidth/2, j * displayBoardHeight/2, -displayBoardThickness])
                difference() {
                    cube([20, 20, 3], center=true);
                    translate([i *2, j * 2, -displayBoardThickness / 2])
                        cylinder(h=displayBoardThickness + 2, r = displayScrewDiameter + iFitAdjust_d);
                }
        }
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

// lid with screen and encoders
module lid() {
  difference() {
    // face plate
    translate([-(displayBoardWidth * 1.5 + encoderWidth * 1.1)/2, -(displayBoardHeight * 1.25 + encoderLength)/2, -displayBoardThickness / 2])
        cube([displayBoardWidth * 1.5 + encoderWidth * 1.1, displayBoardHeight * 1.25 +            encoderLength, displayScreenThickness / .5 ]);
    // screen cutout
 display()    ;
  }
    // encoder cutout
    // screw holes
}

// box with pi mounts and holes
module box() {
    // bottom
    // pi mount holes
    // sides
    // pi usb / ethernet
    // hifi audio out
}

//display();
//encoder();
lid();