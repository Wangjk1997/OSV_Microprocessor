#include <TinyGPS++.h>

//A modification here not softwareSerial and 9600 baud
static const uint32_t GPSBaud = 38400;

// The TinyGPS++ object
TinyGPSPlus gps_left;
TinyGPSPlus gps_right;
//position acquired by GPS stored in Arduino
double Latitude_left = 0;
double Longitude_left = 0;
double Height_left = 0;
double Latitude_right = 0;
double Longitude_right = 0;
double Height_right = 0;
int a = 0;
  
void setup()
{
  Serial.begin(9600);
  //Serial1 for gps_left
  Serial1.begin(GPSBaud);
  //Serial2 for gps_right
  Serial2.begin(GPSBaud);
}

void loop()
{
  if (Serial1.available() > 0)
  {
    if (gps_left.encode(Serial1.read()))
    { 
      if (gps_left.location.isValid())
      {
        Latitude_left = gps_left.location.lat();
        Longitude_left = gps_left.location.lng();
        Height_left = gps_left.altitude.meters();
        }
    }
    
  if (Serial2.available() > 0)
  {
    if (gps_right.encode(Serial2.read()))
    {
      if (gps_right.location.isValid())
      {
        Latitude_right = gps_right.location.lat();
        Longitude_right = gps_right.location.lng();
        Height_right = gps_right.altitude.meters();
        }
      }
    }
  if (Serial.available() > 0)
  {
    a = Serial.read();
    Serial.print(Latitude_left);
    Serial.print(" ");
    Serial.print(Longitude_left);
    Serial.print(" ");
    Serial.print(Height_left);
    Serial.print(" ");
    Serial.print(Latitude_right);
    Serial.print(" ");
    Serial.print(Longitude_right);
    Serial.print(" ");
    Serial.print(Height_right);
    Serial.write(13);
    Serial.write(10);
    }
}
