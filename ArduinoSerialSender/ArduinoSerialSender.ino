int ledPin = 13;      

boolean sensors[6];
int sensorPins[6];

void setup()
{
  // ENABLE THE SENSORS HERE
  sensors[0] = true;
  sensors[1] = false;
  sensors[2] = false;
  sensors[3] = false;
  sensors[4] = false;
  sensors[5] = false;

  // DON'T CHANGE
  sensorPins[0] = A0;
  sensorPins[1] = A1;
  sensorPins[2] = A2;
  sensorPins[3] = A3;
  sensorPins[4] = A4;
  sensorPins[5] = A5;

  pinMode(ledPin, OUTPUT);
  Serial.begin(9600);
}

void loop()
{
  int value;
  for(int i=0; i<6; i++) {
    if(sensors[i]) {
      value = analogRead(sensorPins[i]);
      String out = "/sensor/";
      out += (i+1);
      Serial.println(out);
      Serial.println(value);
    }
  }
  delay(10);
}



