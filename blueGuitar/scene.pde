void stopAll() {
  whisper.pause();
  step.pause();
  tic.pause();
  chord1_0.pause();
  chord1_1.pause();
  chord1_2.pause();
  chord1_3.pause();
  chord2_0.pause();
  chord2_1.pause();
  chord2_2.pause();
  chord2_3.pause();
  chord3_0.pause();
  chord3_1.pause();
  chord3_2.pause();
  chord3_3.pause();
  chord4_0.pause();
  chord4_1.pause();
  chord4_2.pause();
  chord4_3.pause();

  sea.pause();
  seaWave.pause();
  gull_1.pause();
  gull_2.pause();
  wind.pause();
  wave.pause();
  bell.pause();
  road.pause();
  park_1.pause();
  park_2.pause();
  choir.pause();
  walk.pause();
  whisper.rewind();
  step.rewind();
  tic.rewind();
  chord1_0.rewind();
  chord1_1.rewind();
  chord1_2.rewind();
  chord1_3.rewind();
  chord2_0.rewind();
  chord2_1.rewind();
  chord2_2.rewind();
  chord2_3.rewind();
  chord3_0.rewind();
  chord3_1.rewind();
  chord3_2.rewind();
  chord3_3.rewind();
  chord4_0.rewind();
  chord4_1.rewind();
  chord4_2.rewind();
  chord4_3.rewind();

  sea.rewind();
  seaWave.rewind();
  wave.rewind();
  gull_1.rewind();
  gull_2.rewind();
  wind.rewind();
  bell.rewind();
  road.rewind();
  park_1.rewind();
  park_2.rewind();
  choir.rewind();
  walk.rewind();
}


