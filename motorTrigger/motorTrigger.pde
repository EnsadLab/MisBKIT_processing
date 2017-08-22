/**
 * motorTrigger - MisBKIT
 * example showing how to receive sensor values from MisBKIT and how to control motors directly from here.
 *  
 */
 
import oscP5.*;
import netP5.*;
  
OscP5 oscP5;
NetAddress remoteLocation;


void setup() {
  size(400,400);
  frameRate(25);
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this,6666);
  
  /* remoteLocation is a NetAddress. a NetAddress takes 2 parameters,
   * an ip address and a port number. remoteLocation is used as parameter in
   * oscP5.send() when sending osc packets to another computer, device, 
   * application. usage see below. for testing purposes the listening port
   * and the port of the remote location address are the same, hence you will
   * send messages back to this sketch.
   */
  remoteLocation = new NetAddress("127.0.0.1",4444);

}


void draw() {
  background(0);  
}


void sendMode(int mode, int motorIndex){
  String adress = "/mbk/motors";
  if(mode == 0) adress += "/modejoint";
  else adress += "/modewheel";
  OscMessage msg = new OscMessage(adress);
  msg.add(motorIndex); // 0: joint, 1: wheel
  oscP5.send(msg, remoteLocation); 
}


void sendValue(int value){

}


void sendWheelValue(int value){

}


void sendJointValue(int value){

}


void mousePressed() {

}

void keyPressed() {
  if (key == 'm') {
    
  }
}


/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());
  if(theOscMessage.addrPattern().equals("/mbk/sensors") && theOscMessage.typetag().equals("sfff")){
    println("args: " + theOscMessage.get(0).stringValue() + " " + theOscMessage.get(1).floatValue()
            + " " + theOscMessage.get(2).floatValue() + " " + theOscMessage.get(3).floatValue());
    //triggerAnimation(theOscMessage.get(0).stringValue(),theOscMessage.get(1).floatValue(),
      //            theOscMessage.get(2).floatValue(), theOscMessage.get(3).floatValue());
  }
}