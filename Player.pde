/*
  キーボードで動かせる赤ボール
*/

class Player extends Ball{
  
  PImage player;
  float dvx;
  float dvy;
  int vxMax;
  boolean jumpFlag;
  
  Player(int x, int y, int r, int elas, int type, int num){
    super(x, y, r, elas, type, num);
    
    dvx = 0.2;
    dvy = 13;
    vxMax = 3;
    player = loadImage("player.png");
  }
  
  void keyMove(Key[] keys, Square[] square){
    
    int onFlagCount = 0;
    for(int i=0; i< square.length ; i++){
      if( square[i].getOnFlag() )
        onFlagCount ++;
    }
    jumpFlag = false;
   
    if( keys[3].getIsPressed() && v.x < vxMax)
      v.x += dvx;
    if( keys[2].getIsPressed() && v.x > -vxMax)
      v.x -= dvx;
    if( keys[0].getIsPressed() && onFlagCount > 0 )
      jumpFlag = true;
      
    if(jumpFlag)
      v.y = -dvy;
       
  }
  
  void show(){
    image(player, p.x -r, p.y -r, r*2,r*2);
    if(num != 0){
      fill(0,100);
      textSize(30);
      textAlign(CENTER, CENTER);
      text(num, p.x, p.y);
    }
    
    /*
    fill(0);
    textSize(20);
    textAlign(LEFT);
    text("x :"+p.x, 0,20);
    text("y :"+p.y, 0,40);
    text("vx:"+v.x, 0,60);
    text("vy:"+v.y, 0,80);
    text("m :"+m  , 0,100);
    */
    
  }
  
}
