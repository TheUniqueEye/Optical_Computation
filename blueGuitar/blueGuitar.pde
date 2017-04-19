/* 2016-6-7 (Processing 3)
 
 M265 Optical-Computational Processes:  
 
 ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
 ::::::::::::::::::: the BLUE guitar ::::::::::::::::::::::::::::::
 :::::::::::::::::::::::::::::::::::::::::::  Jing YAN ::::::::::::
 ::::::::::::::::::: theuniqueeye@gmail.com :::::::::::::::::::::::
 ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
 ::::::: [VERSION 9] ::::::::::::::::::::::::::::::::::::::::::::*/

/*
-------------------------------------------------------------------------------
 They said, "You have a blue guitar, You do not play things as they are."
 
 The “BLUE GUITAR” is a motion based spatial sound environment project. 
 The intention is to create a potential audio environment that allows user 
 to interact with and gradually reveals and evolves itself through interaction.
 During the project, I also attempt to balance the designed narrative of sound 
 scene and the audience trigger interaction. 
 -------------------------------------------------------------------------------
 Version History >>
 [version8]
 connect kinnect with skeleton detection
 [version7] key interaction version
 refined version6
 piano chord refined 
 color and color transistion refined
 strokewieght refined
 sound cycle refined
 [version6]
 piano chord delay fixed
 visual color transition built
 total sound add to the posY
 [version5]
 scene setting
 [version4]
 add the whisper the walking step and the opening scene
 [version3]
 1st scene - Piano sound built
 [version 2]
 set up with minim sound
 try different component of minim library
 [version 1]
 build verlet wave form with verlet integration
 -------------------------------------------------------------------------------
 Reference >>
 minim library
 http://code.compartmental.net/minim/ugen_class_ugen.html
 https://forum.processing.org/one/topic/counter.html
 the VerletBall&VerletStick class is based on Ira Greenberg's VerletStick example
 https://github.com/irajgreenberg/workshopExamples/blob/master/apression/VerletStick.pde
 Hilda's demo about the user detection
 try supercollider's example to build synthesize sound 
 -------------------------------------------------------------------------------
 Special thanks to Zhenyu and Donghao for rescuing me from brain stuck
 Guide by Prof. George Legrady. 
 -------------------------------------------------------------------------------
 */


import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;
import peasy.test.*;
PeasyCam cam;

import SimpleOpenNI.*;
SimpleOpenNI kinect;
import processing.opengl.*;

import ddf.minim.*;
import ddf.minim.ugens.*;
import ddf.minim.spi.*; 

import java.util.Iterator;

import supercollider.*;
import oscP5.*;


// sound 
Minim minim;
AudioOutput out;
LiveInput in;
Oscil deepSea;
Noise theNoise;
Summer synth; // sum the outputs of multiple UGens
//Wavetable table;
//Midi2Hz midi;

//supercollider
Group group;
Synth synth0, synth1, synth2, synth3;

// sound materials
AudioPlayer whisper, step, tic; // Scene 1
AudioPlayer chord1_0, chord1_1, chord1_2, chord1_3, chord2_0, chord2_1, chord2_2, // Scene 2
chord2_3, chord3_0, chord3_1, chord3_2, chord3_3, chord4_0, chord4_1, chord4_2, chord4_3;

AudioPlayer sea, seaWave, gull_1, gull_2, wind, wave; // Scene 3
AudioPlayer bell, road, park_1, park_2, choir, walk; // Scene 4

// timer
int timerSet = 0;
float targetTime1 = 0, targetTime2 = 0, targetTime3 = 0, targetTime4 = 0;
float time_to_play_sound = 1e20;
int phase = 130;
int timestamp_1 = 5; 
int timestamp_2 = 5+5; 
int timestamp_3 = 5+5+10; 
int timestamp_4 = 5+10+10; 
int timestamp_5 = 5+10+10+5; 
int timestamp_6 = 5+10+10+25; 
int timestamp_7 = 5+10+10+30; 
int timestamp_8 = 5+10+10+30+10; 
int timestamp_9 = 5+10+10+30+25; 
int timestamp_10 = 5+10+10+30+20; 
int timestamp_11 = 5+10+10+30+25+40; 
int timestamp_12 = 5+10+10+30+25+40+10; 

// interaction switches
boolean playStep=false, playChord=false, playNoise=false, playSea=false, playMemo=false, playSynth=false;
boolean user1In, user1Hug, user2In, user2Hug, user3In, user3Hug, user4In, user4Hug;
boolean saveFrame=false, rotateX=false;

// visual 
int particles = 100;
int layers = 30;
VerletBall[][] balls = new VerletBall[particles][layers];
int bonds = particles + particles/2;
VerletStick[][] sticks = new VerletStick[bonds][layers];
float tension;
float posY=0;
float trans=100, transP=100;

// kinect
PVector rightHand, leftHand, rightElbow, leftElbow, head;
boolean skeleton = true;
int[] user_list;
boolean[] handsUp = new boolean[10];
int userId;
//User location
PVector[] com = new PVector[10];
float[] peak = new float[10];
float[] rightHandy = new float[10];
//HashMap<Integer, UserTrackingInfo> user_tracking_info = new HashMap<Integer, UserTrackingInfo>();

