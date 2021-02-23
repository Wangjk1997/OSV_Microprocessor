#include "Tools.h"
#include <Servo.h>

Servo s0, s1, s2, s3; //4 servos in current phase
int motor_control_value[6];
String command_string = "$01,SETM,400,400,400,400,400,400";
boolean stringComplete = false;

void setup() {
  Serial.begin(230400);
  command_string.reserve(200);
  s0.attach(MOTOR0_PIN);
  s1.attach(MOTOR1_PIN);
  s2.attach(MOTOR2_PIN);
  s3.attach(MOTOR3_PIN);
}

void loop() {
  if(stringComplete)
    {
      for(int index = 0; index < 6; index++)
      { 
        String subCommandString;
        subCommandString = getPart(index + 2,command_string,',');
        char buff[subCommandString.length()+1];
        subCommandString.toCharArray(buff,subCommandString.length()+1);
        motor_control_value[index] = atoi(buff);
        m_set(index,motor_control_value[index]);
        }
      Serial.print(command_string);
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
