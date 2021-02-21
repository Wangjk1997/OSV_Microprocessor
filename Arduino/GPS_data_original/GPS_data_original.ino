static const uint32_t GPSBaud = 38400;
String pos;
void setup() {
  // put your setup code here, to run once:
  Serial.begin(230400);
  Serial1.begin(GPSBaud);
}

void loop() {
  if(Serial1.available() > 0)
  {
    pos = Serial1.read();
    Serial.println(pos);
    }
}
