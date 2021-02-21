#include "Tools.h"

char input1;
char input2;
String rawData1 = "";
String rawData2 = "";
String buff1 = "";
String buff2 = "";
boolean flag1 = false;
boolean flag2 = false;
//double Latitude_left = 0;
//double Longitude_left = 0;
//double Height_left = 0;
//double Latitude_right = 0;
//double Longitude_right = 0;
//double Height_right = 0;
String command_string = "";
boolean stringComplete = false;
//int motor_control_value[6];


void setup() {
  Serial.begin(230400);
  Serial1.begin(GPSBaud);
  Serial2.begin(GPSBaud);
  rawData1.reserve(200);
  rawData2.reserve(200);
  command_string.reserve(200);
}

void loop() {
  if(Serial1.available() > 0)
  {
    input1 = Serial1.read();
    if(input1 != '\n')
    {
        if(flag1 == true)
        {
          rawData1 += input1;
          }
      }
    else
    {
        if(flag1 == false)
        {
          flag1 = true;
          }
        else
        {
          buff1 = rawData1;
          //Serial.print(buff1);
//          String string_Latitude_left;
//          string_Latitude_left = getPart(3,rawData1,' ');
//          Latitude_left = string_Latitude_left.toDouble();
//          String string_Longitude_left;
//          string_Longitude_left = getPart(4,rawData1,' ');
//          Longitude_left = string_Longitude_left.toDouble();
//          String string_Height_left;
//          string_Height_left = getPart(5,rawData1,' ');
//          Height_left = string_Height_left.toDouble();
          rawData1 = "";
          }
       }
    }
  if(Serial2.available() > 0)
  {
    input2 = Serial2.read();
    if(input2 != '\n')
    {
        if(flag2 == true)
        {
          rawData2 += input2;
          }
      }
    else
    {
        if(flag2 == false)
        {
          flag2 = true;
          }
        else
        {
          buff2 = rawData2;
          //Serial.println(buff2);
//          String string_Latitude_right;
//          string_Latitude_right = getPart(3,rawData2,' ');
//          Latitude_right = string_Latitude_right.toDouble();
//          String string_Longitude_right;
//          string_Longitude_right = getPart(4,rawData2,' ');
//          Longitude_right = string_Longitude_right.toDouble();
//          String string_Height_right;
//          string_Height_right = getPart(5,rawData2,' ');
//          Height_right = string_Height_right.toDouble();
          rawData2 = "";
          }
       }
    }
    if(stringComplete)
    {
      //send_gps_location(Latitude_left, Longitude_left, Height_left, Latitude_right, Longitude_right, Height_right, accuracy_String);
      send_gps_data(buff1, buff2);
      for(int index = 0; index < 6; index++)
      { 
        String subCommandString;
        subCommandString = getPart(index + 2,command_string,',');
        char buff[subCommandString.length()+1];
        subCommandString.toCharArray(buff,subCommandString.length()+1);
//        motor_control_value[index] = atoi(buff);
//        m_set(index,motor_control_value[index]);
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