void scene() {

  // &&&&&&&&&&&&&&&&&&   start over   &&&&&&&&&&&&&&&&&&&&
  if (timerSet % phase == 1) { 
    stopAll();
    playMemo = false;
  }

  // &&&&&&&&&&&&&&&&&&   whisper   &&&&&&&&&&&&&&&&&&&&
  if (timerSet % phase == timestamp_1) { 
    whisper.play(); // 11s 
    whisper.setPan(0);
  }

  // &&&&&&&&&&&&&&&&&&   step   &&&&&&&&&&&&&&&&&&&&
  if (timerSet % phase == timestamp_2) {
    tic.play();
    tic.loop();
  }
  if (timerSet % phase == timestamp_3) {
    playNoise = true; // noisy gradually>>>
  }
  if (timerSet % phase <= timestamp_4 && timerSet % phase > timestamp_2) { 
    // multi users, control times and panning >>>> some problems !!!!
    //    for (int numbOfUsers = 0; numbOfUsers<user_list.length; numbOfUsers++) {
    //      step.play(); // 17s
    //      step.setPan(map(mouseX, 0, 1080, -1, 1));
    //      //      com[i]
    //    } 

    play2(step, millis());
    float dis = dist(com[0].x, com[0].y, com[0].z, 0, 0, 0);
    step.setGain(5-(dis/1000)*(dis/1000));
    step.setPan(map(com[0].x, 0, 2000, -1, 1));

    playStep = true;
    whisper.shiftGain(0, -20, 2*1000);
  }

  // &&&&&&&&&&&&&&&&&&   piano   &&&&&&&&&&&&&&&&&&&&
  if (timerSet % phase == timestamp_4) {
    tic.pause();
  }
  if (timerSet % phase == timestamp_5) {
    playNoise = false;
  }
  if (timerSet % phase <= timestamp_7 && timerSet % phase > timestamp_4) {
    step.pause();
    step.shiftGain(0, -50, 2*1000);
    playChord = true;
  
  }
  if (timerSet % phase == timestamp_6) {
    playNoise = true;
    
  }

  // &&&&&&&&&&&&&&&&&&   sea   &&&&&&&&&&&&&&&&&&&&
  if (timerSet % phase == timestamp_8) {
    playNoise = false;
    
  }
  if (timerSet % phase <=timestamp_9  && timerSet % phase >timestamp_7 ) { 
    playChord = false;
    playSynth=true;
    //theNoise.unpatch(out);
    chord1_0.pause();
    chord1_1.pause();
    chord1_2.pause();
    chord1_3.pause();
    chord2_0.pause();
    chord2_1.pause();
    chord2_2.pause();
    chord2_3.pause();
    chord3_0.pause();
    chord3_1.pause();
    chord3_2.pause();
    chord3_3.pause(); 
    chord4_0.pause();
    chord4_1.pause();
    chord4_2.pause();
    chord4_3.pause();
 
    playSea = true;

    //sea.setGain(5);
    play2(sea, millis());

    /*
    // try create synth in supercollider
     if (playSynth) {
     synth0.addToTail(group);
     synth1.addToTail(group);
     synth2.addToTail(group);
     synth3.addToTail(group);
     playSynth=false;
     }
     
     synth0.set("freq", 40 + (peak[0] * 2)); 
     synth0.set("amp", min(0, -0.5*peak[0]+150));
     synth1.set("freq", 40 + (peak[0] * 2)); 
     synth1.set("amp", min(0, -0.5*peak[0]+150));
     synth2.set("freq", 40 + (peak[0] * 4)); 
     synth2.set("amp", min(0, -0.5*peak[0]+150));
     synth3.set("freq", 40 + (peak[0] * 3)); 
     synth3.set("amp", min(0, -0.5*peak[0]+150));
     println("freq " + 40 + (mouseX * 4)+" "+"amp", (float)(0.05+mouseX/700) );
     */


    wind.setGain(min(0, -0.5*peak[0]+150));
    gull_1.setGain(min(0, 0.5*peak[0]-250));
    wave.setGain(min(0, -0.5*peak[0]+150));
    play2(wind, millis());
    play2(wave, millis());
    play2(gull_1, millis());
    if (dist(com[0].x, com[0].z, com[1].x, com[1].z) < 1000)
      play2(seaWave, millis()); // >>> To do list: shorter the wave file
  }

  // &&&&&&&&&&&&&&&&&&   memo   &&&&&&&&&&&&&&&&&&&&
  if (timerSet % phase == timestamp_10) {
    tic.rewind();
    tic.play();
    tic.loop();
  }
  if (timerSet % phase <=timestamp_11  && timerSet % phase >timestamp_9 ) { 
    playSea = false;
    sea.pause();
    seaWave.pause();
    gull_1.pause();
    gull_2.pause();
    wind.pause();
    playMemo = true;
  }

  // &&&&&&&&&&&&&&&&&&   ending   &&&&&&&&&&&&&&&&&&&&
  if (timerSet % phase <=timestamp_12  && timerSet % phase >timestamp_11 ) { 
    playMemo = false;
  }
}


// &&&&&&&&&&&&&&&&&&   piano chord set  &&&&&&&&&&&&&&&&&&&&

