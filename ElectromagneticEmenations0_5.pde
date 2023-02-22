/**
ELECTROMAGNETIC EMENATIONS 0.5

This is the script used for the first performance of Electromagnetic Emenation 0.5 during the IMWI Institutsabend 2022.

It is designed to diplay a series frames t
**/


// wellen is used to receive the MIDI input from a KORGNanoControl2
import wellen.*; 
import netP5.*;
import oscP5.*;

// variables used for 
int startKey = 0;
int performancePart = 0;
int partProgress = 0;
int partProgress2 = 0;
int performanceFrame = 0;

// seqOne
int seqOneProgress = 0;

// 
int oneOneProgress = 0;
int oneOneTrem = 0;

// seqTwo
int seqTwoPart = 0;
int seqTwoFrames = 0;

// seqTwoTwo
int twoTwo1 = 0;
int twoTwo2 = 0;
int twoTwoFrame = 0;

// seqThreeThree
int three1;
int three2;
int threeFrame = 0;

// seqThree
int seqThreePart = 0;

// seqFive
int five1;
int five2;
int fiveFrame = 0;

// PitchBend
int pitchBendCycle = 0;
int pitchBendFrequency = 0;

// adsrNote
int adsrProgress = 0;
int adsrStartFrame = 0; 

// adsrNoise
int adsrNProgress = 0;
int adsrNStartFrame = 0;

// Fm Synthesis
int carrierPart = 0;
int square = 0;

// vibrato
int vibAdd = 0; 
int direction = 1;

// phasing
int phase = 0;

//trem
int volume;
int tremDirection;

// overtone
int linePart = 1;

// overtone Sweep
int overtoneNumber;

// circleSweep
int circleCounter = 0;
int sweepDirection = 0;

// circle
int circlePosX = 0;
int circlePosY = 0;
int circleDirectionX = 0;
int circleDirectionY = 0;

void setup(){
  fullScreen(2);
  background(0);
  EventReceiverMIDI.start(this, 1);
}


