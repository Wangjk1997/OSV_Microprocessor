#include "Tools.h"
  
void send_data(String buff1, String buff2)
{
  Serial.print(buff1);
  Serial.print(";");
  Serial.print(buff2);
  Serial.write(13);
  Serial.write(10);
  }

void m_set(int motor,int value){   
  //if(value<0  ){value=0;} 
  //if(value>511){value=511;}
  value=constrain(value,0,511);
  value=map(value,0,511,180,0);
  
  if (motor==0) {
    s0.write(value);
  }
  if (motor==1) {
    s1.write(value);
  }
  if (motor==2) {
    s2.write(value);
  }
  if (motor==3) {
    s3.write(value);
  }
}

String getPart(int i , String s, char dlm)
{
  int bndx = 0;
  int endx = 0;
  int found = 0;
  int ndx = 0;
  char c;
  // if part equals zero then bndx = 0;
  while(found<i & i>0){
    //check to see if range is out of bounds
    if(ndx>=s.length()){
      return "";
    }
    //assign character at ndx
    c=s[ndx];
    //if character is the deliminator
    if(c==dlm){
      bndx = ndx+1;
      found++;
    }
    ndx++;
  }
  //get the next character
  c=s[ndx];
  //find the next comma
  while ((c!=dlm)&(ndx<s.length())){
    ndx++;
    c=s[ndx];
    endx = ndx;
  }
  return s.substring(bndx,endx);
}

String IMU_data(Adafruit_BNO055 bno, int accuracy)
{
  String rawIMU = "";
//  imu::Vector<3> accelerometer = bno.getVector(Adafruit_BNO055::VECTOR_LINEARACCEL);
  imu::Vector<3> linearaccel = bno.getVector(Adafruit_BNO055::VECTOR_LINEARACCEL);
  imu::Vector<3> gyroscope = bno.getVector(Adafruit_BNO055::VECTOR_GYROSCOPE);
  imu::Vector<3> euler = bno.getVector(Adafruit_BNO055::VECTOR_EULER);
  imu::Quaternion quat = bno.getQuat();
  quat.x() = -quat.x();
  quat.y() = -quat.y();
  quat.z() = -quat.z();
  imu::Vector<3> acc;
  acc[0] = (1-2*(quat.y()*quat.y() + quat.z()*quat.z()))*linearaccel[0] + (2*(quat.x()*quat.y() + quat.w()*quat.z()))*linearaccel[1] + (2*(quat.x()*quat.z() - quat.w()*quat.y()))*linearaccel[2];  // rotate linearaccel by quaternion
  acc[1] = (2*(quat.x()*quat.y() - quat.w()*quat.z()))*linearaccel[0] + (1-2*(quat.x()*quat.x() + quat.z()*quat.z()))*linearaccel[1] + (2*(quat.y()*quat.z() + quat.w()*quat.x()))*linearaccel[2];
  acc[2] = (2*(quat.x()*quat.z() + quat.w()*quat.y()))*linearaccel[0] + (2*(quat.y()*quat.z() - quat.w()*quat.x()))*linearaccel[1] + (1-2*(quat.x()*quat.x() + quat.y()*quat.y()))*linearaccel[2];
  
  String accx = String(acc[0], accuracy);
  String accy = String(acc[1], accuracy);
  String accz = String(acc[2], accuracy);
  String gyrox = String(gyroscope.x(), accuracy);
  String gyroy = String(gyroscope.y(), accuracy);
  String gyroz = String(gyroscope.z(), accuracy);
  String eulerx = String(euler.x(), accuracy);
  String eulery = String(euler.y(), accuracy);
  String eulerz = String(euler.z(), accuracy);
  rawIMU = accx + "," + accy + "," + accz + "," + gyrox + "," + gyroy + "," + gyroz + "," + eulerx + "," + eulery + "," + eulerz;
  return rawIMU;
  }

String process_rawGPS(String raw_data)
{
  int flag_space = 0;
  int index_space = 0; 
  String output = "";
  for(int i = 0; i <= raw_data.length(); i++)
  {
    if(isSpace(raw_data[i]))
    {
      if(flag_space == 0)
      {
        flag_space = 1;
        index_space++;
        }
      }
    else
    {
      if(flag_space == 0)
      {
        if(index_space>=2 && index_space<=4)
        {
          output += raw_data[i];
          }
        }
      else
      {
        flag_space = 0;
        if(index_space>=2 && index_space<=4)
        {
          if (index_space!= 2)
          {
            output += ",";
            }
          output += raw_data[i];
          }
        }
      }
    }
    return output;
}
