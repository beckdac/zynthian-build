#include <Adafruit_MCP23017.h>

Adafruit_MCP23017 mcp0, mcp1;

typedef struct encoder {
	Adafruit_MCP23017 mcpX;		// which mcp chip is this encoder on
	uint8_t pinA, pinB, pinSW;	// which pins are A, B, and SW
	boolean A, B, sw;			// last value of A and B and SW
	unsigned int value;			// value of encoder
	unsigned int min_value;		// min value encoder can have
	unsigned int max_value;		// max value encoder can have
} encoder_t;

#define ENCODERS 8
// setup the encoder data structures
encoder_t encoders[ENCODERS] = {
	{ mcp0, 0, 1, 2,    true, true, false, 0, 0, 20 },
	{ mcp0, 3, 4, 5,    true, true, false, 0, 0, 20 },
	{ mcp0, 8, 9, 10,   true, true, false, 0, 0, 20 },
	{ mcp0, 11, 12, 13, true, true, false, 0, 0, 20 },
	{ mcp1, 0, 1, 2,    true, true, false, 0, 0, 20 },
	{ mcp1, 3, 4, 5,    true, true, false, 0, 0, 20 },
	{ mcp1, 8, 9, 10,   true, true, false, 0, 0, 20 },
	{ mcp1, 11, 12, 13, true, true, false, 0, 0, 20 }
};

typedef struct button {
	Adafruit_MCP23017 mcpX;		// which mcp is this button on, NULL if teensy pin
	uint8_t pin;				// pin #
	boolean sw;					// state of switch
} button_t;

#define BUTTONS 16
button_t buttons[BUTTONS] = {
	{ mcp0, 6,  false },
	{ mcp0, 7,  false },
	{ mcp0, 14, false },
	{ mcp0, 15, false },
	{ mcp1, 6,  false },
	{ mcp1, 7,  false },
	{ mcp1, 14, false },
	{ mcp1, 15, false },
	{ NULL, 2,  false },
	{ NULL, 3,  false },
	{ NULL, 4,  false },
	{ NULL, 5,  false },
	{ NULL, 6,  false },
	{ NULL, 7,  false },
	{ NULL, 8,  false },
	{ NULL, 9,  false }
};

// air strings, laser diode pointing at photoresistor
// interupt the laser and it triggers a string pluck
typedef struct string {
	uint8_t pin;
	unsigned int value;
} string_t;

#define STRINGS 8
string_t strings[STRINGS] = {
	{ 0,  0 },
	{ 1,  0 },
	{ 2,  0 },
	{ 3,  0 },
	{ 6,  0 },
	{ 7,  0 },
	{ 8,  0 },
	{ 9,  0 }
};

void setup() {
	int i;

	mcp0.begin(0);
	mcp1.begin(1);

	// setup input pins for encoders, note the encoder
	// pins have their own pullups
	for (i = 0; i < ENCODERS; ++i) {
		encoder[i].mcpX.pinMode(encoder[i].pinA, INPUT);
		encoder[i].mcpX.pinMode(encoder[i].pinB, INPUT);
		encoder[i].mcpX.pinMode(encoder[i].pinSW, INPUT);
	}

	// setup input pins and enable pullups
	for (i = 0; i < BUTTONS; ++i) {
		if (button[i].mcpX) {
			button[i].mcpX.pinMode(button[i].pin, INPUT);
			button[i].mcpX.pullUp(button[i].pin, HIGH);
		} else {
			pinMode(button[i].pin, INPUT_PULLUP);
		}
	}

	// read initial values in, assumes all strings are unobstructed
	for (i = 0; i < STRINGS; ++i) {
		string[i].value = analogRead(string[i].pin);
	}
}

void loop() {
}