// the processing draw function, here the actual frames are drawn
void draw(){
  
  // 
  if(performancePart == 0)
    if(seqOne() & startKey == 1){
      startKey = 0;
      performancePart = 1;
      return;
    }
         
  if(performancePart == 1){
    background(0);
    if(partProgress == 150){
      performancePart = 2;
      partProgress = 0;
      return;
    }  
    partProgress ++;
  }
  
  if(performancePart == 2){
    if(seqTwo())
      partProgress ++;
    if(partProgress == 4){
      performancePart = 3;
      partProgress = 0;
      return;
    }      
  }
  
  if(performancePart == 3){
    if(seqTwoTwo()){
       partProgress ++;
    }
    if(partProgress == 4){
      performancePart = 4;
      partProgress = 0;
      return;
    }
  }
  
  if(performancePart == 4){
    if(seqThreeThree() == true){
      partProgress ++;
    }
    if(partProgress == 2){
      performancePart = 5;
      partProgress = 0;
      vibAdd = 0;
      return;
    }  
  }
  
  if(performancePart == 5){
    if(seqFour() == true){
      partProgress ++;
    }
    if(partProgress == 4){
      performancePart = 6;
      partProgress = 0;
      vibAdd = 0;
      return;
    }  
  }
  
  if(performancePart == 6){
    if(seqTwoTwo()){
       partProgress ++;
    }
    if(partProgress == 2){
      performancePart = 7;
      partProgress = 0;
      return;
    }
  }
  
  if(performancePart == 7){
    if(partProgress < 20){
      easyVibrato(261, 25);
    }
    if(partProgress >= 20 & partProgress < 40){
      overtoneSweep(2);
      circleDraw(600,400);
    }
    if(partProgress >= 40){
      partProgress2 ++;
      partProgress = 0;
    }
    partProgress ++;
    if(partProgress2 == 8){
      partProgress2 = 0;
      partProgress = 0;
      performancePart = 8;
    }
  }
  
  if(performancePart == 8){
    if(seqThreeThree() == true){
      partProgress ++;
    }
    if(partProgress == 2){
      performancePart = 9;
      partProgress = 0;
      vibAdd = 0;
      return;
    }  
  }
  
  if(performancePart == 9){ 
    if(partProgress2 < 4){
      if(partProgress == 0 && adsrNote(5,20,10, 261 + (100 * partProgress2)))
        partProgress = 1;
      if(partProgress == 1 && pitchBendUp(300,16000))
        partProgress = 2;
      if(partProgress == 2 && pitchBendUp(800,16000))
        partProgress = 3;
      if(partProgress == 3 && pitchBendUp(1000,16000)){
        partProgress = 0;
        partProgress2 ++;
      }  
    } 
    else{
      performancePart = 10;
      partProgress = 0;
      partProgress2 = 0;
    }
  }
  
  if(performancePart == 10){
    if(partProgress < 20)
      drawNoteColor(440, 255, 0, 0);
    if(partProgress < 40 & partProgress >= 20)
      drawNoteColor(440, 0, 255, 255);
    if(partProgress < 60 & partProgress >= 40)
      drawNoteColor(440, 255, 0, 255);
    if(partProgress < 80 & partProgress >= 60)
      drawNoteColor(440, 255, 255, 0); 
    if(partProgress > 80){
      partProgress2 ++;
      partProgress = 0;
    }
    if(partProgress2 == 4){
      partProgress = 0;
      partProgress2 = 0;
      performancePart = 11;
      return;
    }
    partProgress ++;
  }
  
  if(performancePart == 11){
    if(seqThreeThree() == true){
      partProgress ++;
    }
    if(partProgress == 2){
      performancePart = 12;
      partProgress = 0;
      vibAdd = 0;
      return;
    }  
  }
  
  if(performancePart == 12){ 
    if(partProgress2 < 4){
      if(partProgress == 0 && pitchBendUp(200,5000))
        partProgress = 1;
      if(partProgress == 1 && pitchBendUp(300,6000))
        partProgress = 2;
      if(partProgress == 2 && pitchBendUp(800,7000))
        partProgress = 3;
      if(partProgress == 3 && pitchBendUp(1000,10000)){
        partProgress = 0;
        partProgress2 ++;  
      } 
      circleDraw(400,400);
    } 
    
    else{
      performancePart = 13;
      partProgress = 0;
      partProgress2 = 0;
    }
  }
  
  if(performancePart == 13){
    if(seqFive())
      partProgress ++;
    if(partProgress == 4){
      performancePart = 14;
      partProgress = 0;
      return;
    }      
  }
  
  if(performancePart == 14){
    if(partProgress < 20){
      easyTrem(261, 2);
    }
    if(partProgress >= 20 & partProgress < 40){
      overtoneSweep(2);
      circleDraw(600,400);
    }
    if(partProgress >= 40){
      partProgress2 ++;
      partProgress = 0;
    }
    partProgress ++;
    if(partProgress2 == 8){
      partProgress2 = 0;
      partProgress = 0;
      performancePart = 15;
    }
  }
  
   if(performancePart == 15){
    if(seqTwoTwo()){
       partProgress ++;
    }
    if(partProgress == 4){
      performancePart = 16;
      partProgress = 0;
      return;
    }
  }
  
  if(performancePart == 16){
    if(seqOneOne()){
       partProgress ++;
    }
    if(partProgress == 4){
      performancePart = 17;
      partProgress = 0;
      return;
    }
  }
  
  if(performancePart == 17){
    if(seqTwo())
      partProgress ++;
    if(partProgress == 8){
      performancePart = 18;
      partProgress = 0;
      return;
    }      
  }
  
 if(performancePart == 18){
   background(0);
 }
}

boolean seqOne(){
  if(seqOneProgress < 30)
    drawNote(440, 255);
  if(30 < seqOneProgress & seqOneProgress < 60)
    drawNote(659, 255);
  if(60 < seqOneProgress & seqOneProgress < 90)
    drawNote(880, 255);
  if(90 < seqOneProgress & seqOneProgress < 120)
    drawNote(587, 255);
  seqOneProgress ++;  
  if(120 <= seqOneProgress){
    seqOneProgress = 0;
    return true;
  }  
  else 
    return false;
}

boolean seqOneOne(){
  if(oneOneProgress < 30)
    easyTrem(578, 5 + oneOneTrem);
  if(30 < oneOneProgress & oneOneProgress < 60)
    easyTrem(880, 5 + oneOneTrem);
  if(60 < oneOneProgress & oneOneProgress < 90)
    easyTrem(659, 5 + oneOneTrem);
  if(90 < oneOneProgress & oneOneProgress < 120)
    easyTrem(440, 5 + oneOneTrem);
  oneOneProgress ++;  
  if(120 <= oneOneProgress){
    oneOneProgress = 0;
    oneOneTrem ++;
    return true;
  }  
  else 
    return false;
}

