/*
  マウスクリックで出せるボール
*/

class MouseBall extends Ball{
  
  PImage mouseBall;
  
  MouseBall(int x, int y, int r, int elas, int type){
    super(x ,y, r, elas, type, 0);
    
    mouseBall = loadImage("ball_mouse.png");
    
  }
  
  void show(){
    
    image(mouseBall, p.x -r, p.y -r, r*2, r*2);
    
  }


}
