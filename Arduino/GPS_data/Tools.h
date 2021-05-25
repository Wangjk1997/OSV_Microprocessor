#ifndef TOOLS_H_
#define TOOLS_H_

#include <Wire.h>
#include <Servo.h>
#include <Adafruit_Sensor.h>
#include <Adafruit_BNO055.h>
#include <utility/imumaths.h>
//Constants initialization
static const uint32_t GPSBaud = 38400;

const int MOTOR0_PIN = 9;
const int MOTOR1_PIN = 10;
const int MOTOR2_PIN = 11;
const int MOTOR3_PIN = 8;

static const int COMMAND_EXPIRATION = 500;

void send_data(String buff1, String buff2, String buff3);
void m_set(int motor, int value);
String getPart(int i , String s, char dlm);
String IMU_data(Adafruit_BNO055 bno, int accuracy);
#endif
