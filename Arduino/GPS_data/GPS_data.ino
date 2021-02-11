#include <TinyGPS++.h>

//A modification here not softwareSerial and 9600 baud
static const uint32_t GPSBaud = 38400;

// The TinyGPS++ object
TinyGPSPlus gps_left;
TinyGPSPlus gps_right;
//position acquired by GPS stored in Arduino
double Latitude_left = 0;
double Longitude_left = 0;
double Latitude_right = 0;
double Longitude_right = 0;
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
      Serial.println("left");
      Serial.print(F("Location: ")); 
      if (gps_left.location.isValid())
      {
        Serial.print(gps_left.location.lat(), 6);
        Serial.print(F(","));
        Serial.print(gps_left.location.lng(), 6);
        Serial.println();
        Latitude_left = gps_left.location.lat();
        Longitude_left = gps_left.location.lng();
        }
      else
      {
        Serial.print(F("INVALID"));
        }
      }
    }
    
  if (Serial2.available() > 0)
  {
    if (gps_right.encode(Serial2.read()))
    {
      Serial.println("right");
      Serial.print(F("Location: ")); 
      if (gps_right.location.isValid())
      {
        Serial.print(gps_right.location.lat(), 6);
        Serial.print(F(","));
        Serial.print(gps_right.location.lng(), 6);
        Serial.println();
        Latitude_right = gps_right.location.lat();
        Longitude_right = gps_right.location.lng();
        }
      else
      {
        Serial.print(F("INVALID"));
        }
      }
    }
  if (Serial.available() > 0)
  {
    a = Serial.read();
    Serial.print(Latitude_right);
    Serial.print(" ");
    Serial.print(Longitude_right);
    Serial.write(13);
    Serial.write(10);
    }   
}
