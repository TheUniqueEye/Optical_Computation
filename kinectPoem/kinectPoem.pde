/* 2016-4-2 (Processing 3)
 
 M265 Optical-Computational Processes: Simple Project 
 
 ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
 :::::::: W H I T E / S W E E T / M A Y / A G A I N::::::::::::::::
 ::::::::::::::::::::::::::::::::::::::::::: code: Jing Yan :::::::
 ::::::::::::::::::: theuniqueeye@gmail.com :::::::::::::::::::::::
 ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
 ::::::: [VERSION 3] ::::::::::::::::::::::::::::::::::::::::::::*/
 
 
// version 3: 
// 1. Add black background to words.Red to MAY
// 2. Use for loop and function to rebuild the redundant structure.
// 3. Further: Try to do some rotate. 

// reference: Greg.Borenstein <Making Things See> (2012.01)

import SimpleOpenNI.*;
SimpleOpenNI kinect;

import processing.sound.*;
SoundFile walk, bell1, bell2, bell3, bell4, bell5;


String[] words= {
  "A M O N G", "O F", "G R E E N", "S T I F F", "O L D", "B R I G H T", "B R O K E N", "B R A N C H", "C O M E", "W H I T E", "S W E E T", "M A Y", "A G A I N"
};
PFont font,font2;
float wordX, wordY, rectW, rectH;
int transparency=127;
float wordScale;
float[] stayX = new float[13];
float[] stayY = new float[13];
float[] stayScale = new float[13];
float[] stayRectW = new float[13];
float[] stayRectH = new float[13];

int minDistance=200;
int maxDistance=3000;
int closestValue, closestX, closestY;
float lastX;
float lastY;

int totalPhase = 40*18;
int timestamp = 40;
float loudness = 0.1;
boolean titleOn=true;
//int counter=0;


void setup() {
  size(640, 480);
  frameRate(20);
  background(255); 

  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  kinect.enableRGB();

  font = loadFont("KohinoorDevanagari-Book-48.vlw");
  font2 = loadFont("OratorStd-48.vlw");
  textAlign(CENTER, CENTER);
  println("number of words: " + words.length);

  // Load a soundfile from the /data folder of the sketch and play it back
  walk = new SoundFile(this, "walk_mono.mp3");
  walk.play();
  walk.loop();
  bell1 = new SoundFile(this, "bell1.wav");
  bell2 = new SoundFile(this, "bell2.wav");
  bell3 = new SoundFile(this, "bell3.wav");
  bell4 = new SoundFile(this, "bell4.wav");
  bell5 = new SoundFile(this, "bell5.wav");
  bell1.amp(0.5);
  bell2.amp(0.5);
  bell3.amp(0.5);
  bell4.amp(0.5);
  bell5.amp(0.5);
}


