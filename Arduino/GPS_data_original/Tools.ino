#include "Tools.h"

void send_gps_location(double Latitude_left, double Longitude_left, double Height_left, double Latitude_right, double Longitude_right, double Height_right, int accuracy_String)
{
    Serial.print(Latitude_left, accuracy_String);
    Serial.print(" ");
    Serial.print(Longitude_left, accuracy_String);
    Serial.print(" ");
    Serial.print(Height_left, accuracy_String);
    Serial.print(" ");
    Serial.print(Latitude_right, accuracy_String);
    Serial.print(" ");
    Serial.print(Longitude_right , accuracy_String);
    Serial.print(" ");
    Serial.print(Height_right, accuracy_String);
    Serial.write(13);
    Serial.write(10);
  }

void m_set(int motor,int value)
{    
  if(value<0  ){value=0;} 
  if(value>511){value=511;}
  if (motor==0){
    if(value<256){  
      digitalWrite(DIRA,HIGH);
      analogWrite(PWMA,255-value);
      
    }else{
      digitalWrite(DIRA,LOW);
      analogWrite(PWMA,value-256);
    }
  }
  if (motor==1){
    if(value<256){  
      digitalWrite(DIRB,HIGH);
      analogWrite(PWMB,255-value);
      
    }else{
      digitalWrite(DIRB,LOW);
      analogWrite(PWMB,value-256);
    }
  }
  if (motor==2){
    if(value<256){  
      digitalWrite(DIRC,HIGH);
      analogWrite(PWMC,255-value);
      
    }else{
      digitalWrite(DIRC,LOW);
      analogWrite(PWMC,value-256);
    }
  }
  if (motor==3){
    if(value<256){  
      digitalWrite(DIRD,HIGH);
      analogWrite(PWMD,255-value);
      
    }else{
      digitalWrite(DIRD,LOW);
      analogWrite(PWMD,value-256);
    }
  }
  if (motor==4){
    if(value<256){  
      digitalWrite(DIRE,HIGH);
      analogWrite(PWME,255-value);
      
    }else{
      digitalWrite(DIRE,LOW);
      analogWrite(PWME,value-256);
    }
  }
  if (motor==5){
    if(value<256){  
      digitalWrite(DIRF,HIGH);
      analogWrite(PWMF,255-value);
      
    }else{
      digitalWrite(DIRF,LOW);
      analogWrite(PWMF,value-256);
    }
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
