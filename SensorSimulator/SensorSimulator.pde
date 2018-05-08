/**
 * animationTrigger - MisBKIT
 * example showing how to send value to the misBKIT sensors.
 * /mbk/sensors/ sensorName value minValue maxValue OR
 * /mbk/sensors/ sensorName value OR
 * /mbk/sensors/sensorName value
 */
 
import oscP5.*;
import netP5.*;
import controlP5.*;

OscP5 oscP5;
NetAddress remoteLocation;
ControlP5 cp5;

int sliderValue = 0;
int oldSliderValue = 0;
String sensor_name = "sensor_test";

void setup() {
  size(400,400);
  frameRate(25);
  /* start oscP5, listening for incoming messages at port 5555 */
  oscP5 = new OscP5(this,5555);
  
  /* remoteLocation is a NetAddress. a NetAddress takes 2 parameters,
   * an ip address and a port number. remoteLocation is used as parameter in
   * oscP5.send() when sending osc packets to another computer, device, 
   * application. usage see below. for testing purposes the listening port
   * and the port of the remote location address are the same, hence you will
   * send messages back to this sketch.
   */
  remoteLocation = new NetAddress("127.0.0.1",4444);
  
  cp5 = new ControlP5(this);
  
  // add a horizontal sliders, the value of this slider will be linked
  // to variable 'sliderValue' 
  cp5.addSlider("sliderValue")
     .setPosition(100,50)
     .setSize(200,50)
     .setRange(0,100)
     ;
   
}


void draw() {
  background(0);  
  if(oldSliderValue != sliderValue){
    sendSensorValue(sensor_name,sliderValue);
  }
  oldSliderValue = sliderValue;
}


void sendSensorValue(String name, int value) {
  OscMessage msg = new OscMessage("/mbk/sensors");
  msg.add(name);
  float v = float(value)/100.0;
  msg.add(v);
  //print(msg);
  oscP5.send(msg, remoteLocation); 
}


void mousePressed() {

}

void keyPressed() {
  if (key == 'r') {
    sendSensorValue(sensor_name,int(random(100)));
  }
}


/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());
}