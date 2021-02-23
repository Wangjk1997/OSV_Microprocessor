#include "Tools.h"
#include <Servo.h>
char input1;
char input2;
String rawData1 = "";
String rawData2 = "";
String buff1 = "";
String buff2 = "";
//String rawData1 = "2021/02/23 07:14:23.829   33.777942178  -84.408359553   286.2368   5  11   2.1005   2.8051   6.4849   0.0000   0.0000   0.0000   0.00    0.0";
//String rawData2 = "2021/02/23 07:14:23.900   33.777958640  -84.408402984   290.6932   5  10   2.1052   3.0819   7.1420   0.0000   0.0000   0.0000   0.00    0.0";
//String buff1 = "2021/02/23 07:14:23.829   33.777942178  -84.408359553   286.2368   5  11   2.1005   2.8051   6.4849   0.0000   0.0000   0.0000   0.00    0.0";
//String buff2 = "2021/02/23 07:14:23.900   33.777958640  -84.408402984   290.6932   5  10   2.1052   3.0819   7.1420   0.0000   0.0000   0.0000   0.00    0.0";

boolean flag1 = false;
boolean flag2 = false;
String command_string = "";
boolean stringComplete = false;
int motor_control_value[6];
Servo s0, s1, s2, s3;

void setup() {
  Serial.begin(230400);
  Serial1.begin(GPSBaud);
  Serial2.begin(GPSBaud);
  rawData1.reserve(200);
  rawData2.reserve(200);
  command_string.reserve(200);
  s0.attach(MOTOR0_PIN);
  s1.attach(MOTOR1_PIN);
  s2.attach(MOTOR2_PIN);
  s3.attach(MOTOR3_PIN);
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
          rawData2 = "";
          }
       }
    }
    if(stringComplete)
    {
      send_gps_data(buff1, buff2);
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
