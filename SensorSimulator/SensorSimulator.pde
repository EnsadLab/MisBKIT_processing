/**
 * animationTrigger - MisBKIT
 * example showing how to receive sensor values from MisBKIT and how to start animations through OSC
 * 
 */
 
import oscP5.*;
import netP5.*;
import controlP5.*;

OscP5 oscP5;
NetAddress remoteLocation;
ControlP5 cp5;

int sliderValue = 100;
int oldSliderValue = 100;

void setup() {
  size(400,400);
  frameRate(25);
  /* start oscP5, listening for incoming messages at port 5555 */
  oscP5 = new OscP5(this,8888);
  
  /* remoteLocation is a NetAddress. a NetAddress takes 2 parameters,
   * an ip address and a port number. remoteLocation is used as parameter in
   * oscP5.send() when sending osc packets to another computer, device, 
   * application. usage see below. for testing purposes the listening port
   * and the port of the remote location address are the same, hence you will
   * send messages back to this sketch.
   */
  remoteLocation = new NetAddress("127.0.0.1",5555);
  
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
    sendSensorValue(7,sliderValue);
  }
  oldSliderValue = sliderValue;
}


void sendSensorValue(int pin, int value) {
  OscMessage msg = new OscMessage("/mbk/sensors");
  msg.add(pin);
  msg.add(value);
  oscP5.send(msg, remoteLocation); 
}


void mousePressed() {

}

void keyPressed() {
  if (key == 'r') {
    sendSensorValue(7,int(random(100)));
  }
}


/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());
}