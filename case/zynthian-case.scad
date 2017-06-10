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
higiMcpLength = hifiBoardLength;
module hifi_mcp23017_board_mount() {
    difference() {
        union() {
            // mcp board
            cube([mcp23017BoardScrewInset * 2, mcp23017BoardScrewInset * 2, hifiMcpSpacer]);
            translate([mcp23017BoardWidth - mcp23017BoardScrewInset * 2, 0, 0])
                cube([mcp23017BoardScrewInset * 2, mcp23017BoardScrewInset * 2, hifiMcpSpacer]);
            translate([0, mcp23017BoardLength - mcp23017BoardScrewInset * 2, 0])
                cube([mcp23017BoardScrewInset * 2, mcp23017BoardScrewInset * 2, hifiMcpSpacer]);
            translate([mcp23017BoardWidth - mcp23017BoardScrewInset * 2, mcp23017BoardLength - mcp23017BoardScrewInset * 2, 0])
                cube([mcp23017BoardScrewInset * 2, mcp23017BoardScrewInset * 2, hifiMcpSpacer]);
            // hifi board
            translate([-hifiBoardWidth + mcpToHifiOffset, 0, 0])
                cube([hifiBoardScrewInset * 2, hifiBoardScrewInset * 2, mcp23017BoardHeight + header40PinHeight + hifiMcpSpacer]);
            translate([-hifiBoardWidth + mcpToHifiOffset, hifiBoardLength - hifiBoardScrewInset * 2, 0])
                cube([hifiBoardScrewInset * 2, hifiBoardScrewInset * 2, mcp23017BoardHeight + header40PinHeight + hifiMcpSpacer]);
        }
        // screw holes
        translate([mcp23017BoardScrewInset, mcp23017BoardScrewInset, -.1])
            cylinder(d=mcp23017BoardScrewDiameter, h=20);
        translate([mcp23017BoardWidth - mcp23017BoardScrewInset, mcp23017BoardScrewInset, -.1])
            cylinder(d=mcp23017BoardScrewDiameter, h=20);
        translate([mcp23017BoardScrewInset, mcp23017BoardLength - mcp23017BoardScrewInset, -.1])
            cylinder(d=mcp23017BoardScrewDiameter, h=20);
        translate([mcp23017BoardWidth - mcp23017BoardScrewInset, mcp23017BoardLength - mcp23017BoardScrewInset, -.1])
            cylinder(d=mcp23017BoardScrewDiameter, h=20);
        translate([-hifiBoardWidth + mcpToHifiOffset + hifiBoardScrewInset, hifiBoardScrewInset, mcp23017BoardHeight + header40PinHeight - 10])
                cylinder(d=hifiBoardScrewDiameter, h=20);
        translate([-hifiBoardWidth + mcpToHifiOffset + hifiBoardScrewInset, hifiBoardLength - hifiBoardScrewInset * 2 + hifiBoardScrewInset, mcp23017BoardHeight + header40PinHeight - 10])
                cylinder(d=hifiBoardScrewDiameter, h=20);
    }
}
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
    // 40 pin header
    color("black")
    translate([header40pinInsetL, header40pinInsetW, mcp23017BoardHeight + header40PinHeight + hifiBoardHeight])
        cube([header40PinWidth, header40PinLength, header40PinHeight]);

}

anker7PortHubHeight = 44.5;
anker7PortHubLength = 110;
anker7PortHubWidth = 23;
anker7PortHubPowerDiameter = 10.5;
anker7PortHubPowerHeight = 31;
anker7PortHubPowerLength = 5;
anker7PortHubPowerWidth = 10.4;
anker7PortHubUSBH = 9;
anker7PortHubUSBW = 11;
anker7PortHubUSBHeight = 14.5;
anker7PortHubUSBLength = 5;
anker7PortHubUSBWidth = 9;
module anker_7port_usb_hub() {
    difference() {
        color("black")
        translate([0, 0, boxThickness])
            cube([anker7PortHubWidth, anker7PortHubLength, anker7PortHubHeight]);
        translate([anker7PortHubPowerWidth, anker7PortHubPowerLength, anker7PortHubPowerHeight])
            rotate([90, 0, 0])
                cylinder(h=20, d=anker7PortHubPowerDiameter);
        translate([anker7PortHubUSBWidth - anker7PortHubUSBW / 2, anker7PortHubUSBLength, anker7PortHubUSBHeight - anker7PortHubUSBH/2])
            rotate([90, 0, 0])
                cube([anker7PortHubUSBW, anker7PortHubUSBH, 20]);
    }
}

