/*
  スタート画面
*/

class StartScreen{
  
  Play play; // ブロック崩し本体
  Map map;
  PImage start;
  PImage cursor1;
  PImage titleBar1;
  PImage titleBar1on;
  PImage titleBar2;
  PImage titleBar2on;
  PImage titleBar3;
  PImage titleBar3on;
  PImage howToPlay;
  PImage congrats;
  int state;
  int stage;
  int mouseBallMax[];
  int squareMaps[][][];
  int circleMaps[][][];
  int ballMaps[][][];
  int boxMaps[][][];
  int playCount;
  
  StartScreen(){
    map = new Map();
    mouseBallMax = map.getMouseBallMax();
    squareMaps = map.getSquareMaps();
    circleMaps = map.getCircleMaps();
    ballMaps = map.getBallMaps();
    boxMaps = map.getBoxMaps();
    start = loadImage("start.png");
    cursor1 = loadImage("cursor_1.png");
    titleBar1 = loadImage("title_bar_1.png");
    titleBar1on = loadImage("title_bar_1_on.png");
    titleBar2 = loadImage("title_bar_2.png");
    titleBar2on = loadImage("title_bar_2_on.png");
    titleBar3 = loadImage("title_bar_3.png");
    titleBar3on = loadImage("title_bar_3_on.png");
    howToPlay = loadImage("how_to_play.png");
    congrats = loadImage("congrats.png");
    state = 1;
    playCount = 0;
  }
  
  
  void show(){
    if(state == 1){
      image(start, 0,0);
      if(mouseX >= 220 && mouseX <= 580 && mouseY >= 400 && mouseY <= 460)
        image(titleBar1on, 220, 400, 360,60);
      else
        image(titleBar1, 220, 400, 360,60);
      if(mouseX >= 220 && mouseX <= 580 && mouseY >= 470 && mouseY <= 530)  
        image(titleBar2on, 220, 470, 360,60);
      else
        image(titleBar2, 220, 470, 360,60);
    }
    
    if(state == 2){
      
      for(int j=0; j<2 ; j++){
        for(int i=0; i<3; i++){
          fill(255,255,255);
          rect(i*210 + 100, j*210 + 100,180,180);
          fill(0,0,0);
          textSize(50);
          textAlign(LEFT);
          text("stage"+ (i+1+j*3)  , i*210 + 100+10, j*210 + 200);
        }
      }
      
          
      if(mouseX >= 20 && mouseX <= 320 && mouseY >= 530 && mouseY <= 580)
        image(titleBar3on, 20, 530, 300,50);
      else
        image(titleBar3, 20, 530, 300,50);
      
    }
    
    if(state == 3){
      image(howToPlay,0,0);
      
      if(mouseX >= 20 && mouseX <= 320 && mouseY >= 530 && mouseY <= 580)
        image(titleBar3on, 20, 530, 300,50);
      else
        image(titleBar3, 20, 530, 300,50);
    }
    
    if(state == 0){
      this.play();
    }
    
    if(state == 4){
      image(congrats, 0, 0);
      if(mouseX >= 20 && mouseX <= 220 && mouseY >= 540 && mouseY <= 580)
        image(titleBar3on, 20, 540);
      else
        image(titleBar3, 20, 540);
    }
    
    if(state != 0)
      image(cursor1, mouseX + random(-3,3) -15, mouseY + random(-3,3) -15, 30,30);
  }
  
  void play(){
    play.draw();
    if( play.getBackFlag() ){
      playCount = 0;
      state = 2;
    }
    if( play.getNextFlag() ){
      playCount = 0;
      stage ++;
      play = new Play(stage, squareMaps[stage-1], circleMaps[stage-1],
                                  ballMaps[stage-1], boxMaps[stage-1], mouseBallMax[stage-1] );
    }
    if( play.getRetryFlag() ){
      playCount = 0;
      play = new Play(stage, squareMaps[stage-1], circleMaps[stage-1],
                                  ballMaps[stage-1], boxMaps[stage-1], mouseBallMax[stage-1] );
    }
    if( play.getCongratsFlag() ){
      playCount = 0;
      state = 4;
    }
    
  }
    
  
  void mousePressed(){
    if(state == 1){
      if(mouseX >= 220 && mouseX <= 580 && mouseY >= 400 && mouseY <= 460)
        state = 2;
      if(mouseX >= 220 && mouseX <= 580 && mouseY >= 470 && mouseY <= 530)
        state = 3;
    }
    else if(state == 2){
      if(mouseX >= 20 && mouseX <= 320 && mouseY >= 530 && mouseY <= 580)
        state = 1;
        
      if(mouseX >= 100 && mouseX <= 280 && mouseY >= 100 && mouseY <= 280){
        state = 0;
        stage = 1;
        play = new Play(stage, squareMaps[0], circleMaps[0], ballMaps[0], boxMaps[0], mouseBallMax[0]);
      }
      if(mouseX >= 310 && mouseX <= 490 && mouseY >= 100 && mouseY <= 280){
        state = 0;
        stage = 2;
        play = new Play(stage, squareMaps[1], circleMaps[1], ballMaps[1], boxMaps[1], mouseBallMax[1]);
      }
      if(mouseX >= 520 && mouseX <= 700 && mouseY >= 100 && mouseY <= 280){
        state = 0;
        stage = 3;
        play = new Play(stage, squareMaps[2], circleMaps[2], ballMaps[2], boxMaps[2], mouseBallMax[2]);
      }
      if(mouseX >= 100 && mouseX <= 280 && mouseY >= 310 && mouseY <= 490){
        state = 0;
        stage = 4;
        play = new Play(stage, squareMaps[3], circleMaps[3], ballMaps[3], boxMaps[3], mouseBallMax[3]);
      }
      if(mouseX >= 310 && mouseX <= 490 && mouseY >= 310 && mouseY <= 490){
        state = 0;
        stage = 5;
        play = new Play(stage, squareMaps[4], circleMaps[4], ballMaps[4], boxMaps[4], mouseBallMax[4]);
      }
      if(mouseX >= 520 && mouseX <= 700 && mouseY >= 310 && mouseY <= 490){
        state = 0;
        stage = 6;
        play = new Play(stage, squareMaps[5], circleMaps[5], ballMaps[5], boxMaps[5], mouseBallMax[5]);
      }
    }
    else if(state == 3){
      if(mouseX >= 20 && mouseX <= 320 && mouseY >= 530 && mouseY <= 580)
        state = 1;
    }
    
    else if(state == 4){
      if(mouseX >= 20 && mouseX <= 220 && mouseY >= 540 && mouseY <= 580)
        state = 1;
    }
    
    else if(state == 0){   
        play.mousePressed();
    }
      
  }
  
  void mouseReleased(){
    if(state == 0){
      if(playCount > 0)
        play.mouseReleased();
      playCount ++;
    }
  }
  
  void keyPressed(char key, int keyCode){
    if(state == 0)
      play.keyPressed(key, keyCode);
  }
  void keyReleased(char key, int keyCode){
    if(state == 0)
      play.keyReleased(key, keyCode);
  }
   
}
