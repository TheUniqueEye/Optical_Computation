/* 2016-4-12 (Processing 3)
 
 M265 Optical-Computational Processes: Depth Project 
 
 ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
 :::::::: the SPACE between CONSTRUCTION and DESTRUCTION:::::::::::
 ::::::::::::::::::::::::::::::::::::::::::: code: Jing Yan :::::::
 ::::::::::::::::::: theuniqueeye@gmail.com :::::::::::::::::::::::
 ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
 ::::::: [VERSION 4] ::::::::::::::::::::::::::::::::::::::::::::*/

// version4: 
// 1. try different elements: box, cross
// 2. add more depth to the sculpture according to the complexity of the front

// reference: 
// inspired by - Antony Gormely's sculpture
// based on "point clouds example" - Greg.Borenstein <Making Things See> (2012.01) 


import peasy.*;
PeasyCam cam;
import SimpleOpenNI.*;
SimpleOpenNI kinect;
import processing.opengl.*;

// Cube - Sculpture - Frame of sculptures
ArrayList<ArrayList<Cube>> sculptures = new ArrayList<ArrayList<Cube>>(); 
Cube cube;
int step=15;
int maxRange=2000, minRange=400;
int numFrame=5, counter=0;
boolean isRecording=true;
//boolean isRecFrame;

boolean rotateY=false, rotateX=false;
boolean colorMode=false, saveFrame=false;
PShader lineShader;
PShape cross;

void setup() {
  size(1080, 800, OPENGL);
  cam = new PeasyCam(this, 500);

  kinect = new SimpleOpenNI(this);
  if (kinect.isInit() == false) {
    println("Can't init SimpleOpenNI."); 
    exit();
    return;
  }   
  kinect.setMirror(true);
  kinect.enableDepth();
  kinect.enableRGB();
  kinect.alternativeViewPointDepthToImage();

  // shader
  //lineShader = loadShader("linefrag.glsl", "linevert.glsl");
  //hint(DISABLE_DEPTH_MASK);

  // element: cross
  int a=30;
  cross = createShape();
  cross.beginShape(LINES);
  cross.vertex(-a/2, 0, 0);
  cross.vertex(a/2, 0, 0);
  cross.vertex(0, -a/2, 0);
  cross.vertex(0, a/2, 0);
  cross.vertex(0, 0, -a/2);
  cross.vertex(0, 0, a/2);
  cross.endShape();
}


void draw() {
  kinect.update();
  //shader(lineShader, LINES); // shader
  background(255); 
  frameRate(5);

  /*
  pushMatrix();
   PImage rgbImage= kinect.rgbImage();
   translate(-1080/2+220, -800/2+145);
   image(rgbImage, 0, 0);
   popMatrix();
   */

  stroke(0);
  noFill();
  strokeWeight(1);
  rotateX(radians(180)); 
  translate(0, 0, -700);

  PVector[] depthPoints = kinect.depthMapRealWorld(); 
  int[] depthMap=kinect.depthMap();

  int index;
  float len, transparency, weight;
  float posX, posY, posZ;

  // ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::[ record ]::::::::

  if (isRecording) {
    //isRecFrame = (frameCount % 100 == 0); // record every 10 frames

    ArrayList<Cube> sculpture = new ArrayList<Cube>();

    for (int y=0; y<kinect.depthHeight (); y++) {  // loop every pixel from the screen
      for (int x=0; x<kinect.depthWidth (); x++) {
        index=x+y*kinect.depthWidth();
        PVector currentPoint = depthPoints[index];

        if (currentPoint.z > minRange && currentPoint.z < maxRange) { // only save the data of points within a certain distance
          posX = currentPoint.x;
          posY = currentPoint.y;
          posZ = currentPoint.z;
          step = int(map(currentPoint.z, minRange, maxRange, 5, 15)); // density between the other
          len = map(currentPoint.z, minRange, maxRange, 25, 3); // size 
          transparency = map(currentPoint.z, minRange, maxRange, 80, 230); // transparency of stroke
          weight = map(currentPoint.z, minRange, maxRange, 2, 0.3); // strokeWeight

          cube = new Cube(step, len, transparency, weight, posX, posY, posZ); // [ create a new cube ]
        } else {
          cube = new Cube(0, 0, 0, 0, 0, 0, 0);
        }
        sculpture.add(cube); // [ add cubes from every pixel of the screen into a sculpture ]
      }
    }

    if (sculptures.size()<numFrame) // [ add sculptures from a certain duration of frames into sculptures ]
      sculptures.add(sculpture);
    else {
      sculptures.set(counter%numFrame, sculpture); // update the old frame with new data, keep the number of frame at a certain range
      //println("counter%numFrame : " + counter%numFrame);
    }
    counter++; // count frame
  }


  // ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::[ display ]::::::::

  for (int i=0; i<sculptures.size (); i++) { // display sculpture from each frame with the time range
    ArrayList<Cube> currentSculpture = sculptures.get(i);
    Cube currentCube = currentSculpture.get(0);
    int countBox=0;

    for (int y=0; y<kinect.depthHeight (); y+=10) {
      for (int x=0; x<kinect.depthWidth (); x+=10) {
        index=x+y*kinect.depthWidth();
        currentCube = currentSculpture.get(index);
        pushMatrix();
        translate(currentCube.posX, currentCube.posY, currentCube.posZ);
        stroke(0, currentCube.transparency);
        strokeWeight(currentCube.weight);
        //randomness(x,y,len); // add randomness

        if (currentCube.len!=0) { // only draw the element within certain distance range

          //box(currentCube.len, currentCube.len, currentCube.len); // [BOX-level1]
          if (x%2 ==0 && y%2 ==0) shape(cross, 0, 0); // [CROSS-level1]

          // add depth to the sculpture according to the complexity of the front 

          int lenBox1=30, lenBox2=60, gap=10; // for CROSS
          float strokeBox=0.7; // for CROSS
          //int lenBox1=60, lenBox2=120, gap=20;  // for BOX
          //float strokeBox=0.5; // for BOX

          if (currentCube.posZ <(minRange+maxRange)/3) { // [BOX-level2]
            countBox++;
            if (countBox>300 && x%20 ==0 && y%20 ==0) {
              translate(0, 0, lenBox1+gap);
              strokeWeight(strokeBox);
              box(lenBox1);
            }
            if (countBox>600 && x%30 ==0 && y%30 ==0) { // [BOX-level3]
              translate(0, 0, lenBox1+lenBox2+gap);
              strokeWeight(strokeBox);
              box(lenBox2);
            }
          }
        }
        popMatrix();
      }
    }
  }
  if (rotateY) cam.rotateY(radians(1)*0.8);
  if (rotateX) cam.rotateX(radians(1)*0.8);
  if (saveFrame) saveFrame("frame/frame-######.png");
}