boolean seqTwo(){
  if(seqTwoPart == 0){
    if(adsrNote(5,20,10, 261) == true){
       seqTwoFrames = frameCount;
       seqTwoPart = 1;
       return false;
    }   
  }  
  if(seqTwoPart == 1){
    background(0);
    if(frameCount - seqTwoFrames == 35){
       seqTwoPart = 0;
       return true;
    }     
  }
  return false;
}

boolean seqTwoTwo(){
  if(twoTwo2 == 0){
      if(adsrNote(5,5,10,261)){
        twoTwo1 ++;
      }  
      if(twoTwo1 == 6){
        twoTwo2 = 1;
        twoTwo1 = 0;
        twoTwoFrame = frameCount;
        return false;
      }
   }
   if(twoTwo2 == 1){
      if(frameCount - twoTwoFrame <= 10)
        drawNote(532, 255);
      if(frameCount - twoTwoFrame <= 20 & frameCount - twoTwoFrame >= 10)
        drawNote(1047, 255);
      if(frameCount - twoTwoFrame <= 30 & frameCount - twoTwoFrame >= 20)
        drawNote(1586, 255);
      if(frameCount - twoTwoFrame <= 40 & frameCount - twoTwoFrame >= 30)
        drawNote(1397, 255);
      if(frameCount - twoTwoFrame > 40){
        twoTwo2 = 0;
        return true;   
      }  
   }
   return false;
}
 
boolean seqThreeThree(){
  if(three2 == 0){
      if(three1 % 2 == 0 && adsrNote(5,5,10,261)){
        three1 ++;
      }
      if(three1 % 2 == 1 && adsrNoise(2,5,5)){
        three1 ++;
      } 
      if(three1 == 6){
        three2 = 1;
        three1 = 0;
        threeFrame = frameCount;
        return false;
      }
   }
   if(three2 == 1){
      if(frameCount - threeFrame <= 10)
        drawNote(532, 255);
      if(frameCount - threeFrame <= 20 & frameCount - threeFrame >= 10)
        drawNote(1047, 255);
      if(frameCount - threeFrame <= 30 & frameCount - threeFrame >= 20)
        drawNote(1586, 255);
      if(frameCount - threeFrame <= 40 & frameCount - threeFrame >= 30)
        drawNote(1397, 255);
      if(frameCount - threeFrame > 40){
        three2 = 0;
        return true;   
      }  
   }
   return false;
} 

boolean seqThree(){
  if(seqThreePart == 0 && adsrNoise(2,5,20))
    seqThreePart ++;
  if(seqThreePart == 1 && adsrNote(2,5,20,440)){
    seqThreePart = 0;
    return true;
  }  
  return false;  
}

boolean seqFour(){
  if(seqOneProgress < 20)
    easyVibrato(440, 25);
  if(20 < seqOneProgress & seqOneProgress < 40)
    easyVibrato(659, 25);
  if(40 < seqOneProgress & seqOneProgress < 60)
    easyVibrato(880, 25);
  if(60 < seqOneProgress & seqOneProgress < 80)
    easyVibrato(587, 25);
  seqOneProgress ++;  
  if(80 <= seqOneProgress){
    seqOneProgress = 0;
    return true;
  }  
  else 
    return false;
}

boolean seqFive(){
  if(five2 == 0){
      if(five1 % 2 == 0 && adsrNoise(2,20,10)){
        five1 ++;
        fiveFrame = frameCount;
      }
      if(five1 % 2 == 1){
        easyVibrato(440, 25);
        if(frameCount - fiveFrame > 40)
          five1 ++;
      } 
      if(five1 == 6){
        five2 = 1;
        five1 = 0;
        fiveFrame = frameCount;
        return false;
      }
   }
   if(five2 == 1){
      if(frameCount - fiveFrame <= 10)
        drawNote(1379, 255);
      if(frameCount - fiveFrame <= 20 & frameCount - fiveFrame >= 10)
        drawNote(1586, 255);
      if(frameCount - fiveFrame <= 30 & frameCount - fiveFrame >= 20)
        drawNote(1047, 255);
      if(frameCount - fiveFrame <= 40 & frameCount - fiveFrame >= 30)
        drawNote(532, 255);
      if(frameCount - fiveFrame > 40){
        five2 = 0;
        return true;   
      }  
   }
   return false;
} 

