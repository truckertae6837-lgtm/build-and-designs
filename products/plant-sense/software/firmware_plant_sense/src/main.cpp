#include <Arduino.h>
// PlantSense 3-zone ADC skeleton
const int PIN_TOP=1, PIN_MID=2, PIN_BOT=3;
int dry[3]={3000,3000,3000}, wet[3]={1000,1000,1000};

int pct(int pin, int i){
  int v=analogRead(pin);
  float p=100.0f*(dry[i]-v)/float(dry[i]-wet[i]+1);
  if(p<0)p=0; if(p>100)p=100; return (int)p;
}
const char* label(int p){ if(p<30)return "UNDER"; if(p>75)return "OVER"; return "OK"; }

void setup(){ Serial.begin(115200); }
void loop(){
  int t=pct(PIN_TOP,0), m=pct(PIN_MID,1), b=pct(PIN_BOT,2);
  Serial.printf("TOP %d %s | MID %d %s | BOT %d %s\n", t,label(t), m,label(m), b,label(b));
  delay(1000);
}
