#include <TinyGPS++.h>
#include <Servo.h>
#include "Tools.h"

TinyGPSPlus gps_left;
TinyGPSPlus gps_right;

double Latitude_left = 0;
double Longitude_left = 0;
double Height_left = 0;
double Latitude_right = 0;
double Longitude_right = 0;
double Height_right = 0;
String command_string = "";
boolean stringComplete = false;
int motor_control_value[6];


void setup()
{
  Serial.begin(9600);
  //Serial1 for gps_left
  Serial1.begin(GPSBaud);
  //Serial2 for gps_right
  Serial2.begin(GPSBaud);
  pinMode(PWMA,OUTPUT);
  pinMode(DIRA,OUTPUT);
  pinMode(PWMB,OUTPUT);
  pinMode(DIRB,OUTPUT);
  pinMode(PWMC,OUTPUT);
  pinMode(DIRC,OUTPUT);
  pinMode(PWMD,OUTPUT);
  pinMode(DIRD,OUTPUT);
  pinMode(PWME,OUTPUT);
  pinMode(DIRE,OUTPUT);
  pinMode(PWMF,OUTPUT);
  pinMode(DIRF,OUTPUT);
  command_string.reserve(200);
}

void loop()
{
  // Updating GPS location
  if (Serial1.available() > 0)
  {
    if (gps_left.encode(Serial1.read()))
    { 
      if (gps_left.location.isValid())
      {
//        Latitude_left = gps_left.location.lat();
//        Longitude_left = gps_left.location.lng();
        Latitude_left = gps_left.location.rawLat().deg;
        Longitude_left = gps_left.location.rawLng().deg;
        Height_left = gps_left.altitude.meters();
        }
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

//   Receiving motor control command from matlab and send GPS location to matlab
    if(stringComplete)
    {
      send_gps_location(Latitude_left, Longitude_left, Height_left, Latitude_right, Longitude_right, Height_right, accuracy_String);
      for(int index = 0; index < 6; index++)
      { 
        String subCommandString;
        subCommandString = getPart(index + 2,command_string,',');
        char buff[subCommandString.length()+1];
        subCommandString.toCharArray(buff,subCommandString.length()+1);
        motor_control_value[index] = atoi(buff);
        m_set(index,motor_control_value[index]);
        }
      //Serial.print(command_string);
      command_string = "";
      stringComplete = false;
      }
 }

void serialEvent() 
{
  while (Serial.available()) {
    // get the new byte:
    char inChar = (char)Serial.read(); 
    // add it to the inputString:
    command_string += inChar;
    // if the incoming character is a newline, set a flag
    // so the main loop can do something about it:
    if (inChar == '\n') {
      stringComplete = true;
    } 
  }
}
