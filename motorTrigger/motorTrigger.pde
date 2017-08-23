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


void triggerMotor(int motorIndex,float value, float valMin, float valMax){
  float val = map(value,valMin,valMax,0,100);
  sendWheelValue(motorIndex,val);
}

void sendMode(int motorIndex, int mode){
  String adress = "/mbk/motors";
  if(mode == 0) adress += "/jointmode";
  else adress += "/wheelmode";
  OscMessage msg = new OscMessage(adress);
  msg.add(motorIndex); // 0: joint, 1: wheel
  oscP5.send(msg, remoteLocation); 
}


void sendValue(int motorIndex, float value){
  String adress = "/mbk/motors/wheeljoint/" + motorIndex;
  OscMessage msg = new OscMessage(adress);
  msg.add(value); 
  oscP5.send(msg, remoteLocation); 
}


void sendWheelValue(int motorIndex, float value){
  String adress = "/mbk/motors/wheel/" + motorIndex;
  OscMessage msg = new OscMessage(adress);
  msg.add(value); 
  oscP5.send(msg, remoteLocation); 
}


void sendJointValue(int motorIndex, float value){
  String adress = "/mbk/motors/joint/" + motorIndex;
  OscMessage msg = new OscMessage(adress);
  msg.add(value); 
  oscP5.send(msg, remoteLocation); 
}


void stopAll(){
  String adress = "/mbk/motors/stopAll";
  OscMessage msg = new OscMessage(adress);
  oscP5.send(msg, remoteLocation); 
}


void stopMotor(int motorIndex){
  String adress = "/mbk/motors/stop";
  OscMessage msg = new OscMessage(adress);
  msg.add(motorIndex);
  oscP5.send(msg, remoteLocation);
}


void mousePressed() {

}

int motorIndex = 0;
void keyPressed() {
  // some messaging tests
  if (key == 'j') {
    sendMode(motorIndex,0); // select joint mode
  }else if(key == 'v'){
    sendMode(motorIndex,1); // select wheel mode
  }else if(key == 'o'){
    sendWheelValue(motorIndex, 50); 
  }else if(key == 'p'){
    sendJointValue(motorIndex, 80);
  }else if(key == 'k'){
    sendValue(motorIndex,30); 
  }else if(key == 's'){
    stopMotor(motorIndex);
  }else if(key == 'q'){
    stopAll();  
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
    triggerMotor(0,theOscMessage.get(1).floatValue(),theOscMessage.get(2).floatValue(), theOscMessage.get(3).floatValue());
  }
}