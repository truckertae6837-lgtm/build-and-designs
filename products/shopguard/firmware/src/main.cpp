#include <Arduino.h>
#include <Wire.h>
// ShopGuard minimal skeleton — expand thresholds after calibration
const int PIN_SOS = 4;
const int PIN_PIEZO = 5;
const int PIN_LED = 6;
enum State { IDLE, ARMED, COUNTDOWN, ALARM } state = IDLE;
unsigned long countdownStart = 0;
const unsigned long COUNTDOWN_MS = 20000;

void siren(bool on){ digitalWrite(PIN_PIEZO, on?HIGH:LOW); }
void setLed(int mode){ /* 0 off 1 green 2 amber 3 red — wire as available */ }

void setup(){
  pinMode(PIN_SOS, INPUT_PULLUP);
  pinMode(PIN_PIEZO, OUTPUT);
  pinMode(PIN_LED, OUTPUT);
  Serial.begin(115200);
  state = ARMED;
}

void loop(){
  bool sosPressed = digitalRead(PIN_SOS)==LOW;
  switch(state){
    case ARMED:
      if(sosPressed){ state=ALARM; siren(true); }
      // TODO: IMU fall / no-motion → state=COUNTDOWN; countdownStart=millis();
      break;
    case COUNTDOWN:
      if(sosPressed){ state=ARMED; siren(false); } // cancel
      else if(millis()-countdownStart>COUNTDOWN_MS){ state=ALARM; siren(true); }
      break;
    case ALARM:
      siren(true);
      // TODO: notify phone via BLE
      if(sosPressed){ /* optional silence policy */ }
      break;
    default: break;
  }
}
