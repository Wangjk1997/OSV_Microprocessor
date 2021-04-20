#include "Tools.h"
  
void send_gps_data(String buff1, String buff2)
{
  Serial.print(buff1);
  Serial.print(" ");
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
