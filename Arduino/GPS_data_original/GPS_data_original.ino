static const uint32_t GPSBaud = 38400;
char pos;
char rawData[200];
int index = 0;
void setup() {
  // put your setup code here, to run once:
  Serial.begin(230400);
  Serial1.begin(GPSBaud);
}

void loop() {
  while(Serial1.available() > 0)
  {
    pos = Serial1.read();
    Serial.print(pos);
  }
}
