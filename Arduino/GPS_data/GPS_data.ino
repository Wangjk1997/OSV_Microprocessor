#include "Tools.h"

Adafruit_BNO055 bno = Adafruit_BNO055(55);
char input1;
char input2;
String rawData1 = "";
String rawData2 = "";
String buff1 = "";
String buff2 = "";
String rawIMU = "";
//String rawData1 = "2021/02/23 07:14:23.829   33.777942178  -84.408359553   286.2368   5  11   2.1005   2.8051   6.4849   0.0000   0.0000   0.0000   0.00    0.0";
//String rawData2 = "2021/02/23 07:14:23.900   33.777958640  -84.408402984   290.6932   5  10   2.1052   3.0819   7.1420   0.0000   0.0000   0.0000   0.00    0.0";
//String buff1 = process_rawGPS(rawData1);
//String buff2 = process_rawGPS(rawData2);

boolean string_complete_gps1 = false;
boolean string_complete_gps2 = false;
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
  buff1.reserve(200);
  buff2.reserve(200);
  rawIMU.reserve(200);
  s0.attach(MOTOR0_PIN);
  s1.attach(MOTOR1_PIN);
  s2.attach(MOTOR2_PIN);
  s3.attach(MOTOR3_PIN);
  /* Initialize the IMU */
  if(!bno.begin())
  {
    /* There was a problem detecting the BNO055 ... check your connections */
    Serial.print("Ooops, no BNO055 detected ... Check your wiring or I2C ADDR!");
    while(1);
  }
  delay(1000);
  bno.setExtCrystalUse(true);
}

void loop() {
    while(Serial1.available()>0)
    {
      char inChar = (char)Serial1.read();
      rawData1 += inChar;
      if (inChar == '\n') 
      {
        string_complete_gps1 = true;
      } 
    }
    while(Serial2.available()>0)
    {
      char inChar = (char)Serial2.read();
      rawData2 += inChar;
      if (inChar == '\n') 
      {
        string_complete_gps2 = true;
      } 
    }
    if(string_complete_gps1)
    {
      buff1 = process_rawGPS(rawData1);
      rawData1 = "";
      string_complete_gps1 = false;
      }
    if(string_complete_gps2)
    {
      buff2 = process_rawGPS(rawData2);
      rawData2 = "";
      string_complete_gps2 = false;
      }
    
    while (Serial.available())
    {
      char inChar = (char)Serial.read();
      command_string += inChar;
      if (inChar == '\n') 
      {
      stringComplete = true;
      } 
    }
    
    if(stringComplete)
    {
      rawIMU = IMU_data(bno, 5);
      send_data(buff1, buff2, rawIMU);
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
