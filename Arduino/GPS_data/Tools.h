#ifndef TOOLS_H_
#define TOOLS_H_
//Constants initialization
static const uint32_t GPSBaud = 38400;

const int MOTOR0_PIN = 9;
const int MOTOR1_PIN = 10;
const int MOTOR2_PIN = 11;
const int MOTOR3_PIN = 8;

static const int COMMAND_EXPIRATION = 500;

void send_gps_data(String buff1, String buff2);
void m_set(int motor,int value);
String getPart(int i , String s, char dlm);
#endif
