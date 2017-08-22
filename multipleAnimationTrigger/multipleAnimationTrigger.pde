/**
 * animationTrigger - MisBKIT
 * example showing how to receive sensor values from MisBKIT and how to start animations through OSC
 * In order to make this example work, you need three animations in MisBKIT called 
 * "anim1", "anim2" and "anim3". 
 */
 
import oscP5.*;
import netP5.*;
  
OscP5 oscP5;
NetAddress remoteLocation;
boolean loop = false;

int oldArea = -1;
int area = -1;

int tolerance = 10;

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
  
  //loopAnimation("anim1", false);
}


void draw() {
  background(0);  
}


void startAnimation(String animName) {
  OscMessage msg = new OscMessage("/mbk/anims/start");
  msg.add(animName);
  oscP5.send(msg, remoteLocation); 
}


void stopAnimation(String animName){
  OscMessage msg = new OscMessage("/mbk/anims/stop");
  msg.add(animName);
  oscP5.send(msg, remoteLocation); 
}


void loopAnimation(String animName, boolean on){
  String address;
  if(on) address = "/mbk/anims/loopOn";
  else address = "/mbk/anims/loopOff";
  OscMessage msg = new OscMessage(address);
  msg.add(animName);
  oscP5.send(msg, remoteLocation); 
}


void triggerAnimation(String sensorName, float value, float valMin, float valMax){
  
  float oneThird = (valMax-valMin)/3.0 + valMin;
  float twoThird = 2.0*(valMax-valMin)/3.0 + valMin;
  println("THIRDS: " + oneThird + " " + twoThird);
  
  if(value >= valMin && value < oneThird-tolerance) {
    area = 1;
    if(area != oldArea){
      loopAnimation("anim1", true);
      startAnimation("anim1");
      stopAnimation("anim2");
      stopAnimation("anim3");
    }
  }else if(value >= oneThird+tolerance && value < twoThird-tolerance){
    area = 2;
    if(area != oldArea){
      loopAnimation("anim2", true);
      startAnimation("anim2");
      stopAnimation("anim1");
      stopAnimation("anim3");
    }
  }else if(value >= twoThird+tolerance && value < valMax){
    area = 3;
    if(area != oldArea){
      loopAnimation("anim3", true);
      startAnimation("anim3");
      stopAnimation("anim1");
      stopAnimation("anim2");
    }
  }
  
}

void mousePressed() {

}

void keyPressed() {
  if (key == 'p') {
    startAnimation("anim1");
  }else if(key == 's'){
    stopAnimation("anim1");
  }else if(key == 'l'){
    loop = !loop;
    loopAnimation("anim1", loop);
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
    triggerAnimation(theOscMessage.get(0).stringValue(),theOscMessage.get(1).floatValue(),
                  theOscMessage.get(2).floatValue(), theOscMessage.get(3).floatValue());
  }
}