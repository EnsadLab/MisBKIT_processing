/**
 * animationTrigger - MisBKIT
 * example showing how to trigger animations through OSC
 * In order to make this example work, you need an animation in MisBKIT called "anim1".
 */
 
import oscP5.*;
import netP5.*;
  
OscP5 oscP5;
NetAddress remoteLocation;
boolean loop = false;


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

}