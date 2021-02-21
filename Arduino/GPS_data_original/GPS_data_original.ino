static const uint32_t GPSBaud = 38400;
char input1;
char input2;
char rawData1[200];
char rawData2[200];
int index1 = 0;
int index2 = 0;
bool flag1 = 0;
bool flag2 = 0;
void setup() {
  // put your setup code here, to run once:
  Serial.begin(230400);
  Serial1.begin(GPSBaud);
  Serial2.begin(GPSBaud);
}

void loop() {
  if(Serial1.available() > 0)
  {
    input1 = Serial1.read();
    if(input1 != '\n')
    {
        if(flag1 == 1)
        {
          rawData1[index1] = input1;
          index1++;
          }
      }
    else
    {
        if(flag1 == 0)
        {
          flag1 = 1;
          }
        else
        {
          rawData1[index1] = input1;
          index1 = 0;
          Serial.print(rawData1);
          }
       }
    }
  if(Serial2.available() > 0)
  {
    input2 = Serial2.read();
    if(input2 != '\n')
    {
        if(flag2 == 1)
        {
          rawData2[index2] = input2;
          index2++;
          }
      }
    else
    {
        if(flag2 == 0)
        {
          flag2 = 1;
          }
        else
        {
          rawData2[index2] = input2;
          index2 = 0;
          Serial.print(rawData2);
          }
       }
    }
}
