//  How many text is being drawed? Answer: j+1 (start from 0)

void drawTextAndBox(int j) { 

  // [WHY I CANNOT DO THE ROTATE..... ]
  // rotateZ(1*sin(((frameCount % totalPhase)/20.0)*PI));

  // draw all the previous texts and boxs
  for (int i=0; i<j; i++) {
    //rotateZ(1*sin(((frameCount % totalPhase+i)/20.0)*PI));
    fill(0, 127);
    rect(stayX[i]-stayRectW[i]/2, stayY[i]-stayRectH[i]/2, stayRectW[i], stayRectH[i]);
    fill(255);
    textFont(font, stayScale[i]);
    text(words[i], stayX[i], stayY[i]);
  }

  // draw the current moving text and it's box
  fill(0);
  rect(wordX-rectW/2, wordY-rectH/2, rectW, rectH);
  fill(255);
  textFont(font, wordScale);
  text(words[j], wordX, wordY);

  // store the current data into array
  stayX[j]=wordX;
  stayY[j]=wordY;
  stayScale[j]=wordScale;
  stayRectW[j]=rectW;
  stayRectH[j]=rectH;
}

void drawTitle() {
  fill(0);
  textFont(font2, 15);
  //text("Among of green stiff old bright broken branch come white sweet May again", width/2, height/2-20);
  //text("William Carlos Williams", width/2, height/2);
}

