static const uint32_t GPSBaud = 38400;

void setup()
{
  Serial.begin(9600);
  Serial1.begin(GPSBaud);
}

void loop()
{
  if (Serial1.available() > 0)
  {
    byte dataFromGPS = Serial1.read();
    Serial.println(dataFromGPS);
    }
}
