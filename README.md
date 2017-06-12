# zynthian-build
Zynthian RPi-3 build w/ case, controller, etc.

### Note: this is a reference build for the mcp23017 + interrupt based encoders and switches.

* Demo (with terrible instrument choice):
[![Demo](https://img.youtube.com/vi/0LxjHgSQMDI/0.jpg)](https://youtu.be/0LxjHgSQMDI)

DAC:
* https://www.sainsmart.com/sainsmart-hifi-dac-audio-sound-card-module-i2s-interface-for-raspberry-pi-2-b.html
    * header hack:
![hack to add 40pin header](https://raw.githubusercontent.com/beckdac/zynthian-build/master/sainsmart_40pin_header_hack.png)
* webconf for the DAC:
![webconf_DAC](https://raw.githubusercontent.com/beckdac/zynthian-build/master/sainsmart_audio_webonf.png)
MCP23017 details
* Board schematic: ![Board schematic](https://raw.githubusercontent.com/beckdac/zynthian-build/master/case/mcp23017_encoders/mcp23017_encoders.png)
* Zynthian webconf setup should look like this:: ![webconf setup](https://raw.githubusercontent.com/beckdac/zynthian-build/master/case/mcp23017_encoders/zynthian_webconf_setup.png)

Assembly photos:
* Lid inside ![Lid inside](https://raw.githubusercontent.com/beckdac/zynthian-build/master/case/lid-inside.jpg)
* Lid outside ![Lid outside](https://raw.githubusercontent.com/beckdac/zynthian-build/master/case/lid-outside.jpg)
* Case inside ![Case inside](https://raw.githubusercontent.com/beckdac/zynthian-build/master/case/case-inside.jpg)
* Final ![Final](https://raw.githubusercontent.com/beckdac/zynthian-build/master/case/final.jpg)

---

### Zynthian case 
Dimensions
* 5" touch display;
    * https://smile.amazon.com/gp/product/B072813CS7/ref=oh_aui_detailpage_o03_s00?ie=UTF8&psc=1
    * appears to be a knock off of the Waveshare 5"
    * Width 118mm
    * Height 70mm
    * Board width 122mm
    * Board height 78.5mm
    * Thickness 7mm
    * Total depth (without cable) 22mm
* Encoder
    * Shaft diameter 7mm
    * Inside depth 8.2mm
    * Width 18mm
    * Length 31mm (with pins)


### Zynthian controller
Dimensions
* Encoder
    * Shaft diameter 7mm
    * Inside depth 8.2mm
    * Width 18mm
    * Length 31mm (with pins)
* Latch buttons
    * Diameter 12.1mm
* LED pushbuttons
    * Diameter 24mm
* Photoresistor
    * Width 5mm
    * Length 4mm
    * Wire separation 3.5mm
* LED laser
    * Diameter 6mm
    * Length 10mm
* i2c OLED
    * Width 27mm
    * Display height 16mm
    * Screw width 20mm
    * Screw height 22.3mm