void pianoChord() {

  if (user_list.length==1) { // single user
    float dis = dist(com[0].x, com[0].y, com[0].z, 0, 0, 0);
    float gain=-(dis/1000)*(dis/1000);
    float duration = 250;
    float maxDis=3000;

    if ((timerSet-timestamp_4)<15/2) {
      if (com[0].z<2*maxDis/4) {
        play2(chord1_1, millis()); 
        chord1_1.setGain(gain);
        play2(chord1_2, millis()+duration); 
        chord1_1.setGain(gain);
        play2(chord1_3, millis()+duration*2); 
        chord1_1.setGain(gain);
      } else if (com[0].z<3*maxDis/4) {
        play2(chord1_1, millis()); 
        chord1_1.setGain(gain);
        play2(chord1_2, millis()+duration); 
        chord1_1.setGain(gain);
      } else {
        play2(chord1_1, millis()); 
        chord1_1.setGain(gain);
      } 
      if (handsUp[0]) {
        //println("hand0");
        play2(chord1_0, millis());
        chord1_0.setGain(gain);
      }
    } else if ((timerSet-timestamp_4)<30/2) {
      if (com[0].z<2*maxDis/4) {
        play2(chord2_1, millis()); 
        chord2_1.setGain(gain);
        play2(chord2_2, millis()+duration); 
        chord2_1.setGain(gain);
        play2(chord2_3, millis()+duration*2); 
        chord2_1.setGain(gain);
      } else if (com[0].z<3*maxDis/4) {
        play2(chord2_1, millis()); 
        chord2_1.setGain(gain);
        play2(chord2_2, millis()+duration); 
        chord1_1.setGain(gain);
      } else {
        play2(chord2_1, millis()); 
        chord2_1.setGain(gain);
      } 
      if (handsUp[0]) {
        //println("hand0");
        play2(chord2_0, millis());
        chord2_0.setGain(gain);
      }
      //
      if (com[0].z<2*maxDis/4) {
        play2(chord1_1, millis()); 
        chord1_1.setGain(gain);
        play2(chord1_2, millis()+duration); 
        chord1_1.setGain(gain);
        play2(chord1_3, millis()+duration*2); 
        chord1_1.setGain(gain);
      } else if (com[0].z<3*maxDis/4) {
        play2(chord1_1, millis()); 
        chord1_1.setGain(gain);
        play2(chord1_2, millis()+duration); 
        chord1_1.setGain(gain);
      } else {
        play2(chord1_1, millis()); 
        chord1_1.setGain(gain);
      } 
      if (handsUp[0]) {
        //println("hand0");
        play2(chord1_0, millis());
        chord1_0.setGain(gain);
      }
    } else if ((timerSet-timestamp_4)<45/2) {
      if (com[0].z<2*maxDis/4) {
        play2(chord3_1, millis()); 
        chord3_1.setGain(gain);
        play2(chord3_2, millis()+duration); 
        chord3_1.setGain(gain);
        play2(chord3_3, millis()+duration*2); 
        chord3_1.setGain(gain);
      } else if (com[0].z<3*maxDis/4) {
        play2(chord3_1, millis()); 
        chord3_1.setGain(gain);
        play2(chord3_2, millis()+duration); 
        chord3_1.setGain(gain);
      } else {
        play2(chord3_1, millis()); 
        chord3_1.setGain(gain);
      } 
      if (handsUp[0]) {
        //println("hand0");
        play2(chord3_0, millis());
        chord3_0.setGain(gain);
      }
      //
      if (com[0].z<2*maxDis/4) {
        play2(chord2_1, millis()); 
        chord2_1.setGain(gain);
        play2(chord2_2, millis()+duration); 
        chord2_1.setGain(gain);
        play2(chord2_3, millis()+duration*2); 
        chord2_1.setGain(gain);
      } else if (com[0].z<3*maxDis/4) {
        play2(chord2_1, millis()); 
        chord2_1.setGain(gain);
        play2(chord2_2, millis()+duration); 
        chord1_1.setGain(gain);
      } else {
        play2(chord2_1, millis()); 
        chord2_1.setGain(gain);
      } 
      if (handsUp[0]) {
        //println("hand0");
        play2(chord2_0, millis());
        chord2_0.setGain(gain);
      }
      //
      if (com[0].z<2*maxDis/4) {
        play2(chord1_1, millis()); 
        chord1_1.setGain(gain);
        play2(chord1_2, millis()+duration); 
        chord1_1.setGain(gain);
        play2(chord1_3, millis()+duration*2); 
        chord1_1.setGain(gain);
      } else if (com[0].z<3*maxDis/4) {
        play2(chord1_1, millis()); 
        chord1_1.setGain(gain);
        play2(chord1_2, millis()+duration); 
        chord1_1.setGain(gain);
      } else {
        play2(chord1_1, millis()); 
        chord1_1.setGain(gain);
      } 
      if (handsUp[0]) {
        //println("hand0");
        play2(chord1_0, millis());
        chord1_0.setGain(gain);
      }
    } else {
      if (com[0].z<2*maxDis/4) {
        play2(chord4_1, millis()); 
        chord4_1.setGain(gain);
        play2(chord4_2, millis()+duration); 
        chord4_1.setGain(gain);
        play2(chord4_3, millis()+duration*2); 
        chord4_1.setGain(gain);
      } else if (com[0].z<3*maxDis/4) {
        play2(chord4_1, millis()); 
        chord4_1.setGain(gain);
        play2(chord4_2, millis()+duration); 
        chord4_1.setGain(gain);
      } else {
        play2(chord4_1, millis()); 
        chord4_1.setGain(gain);
      } 
      if (handsUp[0]) {
        //println("hand0");
        play2(chord4_0, millis());
      }
      //
      if (com[0].z<2*maxDis/4) {
        play2(chord3_1, millis()); 
        chord3_1.setGain(gain);
        play2(chord3_2, millis()+duration); 
        chord3_1.setGain(gain);
        play2(chord3_3, millis()+duration*2); 
        chord3_1.setGain(gain);
      } else if (com[0].z<3*maxDis/4) {
        play2(chord3_1, millis()); 
        chord3_1.setGain(gain);
        play2(chord3_2, millis()+duration); 
        chord3_1.setGain(gain);
      } else {
        play2(chord3_1, millis()); 
        chord3_1.setGain(gain);
      } 
      if (handsUp[0]) {
        //println("hand0");
        play2(chord3_0, millis());
        chord3_0.setGain(gain);
      }
      //
      if (com[0].z<2*maxDis/4) {
        play2(chord2_1, millis()); 
        chord2_1.setGain(gain);
        play2(chord2_2, millis()+duration); 
        chord2_1.setGain(gain);
        play2(chord2_3, millis()+duration*2); 
        chord2_1.setGain(gain);
      } else if (com[0].z<3*maxDis/4) {
        play2(chord2_1, millis()); 
        chord2_1.setGain(gain);
        play2(chord2_2, millis()+duration); 
        chord1_1.setGain(gain);
      } else {
        play2(chord2_1, millis()); 
        chord2_1.setGain(gain);
      } 
      if (handsUp[0]) {
        //println("hand0");
        play2(chord2_0, millis());
        chord2_0.setGain(gain);
      }
      //
      if (com[0].z<2*maxDis/4) {
        play2(chord1_1, millis()); 
        chord1_1.setGain(gain);
        play2(chord1_2, millis()+duration); 
        chord1_1.setGain(gain);
        play2(chord1_3, millis()+duration*2); 
        chord1_1.setGain(gain);
      } else if (com[0].z<3*maxDis/4) {
        play2(chord1_1, millis()); 
        chord1_1.setGain(gain);
        play2(chord1_2, millis()+duration); 
        chord1_1.setGain(gain);
      } else {
        play2(chord1_1, millis()); 
        chord1_1.setGain(gain);
      } 
      if (handsUp[0]) {
        //println("hand0");
        play2(chord1_0, millis());
        chord1_0.setGain(gain);
      }
    }
  }

  /*
  if (user_list.length==2) { // two users
   
   play2(chord2_1, millis()+500);
   
   if (handsUp[0]) {
   println("hand0");
   play2(chord1_1, millis());
   play2(chord1_2, millis());
   play2(chord1_2, millis());
   }
   if (handsUp[1]) {
   println("hand1");
   play2(chord2_1, millis());
   play2(chord2_2, millis());
   play2(chord2_2, millis());
   }
   }
   */
}

