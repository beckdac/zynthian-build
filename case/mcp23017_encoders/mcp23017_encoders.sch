EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:mcp23017_encoders-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L MCP23017 U?
U 1 1 5936D760
P 5600 3000
F 0 "U?" H 5500 4025 50  0000 R CNN
F 1 "MCP23017" H 5500 3950 50  0000 R CNN
F 2 "" H 5650 2050 50  0001 L CNN
F 3 "" H 5850 4000 50  0001 C CNN
	1    5600 3000
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 5936D8C2
P 5600 4000
F 0 "#PWR?" H 5600 3750 50  0001 C CNN
F 1 "GND" H 5600 3850 50  0000 C CNN
F 2 "" H 5600 4000 50  0001 C CNN
F 3 "" H 5600 4000 50  0001 C CNN
	1    5600 4000
	1    0    0    -1  
$EndComp
$Comp
L +3V3 #PWR?
U 1 1 5936D8DC
P 5600 2000
F 0 "#PWR?" H 5600 1850 50  0001 C CNN
F 1 "+3V3" H 5600 2140 50  0000 C CNN
F 2 "" H 5600 2000 50  0001 C CNN
F 3 "" H 5600 2000 50  0001 C CNN
	1    5600 2000
	1    0    0    -1  
$EndComp
Text GLabel 6100 3400 2    60   Input ~ 0
SDA
Text GLabel 6100 3300 2    60   Input ~ 0
SCL
$Comp
L GND #PWR?
U 1 1 5936DAF3
P 6100 3800
F 0 "#PWR?" H 6100 3550 50  0001 C CNN
F 1 "GND" H 6100 3650 50  0000 C CNN
F 2 "" H 6100 3800 50  0001 C CNN
F 3 "" H 6100 3800 50  0001 C CNN
	1    6100 3800
	1    0    0    -1  
$EndComp
$Comp
L +3V3 #PWR?
U 1 1 5936DBA1
P 6100 2200
F 0 "#PWR?" H 6100 2050 50  0001 C CNN
F 1 "+3V3" H 6100 2340 50  0000 C CNN
F 2 "" H 6100 2200 50  0001 C CNN
F 3 "" H 6100 2200 50  0001 C CNN
	1    6100 2200
	1    0    0    -1  
$EndComp
$Comp
L Rotary_Encoder_Switch SW?
U 1 1 5936DC2B
P 7500 2350
F 0 "SW?" H 7500 2610 50  0000 C CNN
F 1 "Rotary_Encoder_Switch" H 7500 2090 50  0000 C CNN
F 2 "" H 7400 2510 50  0001 C CNN
F 3 "" H 7500 2610 50  0001 C CNN
	1    7500 2350
	1    0    0    -1  
$EndComp
$Comp
L Rotary_Encoder_Switch SW?
U 1 1 5936DC95
P 7500 3000
F 0 "SW?" H 7500 3260 50  0000 C CNN
F 1 "Rotary_Encoder_Switch" H 7500 2740 50  0000 C CNN
F 2 "" H 7400 3160 50  0001 C CNN
F 3 "" H 7500 3260 50  0001 C CNN
	1    7500 3000
	1    0    0    -1  
$EndComp
$Comp
L Rotary_Encoder_Switch SW?
U 1 1 5936DE0B
P 7500 3650
F 0 "SW?" H 7500 3910 50  0000 C CNN
F 1 "Rotary_Encoder_Switch" H 7500 3390 50  0000 C CNN
F 2 "" H 7400 3810 50  0001 C CNN
F 3 "" H 7500 3910 50  0001 C CNN
	1    7500 3650
	1    0    0    -1  
$EndComp
$Comp
L Rotary_Encoder_Switch SW?
U 1 1 5936DE7B
P 7500 4300
F 0 "SW?" H 7500 4560 50  0000 C CNN
F 1 "Rotary_Encoder_Switch" H 7500 4040 50  0000 C CNN
F 2 "" H 7400 4460 50  0001 C CNN
F 3 "" H 7500 4560 50  0001 C CNN
	1    7500 4300
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 5936E2C4
P 7800 2450
F 0 "#PWR?" H 7800 2200 50  0001 C CNN
F 1 "GND" H 7800 2300 50  0000 C CNN
F 2 "" H 7800 2450 50  0001 C CNN
F 3 "" H 7800 2450 50  0001 C CNN
	1    7800 2450
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 5936E2FC
P 7800 3100
F 0 "#PWR?" H 7800 2850 50  0001 C CNN
F 1 "GND" H 7800 2950 50  0000 C CNN
F 2 "" H 7800 3100 50  0001 C CNN
F 3 "" H 7800 3100 50  0001 C CNN
	1    7800 3100
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 5936E334
P 7800 3750
F 0 "#PWR?" H 7800 3500 50  0001 C CNN
F 1 "GND" H 7800 3600 50  0000 C CNN
F 2 "" H 7800 3750 50  0001 C CNN
F 3 "" H 7800 3750 50  0001 C CNN
	1    7800 3750
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 5936E36C
P 7800 4400
F 0 "#PWR?" H 7800 4150 50  0001 C CNN
F 1 "GND" H 7800 4250 50  0000 C CNN
F 2 "" H 7800 4400 50  0001 C CNN
F 3 "" H 7800 4400 50  0001 C CNN
	1    7800 4400
	1    0    0    -1  
