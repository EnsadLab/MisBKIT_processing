/**
 * animationTrigger - MisBKIT
 * example showing how to receive sensor values from MisBKIT and how to start animations through OSC
 * 
 */
 
import oscP5.*;
import netP5.*;
  
OscP5 oscP5;
NetAddress remoteLocation;

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
  remoteLocation = new NetAddress("127.0.0.1",5555);
}


void draw() {
  background(0);  
}


void sendSensorValue(int pin, int value) {
  OscMessage msg = new OscMessage("/mbk/sensors");
  //msg.add(animName);
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