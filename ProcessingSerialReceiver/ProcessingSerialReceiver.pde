import processing.serial.*;

Serial port;
ArrayList<Float> sensors;
int sensor;

String arduinoin;
String arduino;

float serialvalue;

float lowthresh;
float highthresh;
boolean onoff;

void setup() {
  size(400,300);
 
  ///////////////////////////////////////////////////////////// SERIAL STUFF
  // List all the available serial ports
  println(Serial.list());
  port = new Serial(this, Serial.list()[5], 9600);
  port.bufferUntil('\n');
  
  sensors = new ArrayList<Float>();
  for(int i=0; i<6; i++) {
    sensors.add(0.0);
  }
  
  arduinoin = "";
  arduino = "nothing received yet";

  serialvalue = 0;

  lowthresh = 400;
  highthresh = 700;
  onoff = false;
  
  textFont(createFont("Verdana", 12));
}

void draw() {
  background(0);
  
  fill(255);  
  for(int i=0; i<6; i++) {
    rect(i * (width/6), (height - sensors.get(i) * height), width/6, height);
  }
  
  fill(255,0,0);
  text(arduino, 10, 20);
}

void serialEvent (Serial myPort) {
  // get the ASCII string:
  String inString = myPort.readStringUntil('\n');
 
  if (inString != null) {
    // trim off any whitespace:
    inString = trim(inString);
    if(inString.equals("/sensor/1")) {
      sensor = 0;
      arduino = arduinoin;
      arduinoin = "";
    } else if(inString.equals("/sensor/2")) {
      sensor = 1;
    } else if(inString.equals("/sensor/3")) {
      sensor = 2;
    } else if(inString.equals("/sensor/4")) {
      sensor = 3;
    } else if(inString.equals("/sensor/5")) {
      sensor = 4;
    } else if(inString.equals("/sensor/6")) {
      sensor = 5;
    } else {
      // convert to an int and map to the screen height:
      float inByte = float(inString);
      inByte = inByte > 1023 ? 1023 : inByte;
      inByte = map(inByte, 0, 1023, 0., 1.);
      serialvalue = inByte;
      
      sensors.set(sensor, serialvalue);
    }
    arduinoin += inString + "\n";
  }
}

