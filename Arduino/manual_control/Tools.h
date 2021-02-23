#ifndef TOOLS_H_
#define TOOLS_H_
//Constants initialization
static const int accuracy_String = 20;

const int MOTOR0_PIN = 9;
const int MOTOR1_PIN = 10;
const int MOTOR2_PIN = 11;
const int MOTOR3_PIN = 6;

static const int COMMAND_EXPIRATION = 500;

void m_set(int motor,int value);
String getPart(int i , String s, char dlm);
#endif
