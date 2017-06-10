$fn = 64;

use <raspberrypi.scad>

// interference fit adjustment for 3D printer
iFitAdjust = .4;
iFitAdjust_d = .25;

// waveshare 5" knock off
displayScreenWidth = 119;
displayScreenHeight = 72;
displayScreenThickness = 3;
displayScreenYOffset = 3.5;
displayBoardWidth = 122;
displayBoardHeight = 79;
displayBoardThickness = 7;
displayDepth = 22;
displayScrewDiameter = 3;
module display() {
    // screen
    translate([-displayScreenWidth / 2, -displayScreenHeight / 2, 0])
        cube([displayScreenWidth, displayScreenHeight, displayScreenThickness], center=false);
    // board
    translate([-displayBoardWidth / 2, -displayBoardHeight / 2 + displayScreenYOffset, -displayBoardThickness])
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
                        cylinder(h=2 * displayBoardThickness + 2, d = displayScrewDiameter + iFitAdjust_d);
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
                        cylinder(h=displayBoardThickness + 2, d = displayScrewDiameter + iFitAdjust_d * 2);
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

mcp23017BoardWidth = 40;
mcp23017BoardLength = 60;
mcp23017BoardHeight = 1.4;
mcp23017BoardScrewDiameter = 2;
mcp23017BoardScrewInset = 1.7;
header40PinWidth = 4.8;
header40PinLength = 51;
header40PinHeight = 11;
header40pinInsetL = 4.5;
header40pinInsetW = 4.5;
mcpToHifiOffset = 10.2;
hifiBoardWidth = 56;
hifiBoardLength = 65.3;
hifiBoardHeight = 1.4;
hifiBoardCutoutWidth = lidThickness * 3;
hifiBoardCutoutLength = 46;
hifiBoardCutoutHeight = 14.5;
hifiBoardScrewDiameter = 4;
hifiBoardScrewInset = 3.7;
hifiMcpWidth = mcp23017BoardWidth - mcpToHifiOffset + hifiBoardWidth;
module hifi_mcp23017_boards() {
    // mcp23017 protoboard
    color("limegreen")
    difference() {
        // board
        cube([mcp23017BoardWidth, mcp23017BoardLength, mcp23017BoardHeight]);
        // screw holes
        translate([mcp23017BoardScrewInset, mcp23017BoardScrewInset, -.1])
            cylinder(d=mcp23017BoardScrewDiameter, h=mcp23017BoardHeight + .2);
        translate([mcp23017BoardWidth - mcp23017BoardScrewInset, mcp23017BoardScrewInset, -.1])
            cylinder(d=mcp23017BoardScrewDiameter, h=mcp23017BoardHeight + .2);
        translate([mcp23017BoardScrewInset, mcp23017BoardLength - mcp23017BoardScrewInset, -.1])
            cylinder(d=mcp23017BoardScrewDiameter, h=mcp23017BoardHeight + .2);
        translate([mcp23017BoardWidth - mcp23017BoardScrewInset, mcp23017BoardLength - mcp23017BoardScrewInset, -.1])
            cylinder(d=mcp23017BoardScrewDiameter, h=mcp23017BoardHeight + .2);
    }
    // 40 pin header
    color("black")
    translate([header40pinInsetL, header40pinInsetW, mcp23017BoardHeight])
        cube([header40PinWidth, header40PinLength, header40PinHeight]);
    // sainsmart pifi dac board
    color("darkgrey") 
    translate([-hifiBoardWidth + mcpToHifiOffset, 0, mcp23017BoardHeight + header40PinHeight])
    difference() {
        // board
        cube([hifiBoardWidth, hifiBoardLength, hifiBoardHeight]);
        // screw holes
        translate([hifiBoardScrewInset, hifiBoardScrewInset, -.1])
            cylinder(d=hifiBoardScrewDiameter, h=hifiBoardHeight + .2);
        translate([hifiBoardWidth - hifiBoardScrewInset, hifiBoardScrewInset, -.1])
            cylinder(d=hifiBoardScrewDiameter, h=hifiBoardHeight + .2);
        translate([hifiBoardScrewInset, hifiBoardLength - hifiBoardScrewInset, -.1])
            cylinder(d=hifiBoardScrewDiameter, h=hifiBoardHeight + .2);
        translate([hifiBoardWidth - hifiBoardScrewInset, hifiBoardLength - hifiBoardScrewInset, -.1])
            cylinder(d=hifiBoardScrewDiameter, h=hifiBoardHeight + .2);
    }
    color("darkgrey") 
    translate([-hifiBoardWidth + mcpToHifiOffset - hifiBoardCutoutWidth / 2, hifiBoardLength / 2 - hifiBoardCutoutLength / 2, mcp23017BoardHeight + header40PinHeight])
        cube([hifiBoardCutoutWidth, hifiBoardCutoutLength, hifiBoardCutoutHeight]);
}

anker7PortHubHeight = 44.5;
anker7PortHubLength = 110;
anker7PortHubWidth = 23;
module anker_7port_usb_hub() {
    color("black")
    translate([0, 0, boxThickness])
        cube([anker7PortHubWidth, anker7PortHubLength, anker7PortHubHeight]);
}

// box with pi mounts and holes
rPi3BottomSpacer = 4;
rPi3Length = 85;
rpi3Width = 56;
boxHeight = 80;
boxThickness = lidThickness;
hifiMcpSpacer = 4;
module box() {

    // bottom
    translate([-(displayBoardWidth * 1.5 + encoderWidth * 1.1)/2, -(displayBoardHeight * 1.25 + encoderLength)/2, 0])
            cube([displayBoardWidth * 1.5 + encoderWidth * 1.1, displayBoardHeight * 1.25 +            encoderLength, boxThickness]);
    // pi mount holes
    translate([(displayBoardWidth * 1.5 + encoderWidth * 1.1)/2 - rPi3Length / 2, (displayBoardHeight * 1.25 + encoderLength)/2 - 29, boxThickness + rPi3BottomSpacer])
        pi3();
    // sides
    for (i = [-1, 1])
        translate([-(displayBoardWidth * 1.5 + encoderWidth * 1.1)/2, -i * (displayBoardHeight * 1.25 + encoderLength)/2 - (i == -1 ? boxThickness : 0), 0])
            cube([displayBoardWidth * 1.5 + encoderWidth * 1.1, boxThickness, boxHeight]);
    for (i = [-1, 1])
        translate([-i * (displayBoardWidth * 1.5 + encoderWidth * 1.1)/2 - (i == -1 ? boxThickness : 0), -(displayBoardHeight * 1.25 + encoderLength)/2, 0])
            cube([boxThickness, displayBoardHeight * 1.25 + encoderLength, boxHeight]);
    // pi usb / ethernet cutou

    // hifi audio out board with mcp23017 board
    rotate([0, 0, 90])
    translate([-(displayBoardWidth * 1.5 + encoderWidth * 1.1)/2 + hifiMcpWidth, 0, boxThickness + hifiMcpSpacer])
        hifi_mcp23017_boards();
    // anker usb power hub
    anker_7port_usb_hub();
 //   translate([0,0,boxHeight + 2])
 //       lid();
}

//display();
//encoder();
//lid();
//display_mount_tabs();
box();