void drawNote(int frequency, int noteShade){
  noStroke();
  background(0);
  int wavelength = height / (frequency / 60);
  int halfWavelength = wavelength / 2;
  for(int i=0; i <= height / wavelength; i++){
      fill(noteShade);
      quad(0,i*wavelength,0, i * wavelength + halfWavelength, width, i * wavelength + halfWavelength, width, i * wavelength);
      fill(0);
      quad(0, i * wavelength + halfWavelength, 0 , (i+1) * wavelength, width, (i+1) * wavelength, width, i * wavelength + halfWavelength);
  }
}

void drawNoteColor(int frequency, int red, int green, int blue){
  noStroke();
  background(0);
  int wavelength = height / (frequency / 60);
  int halfWavelength = wavelength / 2;
  for(int i=0; i <= height / wavelength; i++){
      fill(0);
      quad(0,i*wavelength,0, i * wavelength + halfWavelength, width, i * wavelength + halfWavelength, width, i * wavelength);
      fill(red, green, blue);
      quad(0, i * wavelength + halfWavelength, 0 , (i+1) * wavelength, width, (i+1) * wavelength, width, i * wavelength + halfWavelength);
  }
}

boolean pitchBendUp(int low, int high){
  if(pitchBendCycle == 0){
    pitchBendFrequency = low;
  }
  if(pitchBendFrequency <= high){
    drawNote(pitchBendFrequency, 255);
    pitchBendCycle ++;
    pitchBendFrequency += pow(pitchBendCycle, 2);
    return false;
  } 
  else{
    pitchBendCycle = 0;
    return true;
  }  
}

void pitchBendDown(int low, int high){
  if(pitchBendCycle == 0){
    pitchBendFrequency = high;
  }
  if(pitchBendFrequency >= low){
    drawNote(pitchBendFrequency, 255);
    pitchBendCycle ++;
    pitchBendFrequency -= 1 / pow(pitchBendCycle, 2);
  } 
  else
    pitchBendCycle = 0;
}

boolean adsrNote(int attack, int sustain, int release, int frequency){
  int attackChange = 256 / attack;
  int releaseChange = 256 / release;
  boolean finished = false;
  if(adsrProgress == 0){
    adsrStartFrame = frameCount;
    adsrProgress = 1;
  }
  if(adsrProgress == 1){
    if(frameCount - adsrStartFrame > attack){
      adsrProgress = 2;
    }
    else{
      drawNote(frequency, 0 + (attackChange * (frameCount - adsrStartFrame)));
      finished = false;
    }
  }
  if(adsrProgress == 2){
    if(frameCount - adsrStartFrame - attack > sustain){
      adsrProgress = 3;
    }
    else{
      drawNote(frequency, 255);
      finished = false;
    }
  }
  if(adsrProgress == 3){
    if(frameCount - attack - sustain - adsrStartFrame > release){
      adsrProgress = 0;
      finished = true;
    }
    else{
      drawNote(frequency, 255 - (releaseChange * (frameCount - adsrStartFrame - attack - sustain)));
      finished = false;
    }
  }
  return finished;
}

void easyFm(int carrierFrequency, int modIndex){
  if(square == 1){
    drawNote(carrierFrequency + modIndex, 255);
    square = 0;
  }
  else{
    drawNote(carrierFrequency, 255);
    square ++;
  }
}

void easyVibrato(int frequency, int depth){
    drawNote(frequency + vibAdd, 255);
    if(vibAdd >= depth){
      direction = 0;
    }
    if(vibAdd <= -depth){
      direction = 1;
    }
    if(direction == 1){
      vibAdd += 150;
    }
    if(direction == 0){
      vibAdd -= 150;
    }
}

void easyTrem(int frequency, int speed){
  int speedScaled = 256 / speed;
  if(volume >= 255){
    tremDirection = 0;
    drawNote(frequency, 255);
    volume = 255 - speedScaled;
    return;
  }
  if(volume <= 0){
    tremDirection = 1;
    drawNote(frequency, 0);
    volume = 0 + speedScaled;
    return;
  }
  if(tremDirection == 1){
    drawNote(frequency, volume);
    volume = volume + speedScaled;
  }
  else{
    drawNote(frequency, volume);
    volume = volume - speedScaled;
  } 
}

