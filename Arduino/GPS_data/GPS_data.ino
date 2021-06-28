#include "Tools.h"

Adafruit_BNO055 bno = Adafruit_BNO055(55);
char input1;
//String rawData1 = "";
//String buff1 = "";
String rawIMU = "";
String buff_IMU = "";
String rawData1 = "2021/02/23 07:14:23.829   33.777942178  -84.408359553   286.2368   5  11   2.1005   2.8051   6.4849   0.0000   0.0000   0.0000   0.00    0.0";
String buff1 = process_rawGPS(rawData1);

boolean string_complete_gps1 = false;
String command_string = "";
volatile boolean stringComplete = false;
int motor_control_value[6];
Servo s0, s1, s2, s3;

unsigned long tictoc;

void setup() {
  Serial.begin(230400);
  Serial2.begin(GPSBaud);
  while(!Serial){
    ;
  }
  rawData1.reserve(200);
  command_string.reserve(200);
  buff1.reserve(200);
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
  Serial.println("Setup Complete");
  bno.setExtCrystalUse(true);
}

void loop() {
    while(Serial2.available()>0)
    {
      char inChar = (char)Serial2.read();
      rawData1 += inChar;
      if (inChar == '\n') 
      {
        string_complete_gps1 = true;
      } 
    }
    if(string_complete_gps1)
    {
      buff1 = process_rawGPS(rawData1);
      rawData1 = "";
      string_complete_gps1 = false;
      }
//
//    if(Serial.available())
//    {
//      tictoc = millis();
//      }
//    
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
      send_data(buff1, buff_IMU);
//      Serial.println(millis()- tictoc);
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

    rawIMU = IMU_data(bno, 5);
    buff_IMU = rawIMU;
}
