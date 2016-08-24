/*
  動かない円の物体
*/

class Circle{
  
  PVector p;
  int r;
  float elas;
  int type;
  
  Circle(int x, int y, int r, int type){
    p = new PVector(x,y);
    this.r = r;
    this.type = type;
    if(type == 1)
      elas = 0.8;
    if(type == 2)
      elas = 1.8;
    if(type == 3)
      elas = 0;
  }
  
  void show(){
    noFill();
    ellipse(p.x, p.y, r*2, r*2);
    
    textSize(20);
    textAlign(CENTER, CENTER);
    if(type == 2){
      fill(255,0,0);
      text("HOP", p.x, p.y);
    }
    if(type == 3){
      fill(0,0,255);
      text("GUM", p.x, p.y);
    }
    
    
  }
  
  void collision( Ball ball){
    
    PVector[] calcResult;
      
    if( ball.twoCircleMatch(ball.getP(), p, ball.getR(), r ) ){
        //衝突後の速度と位置を取得
        calcResult = ball.clacCircleCollision(
          ball.getP(), p, ball.getV(), new PVector(0,0),
          ball.getR(), r, 0, 1, ball.getElas(), elas 
        );
        //結果をそれぞれ代入
        ball.setV( calcResult[0] );
        ball.setP( calcResult[2] );
        
    }
    
  }
  
  //以下、getter
  PVector getP(){
    return p;
  }
  int getX(){
    return int(p.x);
  }
  int getY(){
    return int(p.y);
  }
  int getR(){
    return r;
  }
  
  
}
