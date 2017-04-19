void play2(AudioPlayer tempPlayer, float time2BPlayed) {
   if(!next_play_times.containsKey(tempPlayer)) {
     next_play_times.put(tempPlayer, 1e20);
   }
  
  boolean playingState = tempPlayer.isPlaying();

  if (playingState) {
    println("ture");
    next_play_times.put(tempPlayer, 1e20);
  } else {
    
    if (millis()>=next_play_times.get(tempPlayer)) {
      println("false"); 
      tempPlayer.rewind();
      tempPlayer.play();
    } else {
      if(next_play_times.get(tempPlayer) == 1e20) {
        next_play_times.put(tempPlayer, time2BPlayed);
      }
    }
  }
}

// -------------------------------------------------------------------------------
///////////////    Here is my garage     /////////////////
////////////   for things might be useful   /////////////
// -------------------------------------------------------------------------------
/*
 // set a volume variable
 float vol = 0.45;
 
 // set the tempo for here
 out.setTempo( 100.0f );
 // set a percentage for the actual duration
 out.setDurationFactor( 0.95f );
 // use pauseNotes to add a bunch of notes at once without time moving forward 
 out.pauseNotes();
 
 // specify the waveform for this group of notes
 Waveform disWave = Waves.sawh( 4 );
 // add these notes with disWave
 out.playNote( 0.0, 1.0, new ToneInstrument( "E4 ", vol, disWave, out ) );
 out.playNote( 1.0, 1.0, new ToneInstrument( "E4 ", vol, disWave, out ) );
 out.playNote( 2.0, 1.0, new ToneInstrument( "E4 ", vol, disWave, out ) );
 out.playNote( 3.0, 0.75, new ToneInstrument( "C4 ", vol, disWave, out ) );
 out.playNote( 3.75, 0.25, new ToneInstrument( "G4 ", vol, disWave, out ) );
 out.playNote( 4.0, 1.0, new ToneInstrument( "E4 ", vol, disWave, out ) );
 out.playNote( 5.0, 0.75, new ToneInstrument( "C4 ", vol, disWave, out ) );
 out.playNote( 5.75, 0.25, new ToneInstrument( "G4 ", vol, disWave, out ) );
 out.playNote( 6.0, 2.0, new ToneInstrument( "E4 ", vol, disWave, out ) );
 
 // specify the waveform for this group of notes
 disWave = Waves.triangleh( 9 );
 // add these notes with disWave
 out.playNote( 8.0, 1.0, new ToneInstrument( "B4 ", vol, disWave, out ) );
 out.playNote( 9.0, 1.0, new ToneInstrument( "B4 ", vol, disWave, out ) );
 out.playNote(10.0, 1.0, new ToneInstrument( "B4 ", vol, disWave, out ) );
 out.playNote(11.0, 0.75, new ToneInstrument( "C5 ", vol, disWave, out ) );
 out.playNote(11.75, 0.25, new ToneInstrument( "G4 ", vol, disWave, out ) );
 out.playNote(12.0, 1.0, new ToneInstrument( "Eb4 ", vol, disWave, out ) );
 out.playNote(13.0, 0.75, new ToneInstrument( "C4 ", vol, disWave, out ) );
 out.playNote(13.75, 0.25, new ToneInstrument( "G4 ", vol, disWave, out ) );
 out.playNote(14.0, 2.0, new ToneInstrument( "E4 ", vol, disWave, out ) );
 
 // specify the waveform for this group of notes
 disWave = Waves.randomNOddHarms( 3 );
 //add these notes with disWave
 out.playNote( 0.0, 1.9, new ToneInstrument( "E3 ", vol, disWave, out ) );
 out.playNote( 2.0, 1.9, new ToneInstrument( "E3 ", vol, disWave, out ) );
 out.playNote( 4.0, 1.9, new ToneInstrument( "E3 ", vol, disWave, out ) );
 out.playNote( 6.0, 1.9, new ToneInstrument( "E3 ", vol, disWave, out ) );
 
 // specify the waveform for this group of notes
 disWave = Waves.TRIANGLE;
 // add these notes with disWave
 out.playNote( 8.0, 1.9, new ToneInstrument( "E3 ", vol, disWave, out ) );
 out.playNote(10.0, 1.9, new ToneInstrument( "E3 ", vol, disWave, out ) );
 out.playNote(12.0, 1.9, new ToneInstrument( "C3 ", vol, disWave, out ) );
 out.playNote(14.0, 1.9, new ToneInstrument( "E3 ", vol, disWave, out ) );
 
 ////////////
 table = Waves.randomNOddHarms(9); 
 table = randomNoise();
 table.smooth( 64 );
 table.addNoise( 0.1f );
 wave  = new Oscil( 440, 0.05f, table );
 wave.patch( out );
 ////////////
 
 // use resumeNotes at the end of the section which needs guaranteed timing
 out.resumeNotes();
 
 */

///////////////////
/*
  Summer sum = new Summer();
 Oscil wave = new Oscil( Frequency.ofPitch("A4"), 0.3f, Waves.SINE );
 wave.patch( sum );
 
 wave = new Oscil( Frequency.ofPitch("C#5"), 0.3f, Waves.SINE );
 wave.patch( sum );
 
 wave = new Oscil( Frequency.ofPitch("E5"), 0.3f, Waves.SINE );
 wave.patch( sum );
 
 // and the Summer to the output and you should hear a major chord
 sum.patch( out );
 */
///////////////////

/*
// make our midi converter
 midi = new Midi2Hz( 50 );
 
 midi.patch( wave.frequency );
 wave.patch( out );
 */

//////////////////////////////////////////////////

/*
void keyPressed()
 {
 if ( key == 'a' ) midi.setMidiNoteIn( 50 );
 if ( key == 's' ) midi.setMidiNoteIn( 60 );
 if ( key == 'd' ) midi.setMidiNoteIn( 70 );
 if ( key == 'f' ) midi.setMidiNoteIn( 80 );
 if ( key == 'g' ) midi.setMidiNoteIn( 90 );
 if ( key == 'h' ) midi.setMidiNoteIn( 100 );
 if ( key == 'j' ) midi.setMidiNoteIn( 110 );
 if ( key == 'k' ) midi.setMidiNoteIn( 120 );
 if ( key == 'l' ) midi.setMidiNoteIn( 130 );
 if ( key == ';' ) midi.setMidiNoteIn( 140 );
 if ( key == '\'') midi.setMidiNoteIn( 150 );
 }
 */


///////////////////////////////////////////////////////

//out.playNote( 2.0, 2.9, new SineInstrument( Frequency.ofPitch( "C3" ).asHz() ) );
//out.playNote( 3.0, 1.9, new SineInstrument( Frequency.ofPitch( "E3" ).asHz() ) );
//out.playNote( 4.0, 0.9, new SineInstrument( Frequency.ofPitch( "G3" ).asHz() ) );

//////////////////////////////////////////////////

/*
  //// microphone input transform //// 
 
 AudioStream inputStream = minim.getInputStream( Minim.STEREO, 
 out.bufferSize(), 
 out.sampleRate(), 
 out.getFormat().getSampleSizeInBits()
 );
 in = new LiveInput( inputStream );
 
 Vocoder vocode = new Vocoder( 1024, 16 );
 in.patch( vocode.modulator );
 //synth.patch( vocode ).patch( out ); 
 */