// -------------------------------------------------------------------------------

HashMap<AudioPlayer, Float> next_play_times = new HashMap<AudioPlayer, Float>();

void setup() {
  //size(1960, 1080, OPENGL);
  size(1080, 720, OPENGL);
  cam = new PeasyCam(this, 1000); 
  float theta = PI/4.0; 
  float jump; 
  tension = 0.1;


  //////////////  kinect setup ///////////////
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  kinect.setMirror(true);
  kinect.enableUser();
  rightHand = new PVector(0, 0, 0);
  leftHand = new PVector(0, 0, 0);
  com[0] = new PVector(); // user location
  com[1] = new PVector(); // user location
  //coms = new PVector();
  handsUp[0]=false; 

  ///////////// visual setup /////////////////
  //colorMode(HSB, 255); 
  colorMode(RGB, 255); 

  // balls + add interaction 
  for (int j = 0; j<layers; j++) {
    jump = -400.0; 
    for (int i=0; i<particles; i++) {
      PVector push = new PVector(0, 0, 0); 
      PVector p = new PVector(jump, 200, 25*j); 
      balls[i][j]= new VerletBall(p, push, 10);
      theta += TWO_PI/particles;
      jump += 8;
    }
  }

  // sticks external
  for (int j = 0; j<layers; j++) {
    for (int i=0; i<particles; i++) {
      if (i<particles-1) { 
        sticks[i][j] = new VerletStick(balls[i][j], balls[i+1][j], tension);
      }
    }
  }

  /////////////  sound setup /////////////////

  minim = new Minim(this);
  out = minim.getLineOut(); // use the getLineOut method of the Minim object to get an AudioOutput object
  synth = new Summer();

  deepSea = new Oscil( 700, 0.05f, Waves.SINE );
  //deepSea.patch( synth ); // patch to the output
  synth.patch( out ); 

  //// load sound materials //// 
  whisper = minim.loadFile("openning_3.mp3");
  step = minim.loadFile("step.mp3");
  tic = minim.loadFile("tic.mp3");
  chord1_0 = minim.loadFile("chord1_0.mp3");
  chord1_1 = minim.loadFile("chord1_1.mp3");
  chord1_2 = minim.loadFile("chord1_2.mp3");
  chord1_3 = minim.loadFile("chord1_3.mp3");
  chord2_0 = minim.loadFile("chord2_0.mp3");
  chord2_1 = minim.loadFile("chord2_1.mp3");
  chord2_2 = minim.loadFile("chord2_2.mp3");
  chord2_3 = minim.loadFile("chord2_3.mp3");
  chord3_0 = minim.loadFile("chord3_0.mp3");
  chord3_1 = minim.loadFile("chord3_1.mp3");
  chord3_2 = minim.loadFile("chord3_2.mp3");
  chord3_3 = minim.loadFile("chord3_3.mp3");
  chord4_0 = minim.loadFile("chord4_0.mp3");
  chord4_1 = minim.loadFile("chord4_1.mp3");
  chord4_2 = minim.loadFile("chord4_2.mp3");
  chord4_3 = minim.loadFile("chord4_3.mp3");

  sea = minim.loadFile("sea.wav");
  seaWave = minim.loadFile("seaWave.mp3");
  wave = minim.loadFile("wave2.mp3");
  gull_1 = minim.loadFile("gull.mp3");
  gull_2 = minim.loadFile("gull_2.mp3");
  wind = minim.loadFile("wind_2.wav");
  bell = minim.loadFile("bell.mp3");
  road = minim.loadFile("road.mp3");
  park_1 = minim.loadFile("park_1.mp3");
  park_2 = minim.loadFile("park_2.wav");
  choir = minim.loadFile("choir.wav");
  walk = minim.loadFile("walk.mp3");

  /* try connect to supercollider
   group = new Group();
   group.create();
   
   // uses default sc server at 127.0.0.1:57110    
   // does NOT create synth!
   synth0 = new Synth("sine");
   synth1 = new Synth("DecaySin");
   synth2 = new Synth("DecayPink");
   synth3 = new Synth("Reverb");
   
   // set initial arguments
   synth0.set("amp", 0.5);
   synth0.set("freq", 80);
   synth1.set("amp", 0.5);
   synth1.set("freq", 80);
   //  synth2.set("amp", 0.5);
   //  synth2.set("freq", 80);
   synth3.set("amp", 0.5);
   synth3.set("freq", 80);
   */
}


// -------------------------------------------------------------------------------