float getGainFromDistance(float distance) {
  return min(0, (100-distance/1000*200));
}

boolean bellTriger = false;

void memo() {

  if (user_list.length==1) {
    float radius = 500;
    float dis_walk = dist(com[0].x, com[0].z, 0, 1500);
    float dis_park_1 = dist(com[0].x, com[0].z, 500, 1000);
    float dis_park_2 = dist(com[0].x, com[0].z, 500, 2000);
    float dis_choir = dist(com[0].x, com[0].z, -500, 1000);
    float dis_road = dist(com[0].x, com[0].z, -500, 2000);

    if (dis_walk<500&&(dis_park_1<500||dis_park_2<500||dis_choir<500||dis_road<500)&&bellTriger==false) {
      play2(bell, millis());
      bellTriger=true;
    } else if (!(dis_walk<500&&(dis_park_1<500||dis_park_2<500||dis_choir<500||dis_road<500))) {
      bellTriger=false;
    }

    walk.setGain(getGainFromDistance(dis_walk));
    road.setGain(getGainFromDistance(dis_road));
    park_1.setGain(getGainFromDistance(dis_park_1));
    park_2.setGain(getGainFromDistance(dis_park_2));
    choir.setGain(getGainFromDistance(dis_choir));

    play2(road, millis());
    play2(park_1, millis());
    play2(park_2, millis());
    play2(choir, millis());
    play2(walk, millis());
  }
}