void draw() {
  closestValue = 8000;

  kinect.update();
  int[] depthValues = kinect.depthMap();

  // find out the closest point on screen
  for (int y=0; y<480; y++) {
    for (int x=0; x<640; x++) {
      int reversedX = 640-x-1;
      int i = reversedX+y*640;
      int currentDepthValue = depthValues[i];

      if (currentDepthValue>minDistance && currentDepthValue < maxDistance && currentDepthValue<closestValue) {
        closestValue = currentDepthValue;
        closestX=x;
        closestY=y;
      }
    }
  }
  // make the movement less active and more stable
  float interpolatedX = lerp(lastX, closestX, 0.05f);   
  float interpolatedY = lerp(lastY, closestY, 0.05f);

  // position of words
  wordX = interpolatedX; 
  wordY = interpolatedY;

  // scale of words, boxs; loudness of sounds
  if (closestValue<maxDistance&&closestValue>minDistance) { // avoid bug at edges
    wordScale = map(closestValue, minDistance, maxDistance, 50, 6);
    loudness = map(closestValue, minDistance, maxDistance, 0.1, 0.9);
    rectW = wordScale * 5 +10;
    rectH = wordScale * 1;
  }

  background(255); // refresh canvas
  textFont(font, wordScale);
  noStroke();
  //image(kinect.depthImage(), 0, 0); // see the real scene for examine
  //ellipse(wordX, wordY, 25, 25); // see the actual pick up spot for examine

    // stereolize the sound according to the movement
  walk.amp(loudness);
  walk.pan(map(interpolatedX, 0, interpolatedY, -1.0, 1.0)); 

 

  // Using frameCount to do animation
  if (frameCount % totalPhase <timestamp) {
    transparency = 127; 
    fill(0);
    rect(wordX-rectW/2, wordY-rectH/2, rectW, rectH);

    fill(255);
    text(words[0], wordX, wordY);

    stayX[0]=wordX;
    stayY[0]=wordY;
    stayScale[0]=wordScale;
    stayRectW[0]=rectW;
    stayRectH[0]=rectH;
    if (frameCount%totalPhase == 1) bell1.play();
  }

  if (frameCount % totalPhase >=timestamp && frameCount % totalPhase <timestamp*2) {
    drawTextAndBox(1);
    if (frameCount%totalPhase == 41) bell2.play();
  }

  if (frameCount % totalPhase >=timestamp*2 && frameCount % totalPhase <timestamp*3) {
    drawTextAndBox(2);
    if (frameCount%totalPhase == 81) bell3.play();
  }

  if (frameCount % totalPhase >=timestamp*3 && frameCount % totalPhase <timestamp*4) {
    drawTextAndBox(3);
    if (frameCount%totalPhase == 121) bell4.play();
  }

  if (frameCount % totalPhase >=timestamp*4 && frameCount % totalPhase <timestamp*5) {
    drawTextAndBox(4);
    if (frameCount%totalPhase == 161) bell5.play();
  }

  if (frameCount % totalPhase >=timestamp*5 && frameCount % totalPhase <timestamp*6) {
    drawTextAndBox(5);
    if (frameCount%totalPhase == 201) bell1.play();
  }

  if (frameCount % totalPhase >=timestamp*6 && frameCount % totalPhase <timestamp*7) {
    drawTextAndBox(6);
    if (frameCount%totalPhase == 241) bell2.play();
  }

  if (frameCount % totalPhase >=timestamp*7 && frameCount % totalPhase <timestamp*8) {
    drawTextAndBox(7);
    if (frameCount%totalPhase == 281) bell3.play();
  }

  if (frameCount % totalPhase >=timestamp*8 && frameCount % totalPhase <timestamp*9) {
    drawTextAndBox(8);
    if (frameCount%totalPhase == 321) bell4.play();
  }
  if (frameCount % totalPhase >=timestamp*9 && frameCount % totalPhase <timestamp*10) {
    drawTextAndBox(9);
    if (frameCount%totalPhase == 361) bell5.play();
  }

  if (frameCount % totalPhase >=timestamp*10 && frameCount % totalPhase <timestamp*11) {
    drawTextAndBox(10);
    if (frameCount%totalPhase == 401) bell1.play();
  }

  if (frameCount % totalPhase >=timestamp*11 && frameCount % totalPhase <timestamp*12) {

    // want to make the MAY red and exceptional

    // draw all the previous texts and boxs
    for (int i=0; i<11; i++) {
      fill(0, 127);
      rect(stayX[i]-stayRectW[i]/2, stayY[i]-stayRectH[i]/2, stayRectW[i], stayRectH[i]);
      fill(255);
      textFont(font, stayScale[i]);
      text(words[i], stayX[i], stayY[i]);
    }

    // draw the current moving text and it's box
    fill(220, 20, 60); // red [220,20,60]
    rect(wordX-rectW/2, wordY-rectH/2, rectW, rectH);
    fill(255);
    textFont(font, wordScale);
    text(words[11], wordX, wordY);

    // store the current data into array
    stayX[11]=wordX;
    stayY[11]=wordY;
    stayScale[11]=wordScale;
    stayRectW[11]=rectW;
    stayRectH[11]=rectH;
    if (frameCount%totalPhase == 441) bell2.play();
  }

  if (frameCount % totalPhase >=timestamp*12 && frameCount % totalPhase <timestamp*13) {
    // want to make the MAY red and exceptional

    // draw all the previous texts and boxs
    for (int i=0; i<11; i++) {
      fill(0, 127);
      rect(stayX[i]-stayRectW[i]/2, stayY[i]-stayRectH[i]/2, stayRectW[i], stayRectH[i]);
      fill(255);
      textFont(font, stayScale[i]);
      text(words[i], stayX[i], stayY[i]);
    }

    // red MAY
    fill(220, 20, 60, 127); // red [220,20,60]
    rect(stayX[11]-stayRectW[11]/2, stayY[11]-stayRectH[11]/2, stayRectW[11], stayRectH[11]);
    fill(255);
    textFont(font, stayScale[11]);
    text(words[11], stayX[11], stayY[11]);

    // draw the current moving text and it's box
    fill(0);
    rect(wordX-rectW/2, wordY-rectH/2, rectW, rectH);
    fill(255);
    textFont(font, wordScale);
    text(words[12], wordX, wordY);

    // store the current data into array
    stayX[12]=wordX;
    stayY[12]=wordY;
    stayScale[12]=wordScale;
    stayRectW[12]=rectW;
    stayRectH[12]=rectH;
    if (frameCount%totalPhase == 481) bell3.play();
  }

  if (frameCount % totalPhase >=timestamp*13 && frameCount % totalPhase <timestamp*17) {
    //println("i = "+frameCount % totalPhase+"   transparency  = "+transparency);
    if (transparency>3)
      transparency = transparency-3;

    for (int i=0; i<11; i++) {
      fill(0, transparency);
      rect(stayX[i]-stayRectW[i]/2, stayY[i]-stayRectH[i]/2, stayRectW[i], stayRectH[i]);
      fill(255, transparency);
      textFont(font, stayScale[i]);
      text(words[i], stayX[i], stayY[i]);
    }

    // red MAY
    fill(220, 20, 60, transparency); // red [220,20,60]
    rect(stayX[11]-stayRectW[11]/2, stayY[11]-stayRectH[11]/2, stayRectW[11], stayRectH[11]);
    fill(255, transparency);
    textFont(font, stayScale[11]);
    text(words[11], stayX[11], stayY[11]);

    // last word
    fill(0, transparency);
    rect(stayX[12]-stayRectW[12]/2, stayY[12]-stayRectH[12]/2, stayRectW[12], stayRectH[12]);
    fill(255, transparency);
    textFont(font, stayScale[12]);
    text(words[12], stayX[12], stayY[12]);
  }
  
  if (frameCount % totalPhase >=timestamp*17 && frameCount % totalPhase <timestamp*18) {
    drawTitle();
  }

  lastX = interpolatedX;
  lastY = interpolatedY;
  
  // saveFrame to make an animation
  //saveFrame("poem-######.png");
}


