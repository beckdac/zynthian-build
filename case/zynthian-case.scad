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
    translate([-displayScreenWidth / 2, -displayScreenHeight / 2, 0])
        cube([displayScreenWidth, displayScreenHeight, displayScreenThickness], center=false);
    // board
    translate([-displayBoardWidth / 2, -displayBoardHeight / 2, -displayBoardThickness])
        cube([displayBoardWidth, displayBoardHeight, displayBoardThickness], center=false);
}

displayMountThickness = displayBoardThickness;
displayMountScrewOffset = 2;
module display_mount() {
    // corner tabs
    for (i = [-1,1])
        for (j = [-1,1]) {
            translate([i * displayBoardWidth/2 + i * displayMountScrewOffset, j * displayBoardHeight/2 + j * displayMountScrewOffset, -displayMountThickness / 2])
                difference() {
                    cube([displayMountTabWidth, displayMountTabHeight, displayMountThickness], center=true);
                    translate([i * 2, j * 2, -displayBoardThickness])
                        cylinder(h=2 * displayBoardThickness + 2, r = displayScrewDiameter + iFitAdjust_d);
                }
        }
}

displayMountTabThickness = 3;
displayMountTabWidth = 15;
displayMountTabHeight = 20;
module display_mount_tabs() {
    // corner tabs
    for (i = [-1,1])
        for (j = [-1,1]) {
            translate([i * displayBoardWidth/2 + i * displayMountScrewOffset, j * displayBoardHeight/2 + j * displayMountScrewOffset, -displayBoardThickness - displayMountTabThickness / 2])
                difference() {
                    cube([displayMountTabWidth, displayMountTabHeight, displayMountTabThickness], center=true);
                    translate([i * 2, j * 2, -displayBoardThickness / 2])
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
lidThickness = displayScreenThickness - .5;
lidScrewDiameter = 3.5;
lidScrewBoundaryOffset = 10;
module lid() {
  //display_mount_tabs();
  
  difference() {
    // face plate
    union() {
        translate([-(displayBoardWidth * 1.5 + encoderWidth * 1.1)/2, -(displayBoardHeight * 1.25 + encoderLength)/2, 0])
            cube([displayBoardWidth * 1.5 + encoderWidth * 1.1, displayBoardHeight * 1.25 +            encoderLength, lidThickness]);
        display_mount();
    }
    // screen cutout
    display();
    // encoder cutout
    for (i = [-1,1])
        for (j = [-1,1]) {
            translate([i * displayBoardWidth/2 + i * (encoderWidth * 1.1), j * displayBoardHeight/2, - encoderShaftHeight / 2 + 2])
                encoder();
        }
    // screw holes
    #for (i = [-1,1])
        for (j = [-1,1]) {
            translate([i * (displayBoardWidth * 1.5 + encoderWidth * 1.1 - lidScrewBoundaryOffset) / 2, j * (displayBoardHeight * 1.25 +            encoderLength - lidScrewBoundaryOffset) / 2, - encoderShaftHeight / 2 + 2])
                cylinder(h=20, d=lidScrewDiameter + iFitAdjust_d);
        }
  }
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