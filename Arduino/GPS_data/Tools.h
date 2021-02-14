#ifndef TOOLS_H_
#define TOOLS_H_
//Constants initialization
static const uint32_t GPSBaud = 38400;
static const int accuracy_String = 3;

static const int PWMA = 3;
static const int DIRA = 2;
static const int PWMB = 5;
static const int DIRB = 4;
static const int PWMC = 6;
static const int DIRC = 7;
static const int PWMD = 9;
static const int DIRD = 8;
static const int PWME = 10;
static const int DIRE = 13;
static const int PWMF = 11;
static const int DIRF = 12;

static const int COMMAND_EXPIRATION = 500;

void send_gps_location(double Latitude_left, double Longitude_left, double Height_left, double Latitude_right, double Longitude_right, double Height_right, int accuracy_String);
void m_set(int motor,int value);
int command_process(String command_string, int index);
String getPart(int i , String s, char dlm);
#endif
