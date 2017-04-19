void keyPressed() {
  if (key == ' ' || key == ' ') { 
    isRecording = !isRecording;
  }
  if (key == '1') {
    rotateY = !rotateY;
  }
  if (key == '2') {
    rotateX = !rotateX;
  }
  if (key == 'c' || key== 'C') {
    colorMode = !colorMode;
  }
  if (key == 's' || key == 'S') {  
    saveFrame=!saveFrame;
  }
}

//println("Camera: " + cam.getDistance());