void noise(int volume){
  background(0);
  for(int i = 0; i <= height; i++){
    stroke(random(volume));
    strokeWeight(1);
    line(0, i, width, i);
  }
}

boolean adsrNoise(int attack, int sustain, int release){
  int attackChange = 256 / attack;
  int releaseChange = 256 / release;
  boolean finished = false;
  if(adsrNProgress == 0){
    adsrNStartFrame = frameCount;
    adsrNProgress = 1;
  }
  if(adsrNProgress == 1){
    if(frameCount - adsrNStartFrame > attack){
      adsrNProgress = 2;
    }
    else{
      noise(0 + (attackChange * (frameCount - adsrNStartFrame)));
      finished = false;
    }
  }
  if(adsrNProgress == 2){
    if(frameCount - adsrNStartFrame - attack > sustain){
      adsrNProgress = 3;
    }
    else{
      noise(255);
      finished = false;
    }
  }
  if(adsrNProgress == 3){
    if(frameCount - attack - sustain - adsrNStartFrame > release){
      adsrNProgress = 0;
      finished = true;
    }
    else{
      noise(255 - (releaseChange * (frameCount - adsrNStartFrame - attack - sustain)));
      finished = false;
    }
  }
  return finished;
}

void overtone(int order){
  background(0);
  for(int i = 0; i <= height; i++){
    if(linePart <= order)
      stroke(255);
    if(linePart > order)
      stroke(0);
    line(0, i, width, i);  
    linePart ++;
    if(linePart > 2 * order)
      linePart = 1;     
  }
}

void overtoneSweep(int speed){
  if(overtoneNumber <= speed)
    overtone(5);
  if(overtoneNumber >= speed  & overtoneNumber <= speed * 2 )
    overtone(6);
  if(overtoneNumber >= speed * 2 & overtoneNumber <= speed * 3)
    overtone(7);
  if(overtoneNumber >= speed * 3 & overtoneNumber <= speed * 4)
    overtone(8);
  if(overtoneNumber >= speed * 4 & overtoneNumber <= speed * 5)
    overtone(9);
  if(overtoneNumber >= speed * 5) 
    overtoneNumber = 0;
  overtoneNumber ++;
}

void circleSweep(int speed, int circleSpeed, int startSize, int endSize){
  if(circleCounter <= 0)
    sweepDirection = 0;
  if(circleCounter >= endSize - startSize)
    sweepDirection = 1;
  if(sweepDirection == 0)
    circleCounter += speed;
  if(sweepDirection == 1)
    circleCounter -= speed;
  circleDraw(circleCounter + startSize, circleSpeed);  
}

void circleDraw(int cWidth, int speed){
  fill(0);
  if(circlePosX + cWidth >= width)
    circleDirectionX = 1;
  if(circlePosX + cWidth <= 0)
    circleDirectionX = 0;
  if(circlePosY + cWidth >= height)
    circleDirectionY = 1;
  if(circlePosY + cWidth <= 0)
    circleDirectionY = 0;
  if(circleDirectionX == 0){
    if(circleDirectionY == 0){
      circle(circlePosX + cWidth, circlePosY + cWidth, cWidth);
      circlePosY += speed;
    }
    if(circleDirectionY == 1){
      circle(circlePosX + cWidth, circlePosY + cWidth, cWidth);
      circlePosY -= speed;
    }
    circlePosX += speed;
  }
  if(circleDirectionX == 1){
    if(circleDirectionY == 0){
      circle(circlePosX + cWidth, circlePosY + cWidth, cWidth);
      circlePosY += speed;
    }
    if(circleDirectionY == 1){
      circle(circlePosX + cWidth, circlePosY + cWidth, cWidth);
      circlePosY -= speed;   
    }
    circlePosX -= speed;
  }
}

void event_receive(int pEvent, float[] pData){
    if(pData[1] == 41 & pData[2] == 127)
      startKey = 1;
    if(pData[1] == 42 & pData[2] == 127)
      performancePart = 0;  
}

void keyPressed() {
  if ((key == 32) & (performancePart == 0)) {
    startKey = 1;
  }
}