void draw() {
  // set the stage
  background(0);

  ///////////// kinect detect /////////////////
  kinect.update();
  user_list = kinect.getUsers();

  //user__________________________________________

  if (user_list.length > 0) {

    for (int numbOfUsers = 0; numbOfUsers<user_list.length; numbOfUsers++) {
      userId = user_list[numbOfUsers];

      try {
        kinect.getCoM(user_list[numbOfUsers], com[numbOfUsers]);
      } 
      catch(Exception e) {
      }

      // if we’re successfully calibrated
      if ( kinect.isTrackingSkeleton(userId)) {
        if (skeleton) { // draw user
          pushMatrix(); 
          translate(0, 0, -2500);
          rotateX(radians(180));
          //drawSkeleton(userId);
          popMatrix();
        }

        rightHand = new PVector();
        kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_HAND, rightHand);
        leftHand = new PVector();
        kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_HAND, leftHand);
        rightElbow = new PVector();
        kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW, rightElbow);
        leftElbow = new PVector();
        kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_ELBOW, leftElbow);
        head = new PVector();
        kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_HEAD, head);

        if ((rightHand.y > rightElbow.y && rightHand.x > rightElbow.x) && (leftHand.y > leftElbow.y 
          && leftHand.x > leftElbow.x)) handsUp[numbOfUsers]=true;
        else handsUp[numbOfUsers]=false;

        peak[numbOfUsers]=max(rightHand.y, leftHand.y, head.y);
        rightHandy[numbOfUsers]=rightHand.y;
      }
    }
  }


  ///////////// timer set /////////////////

  timerSet = -11+int(millis()/1000)%(130); // total phase: 3 Min
  textSize(40);
  //text (timerSet, 0, -500, 0);


  ///////////// visual display /////////////////

  for (int j = 0; j<layers; j++) {
    for (int i=0; i<particles-1; i++) {
      sticks[i][j].constrainLen();
    }
    for (int i=0; i<particles/2; i++) {    
      sticks[i][j].render(0.4+map(i, 0, particles/2-1, 0, 2));
    }
    for (int i=particles/2; i<particles-1; i++) {
      sticks[i][j].render(0.4+map(i, particles/2, particles-2, 2, 0));
    }
  }

  for (int j = 0; j<layers; j++) {
    strokeWeight(4);
    stroke(255, trans);
    balls[particles/2][j].render();
    stroke(#68EBE3, trans);
    strokeWeight(3.5);
    balls[particles/2-1][j].render();
    stroke(#C3B4D3, trans);
    balls[particles/2+1][j].render();

    for (int i=0; i<particles; i++) {
      if (i!=0&&i!=particles-1)
        balls[i][j].verlet();
      noFill();

      // draw balls
      if (i!=particles/2) { //&&i!=(particles/2+1)&&i!=(particles/2-1)
        //transP=lerp(transP, trans, 0.1);
        //stroke(#1F6B6F, transP);
        //pushMatrix();
        //translate(0, -100, 0 );
        //balls[i][j].render();
        //popMatrix();
      }
    }
  }

  for (int l = 0; l<layers; l++) {
    for (int i = 0; i < layers; i++)
    {

      posY =whisper.mix.get(i);
      posY +=step.mix.get(i);
      posY +=tic.mix.get(i);
      posY += chord1_0.mix.get(i);
      posY += chord1_1.mix.get(i);
      posY +=chord1_2.mix.get(i);
      posY +=chord1_3.mix.get(i);
      posY +=chord2_0.mix.get(i);
      posY +=chord2_1.mix.get(i);
      posY +=chord2_2.mix.get(i);
      posY +=chord2_3.mix.get(i);
      posY +=chord3_0.mix.get(i);
      posY +=chord3_1.mix.get(i);
      posY +=chord3_2.mix.get(i);
      posY +=chord3_3.mix.get(i);
      posY +=chord4_0.mix.get(i);
      posY +=chord4_1.mix.get(i);
      posY +=chord4_2.mix.get(i);
      posY +=chord4_3.mix.get(i);
      posY +=sea.mix.get(i);
      posY +=seaWave.mix.get(i);
      posY +=gull_1.mix.get(i);
      posY +=gull_2.mix.get(i);
      posY +=bell.mix.get(i);
      posY +=road.mix.get(i);
      posY +=park_1.mix.get(i);
      posY +=park_2.mix.get(i);
      posY +=choir.mix.get(i);
      posY +=walk.mix.get(i);
      //if(handsUp[0])
      posY += lerp(0, -rightHandy[0]/700, -2);
      trans = abs((int)map(posY*10000, -80, 80, 0, 255));
      balls[particles/2][l].update(balls[particles/2][l].pos.x, posY*100+50);
    }
  }

  ///////////// interaction /////////////////
  if (key == 's')  
    saveFrame("frame/######.png");
  if (rotateX) cam.rotateY((PI/180)*.05);
  translate(0, -com[0].z/100, 0);

  theNoise = new Noise( 0.01f, Noise.Tint.RED );
  scene();

  if (playChord) pianoChord();
  if (playMemo) memo();
  //   if (playNoise) theNoise.patch(synth);
  //  else theNoise.unpatch(synth);
}


// -------------------------------------------------------------------------------

void keyPressed() {
  if (key == 'p')
    //println("userList: "+userList);
    //println("CamX "+cam.getPosition()[0]+" CamY "+cam.getPosition()[1]+" CamZ "+cam.getPosition()[2]);
    if (key == 's')  
      saveFrame=!saveFrame;
  if (key == ' ' )  
    rotateX=!rotateX;
}