// box with pi mounts and holes
rPi3BottomSpacer = 6;
rPi3Length = 85;
rpi3Width = 56;
boxHeight = 80;
boxThickness = lidThickness;
hifiMcpSpacer = 6;
screwTabDim = 10;
rpi3USBPowerCordHoleHeight = 7;
rpi3USBPowerCordDiameter = 11;
rpi3USBPowerCordZipDiameter = 3;
rpi3USBPowerCordZipOffset = 9;
module pi3_mounts() {
    difference() {
        union() {    
            translate([-85/2+3.5,-49/2, 0]) cylinder(r=3, h=rPi3BottomSpacer);
            translate([-85/2+3.5, 49/2, 0]) cylinder(r=3, h=rPi3BottomSpacer);
            translate([58-85/2+3.5,-49/2,0]) cylinder(r=3, h=rPi3BottomSpacer);
            translate([58-85/2+3.5, 49/2, 0]) cylinder(r=3, h=rPi3BottomSpacer);
        }
        translate([-85/2+3.5,-49/2,-1]) cylinder(d=2.75, h=20);
        translate([-85/2+3.5, 49/2,-1]) cylinder(d=2.75, h=20);
        translate([58-85/2+3.5,-49/2,-1]) cylinder(d=2.75, h=20);
        translate([58-85/2+3.5, 49/2,-1]) cylinder(d=2.75, h=20);
    }
}
module box(renderPi3=true, renderMcpHifi=true) {
    difference() {
        union() {
            // bottom
            translate([-(displayBoardWidth * 1.5 + encoderWidth * 1.1)/2, -(displayBoardHeight * 1.25 + encoderLength)/2, 0])
                cube([displayBoardWidth * 1.5 + encoderWidth * 1.1, displayBoardHeight * 1.25 +            encoderLength, boxThickness]);
            // sides
            for (i = [-1, 1])
                translate([-(displayBoardWidth * 1.5 + encoderWidth * 1.1)/2, -i * (displayBoardHeight * 1.25 + encoderLength)/2 - (i == -1 ? boxThickness : 0), 0])
                    cube([displayBoardWidth * 1.5 + encoderWidth * 1.1, boxThickness, boxHeight]);
            for (i = [-1, 1])
                translate([-i * (displayBoardWidth * 1.5 + encoderWidth * 1.1)/2 - (i == -1 ? boxThickness : 0), -(displayBoardHeight * 1.25 + encoderLength)/2, 0])
                    cube([boxThickness, displayBoardHeight * 1.25 + encoderLength, boxHeight]);
            // screw tabs
            for (i = [-1,1])
                for (j = [-1,1]) {
                translate([i * (displayBoardWidth * 1.5 + encoderWidth * 1.1 - lidScrewBoundaryOffset) / 2, j * (displayBoardHeight * 1.25 +            encoderLength - lidScrewBoundaryOffset) / 2, boxHeight / 2])
                    cube([screwTabDim, screwTabDim, boxHeight], center = true);
                }
        }
        // hifi audio out board with mcp23017 board
        rotate([0, 0, 90])
            translate([-(displayBoardWidth * 1.5 + encoderWidth * 1.1)/2 + hifiMcpWidth, -(displayBoardHeight * 1.25 + encoderLength / 2) + hifiBoardLength / 2, boxThickness + hifiMcpSpacer])
                hifi_mcp23017_boards();
        // pi usb / ethernet cutout
        rotate([0, 0, 270])
        translate([(displayBoardWidth * 1.5 + encoderWidth * 1.1)/2 - 81, -30, boxThickness + rPi3BottomSpacer])
            pi3();
        // hub port
//        translate([-20, (displayBoardHeight * 1.25 + encoderLength) /2 + 10, boxThickness])
//            rotate([0, 0, 270])
//                translate([0, 0, boxThickness * 2])
//                    cube([anker7PortHubWidth, anker7PortHubLength, anker7PortHubHeight - boxThickness]);
            // screw holes
        translate([0, 0, boxHeight - 50])
        for (i = [-1,1])
        for (j = [-1,1]) {
            translate([i * (displayBoardWidth * 1.5 + encoderWidth * 1.1 - lidScrewBoundaryOffset) / 2, j * (displayBoardHeight * 1.25 +            encoderLength - lidScrewBoundaryOffset) / 2, - encoderShaftHeight / 2 + 2])
                cylinder(h=60, d=lidScrewDiameter + iFitAdjust_d);
        }
        // power cord hole and zip hole
        translate([-(displayBoardWidth * 1.5 + encoderWidth * 1.1)/2 - 1, 15, 0])
        rotate([0, 90, 0])
        translate([-rpi3USBPowerCordHoleHeight - boxThickness, 0, 0]) {
            translate([0, 0, 0])
                cylinder(h=boxThickness * 2, d=rpi3USBPowerCordDiameter);
            translate([-rpi3USBPowerCordZipOffset, 0, 0])
                cylinder(h=boxThickness * 2, d=rpi3USBPowerCordZipDiameter);
        }
    }
    // pi usb / ethernet cutou
    // pi mount holes
    if (renderPi3)
    rotate([0, 0, 270])
        translate([(displayBoardWidth * 1.5 + encoderWidth * 1.1)/2 - 83, -30, boxThickness + rPi3BottomSpacer])
            pi3();
     rotate([0, 0, 270])
        translate([(displayBoardWidth * 1.5 + encoderWidth * 1.1)/2 - 83, -30, boxThickness])
        pi3_mounts();
    // hifi audio out board with mcp23017 board
    if (renderMcpHifi)
    rotate([0, 0, 90])
    translate([-(displayBoardWidth * 1.5 + encoderWidth * 1.1)/2 + hifiMcpWidth, -(displayBoardHeight * 1.25 + encoderLength / 2) + hifiBoardLength / 2, boxThickness + hifiMcpSpacer])
        hifi_mcp23017_boards();
    // mounts for hifi
    rotate([0, 0, 90])
        translate([-(displayBoardWidth * 1.5 + encoderWidth * 1.1)/2 + hifiMcpWidth, -(displayBoardHeight * 1.25 + encoderLength / 2) + hifiBoardLength / 2, boxThickness])
        hifi_mcp23017_board_mount();
    // anker usb power hub
//    translate([-20, (displayBoardHeight * 1.25 + encoderLength) /2 - boxThickness, boxThickness])
//        rotate([0, 0, 270])
//            anker_7port_usb_hub();
 //   translate([0,0,boxHeight + 2])
 //       lid();
}

//display();
//encoder();
//lid();
//display_mount_tabs();
//box();
box(renderPi3=false, renderMcpHifi=false);