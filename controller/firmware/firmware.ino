#include <Adafruit_MCP23017.h>

#undef DEBUG
#define DEBUG

Adafruit_MCP23017 mcp0, mcp1;

typedef struct encoder {
	Adafruit_MCP23017 *mcpX;	// which mcp chip is this encoder on
	uint8_t pinA, pinB, pinSW;	// which pins are A, B, and SW
	boolean A, B, sw;			// last value of A and B and SW
	int16_t value;				// value of encoder
	int16_t min_value;			// min value encoder can have
	int16_t max_value;			// max value encoder can have
} encoder_t;

#define ENCODERS 8
// setup the encoder data structures
encoder_t encoders[ENCODERS] = {
	{ &mcp0, 0, 1, 2,    true, true, false, 0, 0, 20 },
	{ &mcp0, 3, 4, 5,    true, true, false, 0, 0, 20 },
	{ &mcp0, 8, 9, 10,   true, true, false, 0, 0, 20 },
	{ &mcp0, 11, 12, 13, true, true, false, 0, 0, 20 },
	{ &mcp1, 0, 1, 2,    true, true, false, 0, 0, 20 },
	{ &mcp1, 3, 4, 5,    true, true, false, 0, 0, 20 },
	{ &mcp1, 8, 9, 10,   true, true, false, 0, 0, 20 },
	{ &mcp1, 11, 12, 13, true, true, false, 0, 0, 20 }
};

typedef struct button {
	Adafruit_MCP23017 *mcpX;	// which mcp is this button on, NULL if teensy pin
	uint8_t pin;				// pin #
	boolean sw;					// state of switch
} button_t;

#define BUTTONS 16
button_t buttons[BUTTONS] = {
	{ &mcp0, 6,  false },
	{ &mcp0, 7,  false },
	{ &mcp0, 14, false },
	{ &mcp0, 15, false },
	{ &mcp1, 6,  false },
	{ &mcp1, 7,  false },
	{ &mcp1, 14, false },
	{ &mcp1, 15, false },
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

#ifdef DEBUG
	Serial1.begin(115200);
	Serial1.print("setup...");
#endif

	// intialize the i2c devices
	mcp0.begin(0);
	mcp1.begin(1);

	// setup input pins for encoders, note the encoder
	// pins have their own pullups
	for (i = 0; i < ENCODERS; ++i) {
		encoders[i].mcpX->pinMode(encoders[i].pinA, INPUT);
		encoders[i].mcpX->pinMode(encoders[i].pinB, INPUT);
		encoders[i].mcpX->pinMode(encoders[i].pinSW, INPUT);
		encoders[i].A = encoders[i].mcpX->digitalRead(encoders[i].pinA);
		encoders[i].B = encoders[i].mcpX->digitalRead(encoders[i].pinB);
		encoders[i].sw = encoders[i].mcpX->digitalRead(encoders[i].pinSW);
	}

	// setup input pins and enable pullups
	for (i = 0; i < BUTTONS; ++i) {
		if (buttons[i].mcpX) {
			buttons[i].mcpX->pinMode(buttons[i].pin, INPUT);
			buttons[i].mcpX->pullUp(buttons[i].pin, HIGH);
			buttons[i].sw = buttons[i].mcpX->digitalRead(buttons[i].pin);
		} else {
			pinMode(buttons[i].pin, INPUT_PULLUP);
			buttons[i].sw = digitalRead(buttons[i].pin);
		}
	}

	// read initial values in, assumes all strings are unobstructed
	for (i = 0; i < STRINGS; ++i) {
		strings[i].value = analogRead(strings[i].pin);
	}

#ifdef DEBUG
	Serial1.println("done");

	Serial1.println("analog values for air strings:");
	for (i = 0; i < STRINGS; ++i) {
		Serial1.print("string ");
		Serial1.print(i, DEC);
		Serial1.print(": ");
		Serial1.println(strings[i].value, DEC);
	}
#endif
}

uint16_t gpioAB[2];
boolean A, B, sw;
unsigned int value;

void loop() {
	int i;

	// read all the ports on the mcps
	gpioAB[0] = mcp0.readGPIOAB();
	gpioAB[1] = mcp1.readGPIOAB();

	// process the encoders
	for (i == 0; i < ENCODERS; ++i) {
		if (encoders[i].mcpX == &mcp0) {
			A = bitRead(gpioAB[0], encoders[i].pinA);
			B = bitRead(gpioAB[0], encoders[i].pinB);
			sw = bitRead(gpioAB[0], encoders[i].pinSW);
		} else {
			A = bitRead(gpioAB[1], encoders[i].pinA);
			B = bitRead(gpioAB[1], encoders[i].pinB);
			sw = bitRead(gpioAB[1], encoders[i].pinSW);
		}
		// this needs to actually do something here
		// like report the state change over midi
		if (sw != encoders[i].sw) {
			encoders[i].sw = sw;
		}
		// the encoder has changed state
		// increase?
		if (A != encoders[i].A) {
			encoders[i].A = !encoders[i].A;
			if (encoders[i].A && !encoders[i].B) {
				encoders[i].value += 1;
				if (encoders[i].value > encoders[i].max_value)
					encoders[i].value = encoders[i].max_value;
			}
		}
		// decrease?
		if (B != encoders[i].B) {
			encoders[i].B = !encoders[i].B;
			if (encoders[i].B && !encoders[i].A) {
				encoders[i].value -= 1;
			if (encoders[i].value < encoders[i].min_value)
				encoders[i].value = encoders[i].min_value;
		}
	}

	// process the buttons
	for (i = 0; i < BUTTONS; ++i) {
		if (buttons[i].mcpX == &mcp0) {
			sw = bitRead(gpioAB[0], buttons[i].pin);
		} else if (buttons[i].mcpX == &mcp1) {
			sw = bitRead(gpioAB[1], buttons[i].pin);
		} else {
			sw = digitalRead(buttons[i].pin);
		}
		// this needs to actually do something here
		// like report the state change over midi
		if (sw != buttons[i].sw) {
			buttons[i].sw = sw;
		}
	}

	// this needs to do something with the new value	
	for (i = 0; i < STRINGS; ++i) {
		strings[i].value = analogRead(strings[i].pin);
	}
}