$EndComp
Text GLabel 7800 2250 2    60   Input ~ 0
E1_SW
Text GLabel 7800 2900 2    60   Input ~ 0
E2_SW
Text GLabel 7800 3550 2    60   Input ~ 0
E3_SW
Text GLabel 7800 4200 2    60   Input ~ 0
E4_SW
Text GLabel 7200 2250 0    60   Input ~ 0
E1_A
Text GLabel 7200 2450 0    60   Input ~ 0
E1_B
Text GLabel 7200 2900 0    60   Input ~ 0
E2_A
Text GLabel 7200 3100 0    60   Input ~ 0
E2_B
Text GLabel 7200 3550 0    60   Input ~ 0
E3_A
Text GLabel 7200 3750 0    60   Input ~ 0
E3_B
Text GLabel 7200 4200 0    60   Input ~ 0
E4_A
Text GLabel 7200 4400 0    60   Input ~ 0
E4_B
Text GLabel 5100 3100 0    60   Input ~ 0
E1_A
Text GLabel 5100 3200 0    60   Input ~ 0
E1_B
Text GLabel 5100 3300 0    60   Input ~ 0
E1_SW
Text GLabel 5100 3400 0    60   Input ~ 0
E2_A
Text GLabel 5100 3500 0    60   Input ~ 0
E2_B
Text GLabel 5100 3600 0    60   Input ~ 0
E2_SW
Text GLabel 5100 2200 0    60   Input ~ 0
E3_A
Text GLabel 5100 2300 0    60   Input ~ 0
E3_B
Text GLabel 5100 2400 0    60   Input ~ 0
E3_SW
Text GLabel 5100 2500 0    60   Input ~ 0
E4_A
Text GLabel 5100 2600 0    60   Input ~ 0
E4_B
Text GLabel 5100 2700 0    60   Input ~ 0
E4_SW
Connection ~ 6100 3800
Connection ~ 6100 3700
Wire Wire Line
	6100 3600 6100 3800
$Comp
L GND #PWR?
U 1 1 593721D7
P 7200 2350
F 0 "#PWR?" H 7200 2100 50  0001 C CNN
F 1 "GND" H 7200 2200 50  0000 C CNN
F 2 "" H 7200 2350 50  0001 C CNN
F 3 "" H 7200 2350 50  0001 C CNN
	1    7200 2350
	0    1    1    0   
$EndComp
$Comp
L GND #PWR?
U 1 1 593725DF
P 7200 3000
F 0 "#PWR?" H 7200 2750 50  0001 C CNN
F 1 "GND" H 7200 2850 50  0000 C CNN
F 2 "" H 7200 3000 50  0001 C CNN
F 3 "" H 7200 3000 50  0001 C CNN
	1    7200 3000
	0    1    1    0   
$EndComp
$Comp
L GND #PWR?
U 1 1 59372677
P 7200 3650
F 0 "#PWR?" H 7200 3400 50  0001 C CNN
F 1 "GND" H 7200 3500 50  0000 C CNN
F 2 "" H 7200 3650 50  0001 C CNN
F 3 "" H 7200 3650 50  0001 C CNN
	1    7200 3650
	0    1    1    0   
$EndComp
$Comp
L GND #PWR?
U 1 1 5937270F
P 7200 4300
F 0 "#PWR?" H 7200 4050 50  0001 C CNN
F 1 "GND" H 7200 4150 50  0000 C CNN
F 2 "" H 7200 4300 50  0001 C CNN
F 3 "" H 7200 4300 50  0001 C CNN
	1    7200 4300
	0    1    1    0   
$EndComp
Text GLabel 6100 2700 2    60   Input ~ 0
WiringPi_27
Text GLabel 6100 2600 2    60   Input ~ 0
WiringPi_25
$EndSCHEMATC
