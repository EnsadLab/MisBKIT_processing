## Processing examples

This repository contains some processing examples that can be used with the misBKIT software.
It shows some basic osc messaging in order to retrieve sensor values, trigger animations and controlling motors.

## Dependancies

All examples need the library oscP5.
SensorSimulator needs as well the library controlP5.
In order to add a library under processing, go to Sketch->Import Library...->Add library.

Theses examples had been tested on processing 3.0.1

## Description

**animationTrigger** is an example that shows how to start, loop and stop an animation based on key inputs.

**multipleAnimationTrigger** listens to incoming sensor messages and according to the value, trigger animation anim1, anim2 and anim3.

**motorTrigger** listens to incoming sensor messages and according to the value, controls the motor's position and velocity.

**sensorSimulator** is used in order to simulate a sensor entry.


## OSC messaging

**Sensors:**

/mbk/sensors sensorName sensorValue sensorMin sensorMax

AND:

/mbk/sensors/sensorValue/sensorMin/sensorMax sensorName

(where parameters are added in the adress to be compatible with devices that handle only one parameter per osc message.)

**Animations:**

/mbk/anims/start animName

/mbk/anims/stop animName

/mbk/anims/loopOn animName

/mbk/anims/loopOff animName


**Motors:**

/mbk/motors/wheelmode motorIndex

/mbk/motors/jointmode motorIndex

/mbk/motors/wheel/motorIndex value

/mbk/motors/joint/motorIndex value

/mbk/motors/value motorIndex (value will be interpreted by the context of MisBKIT, so either considered as a velocity or as a joint position)

/mbk/motors/stopAll

/mbk/motors/stop motorIndex

