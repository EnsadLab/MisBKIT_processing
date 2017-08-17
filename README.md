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

**sensorSimulator** is used in order to simulate a sensor entry.


## OSC messaging

Sensors:

/mbk/sensors sensorName sensorValue sensorMin sensorMax

AND:

/mbk/sensors/sensorValue/sensorMin/sensorMax sensorName
(where parameters are added in the adress to be compatible with devices that handle only one parameter per osc message.)

Animations:

/mbk/anims/start animName

/mbk/anims/stop animName

/mbk/anims/loopOn animName

/mbk/anims/loopOff animName


Motors:


