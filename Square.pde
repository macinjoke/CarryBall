/*
  動かない四角（角の丸みの設定可）の物体
*/


class Square{
  
  PVector p;
  int sizeX;
  int sizeY;
  int r;
  float e;
  boolean onFlag;
  int type;
  
  Square(int x, int y, int sizeX, int sizeY, int r, int type){
    p = new PVector(x,y);
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    this.r = r;
    this.type = type;
    if(type == 1)
      e = 0.8;
    if(type == 2)
      e = 2.5;
    if(type == 3)
      e = 0;
  }
  
  void show(){
    
    line(p.x +r, p.y        , p.x +sizeX -r,         p.y);
    line(p.x +r, p.y +sizeY , p.x +sizeX -r, p.y + sizeY);
    line(p.x        , p.y +r, p.x        , p.y +sizeY -r);
    line(p.x + sizeX, p.y +r, p.x +sizeX , p.y +sizeY -r);
    noFill();
    arc(p.x +r, p.y +r, r*2, r*2, PI, PI+ HALF_PI);
    arc(p.x +sizeX -r, p.y +r, r*2, r*2, PI+ HALF_PI, TWO_PI);
    arc(p.x +sizeX -r, p.y +sizeY -r, r*2, r*2, 0, HALF_PI);
    arc(p.x +r, p.y +sizeY -r, r*2, r*2, HALF_PI, PI);
    textSize(20);
    fill(0);
    textAlign(CENTER, CENTER);
    if(type == 2){
      fill(255,0,0);
      text("HOP", p.x +sizeX/2, p.y +sizeY/2);
    }
    if(type == 3){
      fill(0,0,255);
      text("GUM", p.x +sizeX/2, p.y +sizeY/2);
    }
  }
  
  void collision( Ball ball, int ballNum){
    
    float elas = e * ball.getElas();
    
    PVector[] calcResult;
    
    if(ballNum == 0)
      onFlag = false;
    
    if( ball.getVy() >= 0){
      if(ball.getY() > p.y -ball.getR() && ball.getY() < p.y +sizeY
      && ball.getX() > p.x +r && ball.getX() < p.x +sizeX -r){
        ball.setY( p.y -ball.getR() );
        ball.setVy( -1 *elas *ball.getVy() );
        if(ballNum == 0)
          onFlag = true;
      }
    }
    else{
      if(ball.getY() > p.y && ball.getY() < p.y +sizeY +ball.getR()
      && ball.getX() > p.x +r && ball.getX() < p.x +sizeX -r){
        ball.setY( p.y +sizeY +ball.getR() );
        ball.setVy( -1 *elas *ball.getVy() );
      }
    }
    if( ball.getVx() >= 0){
      if(ball.getX() > p.x -ball.getR() && ball.getX() < p.x +sizeX
      && ball.getY() > p.y +r && ball.getY() < p.y +sizeY -r){
        ball.setX( p.x -ball.getR() );
        ball.setVx( -1 *elas *ball.getVx() );
      }
    }
    else{
      if(ball.getX() > p.x && ball.getX() < p.x +sizeX +ball.getR()
      && ball.getY() > p.y +r && ball.getY() < p.y +sizeY -r){
        ball.setX( p.x +sizeX +ball.getR() );
        ball.setVx( -1 *elas *ball.getVx() );
      }
    }
    
    for(int j=0; j<2; j++){
      for(int i=0; i<2; i++){  
        if( ball.twoCircleMatch(ball.getP(),
            PVector.add(p, new PVector(r +i*(sizeX -2*r), r +j*(sizeY -2*r)) ) ,ball.getR(), r ) ){
            //衝突後の速度と位置を取得
            calcResult = ball.clacCircleCollision(
              ball.getP(), PVector.add(p, new PVector(r +i*(sizeX -2*r), r +j*(sizeY -2*r))),
              ball.getV(), new PVector(0,0), ball.getR(), r, 0, 1, ball.getElas(), elas 
            );
            //結果をそれぞれ代入
            ball.setV( calcResult[0] );
            ball.setP( calcResult[2] );
            
        }
      }
    }

  }
  
  //以下、ゲッター
  PVector getP(){
    return p;
  }
  int getX(){
    return int(p.x);
  }
  int getY(){
    return int(p.y);
  }
  int getSizeX(){
    return sizeX;
  }
  int getSizeY(){
    return sizeY;
  }
  int getR(){
    return r;
  }
  boolean getOnFlag(){
    return onFlag;
  }
  
}

