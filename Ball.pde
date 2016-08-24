/*
   基本的な動くボール
*/
class Ball{
  
  PVector p;  //変位
  PVector v;  //速度
  PVector air; //空気抵抗による加速度
  float r;
  float size;
  float m;
  float elas;
  int type;
  int num;
  boolean exitFlag;
  
  PImage[] ball;
  
  Ball(int x, int y, int r, int elas, int type, int num){
    v = new PVector(0, -1);
    p = new PVector(x, y);
    air = new PVector(0,0);
    this.r = r;
    size = PI*sq(r);
    if( type == 1)
      m = size     /divM;
    if( type == 2)
      m = size*3   /divM;
    if( type == 3)
      m = size*0.3 /divM;
      
    this.elas = elas *0.1;
    this.type = type;
    this.num = num;
    
    ball = new PImage[3];
    for(int i=0; i<ball.length; i++)
      ball[i] = loadImage("ball_"+nf(i+1,1)+".png");
  }
  
  void move(){
    air = PVector.mult(v, -k*r*PI/m); //空気抵抗による加速度を計算
    v.add(air);
    v.y += gravity;
    p.add(v);
    
    if( p.y > 600 + r && num != 0)
      exitFlag = true;
       
  }
  
  //ボール同士の当たり判定と物理演算
  void collision( Ball[] balls, int ballNum, int allBallNum){
    
    PVector[] calcResult;
    
    for(int i=ballNum + 1; i < allBallNum ; i++){//自身の番号より後ろのボールの数だけ繰り返す
        
      if(this.twoCircleMatch(p, balls[i].getP(), r, balls[i].getR() ) ){
        //衝突後の速度と位置を取得
        calcResult = this.clacCircleCollision(
          p, balls[i].getP(), v, balls[i].getV(),
          r, balls[i].getR(), m, balls[i].getM(), elas, balls[i].getElas() 
        );
        //結果をそれぞれ代入
        v = calcResult[0];
        balls[i].setV( calcResult[1] );
        p = calcResult[2];
        balls[i].setP( calcResult[3] );
        
      }
        
    }
    
  }
  
  void show(){
    
    image(ball[type-1], p.x -r, p.y -r, r*2, r*2);
    if( num != 0){
      fill(0);
      textSize(30);
      textAlign(CENTER, CENTER);
      text(num, p.x, p.y);
    }
  }
  
  //２つの円が接触しているかどうか返すメソッド
  boolean twoCircleMatch(PVector p1, PVector p2, float r1, float r2){
    boolean result;
    if ( PVector.dist(p1,p2) < r1 + r2)
      result = true;
    else
      result = false;
    
    return result;
  }
  
  //衝突後の２円の速度と位置を返すメソッド
  PVector[] clacCircleCollision(
    PVector p1, PVector p2, PVector v1, PVector v2,
    float r1, float r2, float m1, float m2, float e1, float e2
  )
  {
    PVector[] result = new PVector[4];
    float totalM = m1 + m2;
    float elas = 1 + e1*e2;
    PVector c = PVector.sub(p2,p1);
    c.normalize();
    float dot = PVector.dot( PVector.sub(v1,v2) , c );
    PVector constVec = PVector.mult(c, elas*dot/totalM);
    
    result[0] = PVector.add( PVector.mult(constVec, -m2) , v1 );
    result[1] = PVector.add( PVector.mult(constVec, m1) , v2 );
    
    result[2] = PVector.add( PVector.mult(c,-(r1 +r2)), p2);
    result[3] = PVector.add( PVector.mult(c, r1 +r2), p1);
    
    return result;
    
  }
  
  
  //以下、ゲッターとセッター
  PVector getP(){
    return p;
  }
  void setP(PVector p){
    this.p = p;
  }
  
  float getX(){
    return p.x;
  }
  void setX(float x){
    p.x = x;
  }
  float getY(){
    return p.y;
  }
  void setY(float y){
    p.y = y;
  }
  PVector getV(){
    return v;
  }
  void setV(PVector v){
    this.v = v;
  }
  float getVx(){
    return v.x;
  }
  void setVx(float vx){
    v.x = vx;
  }
  float getVy(){
    return v.y;
  }
  void setVy(float vy){
    v.y = vy;
  }
  float getR(){
    return r;
  }
  float getM(){
    return m;
  }
  float getElas(){
    return elas;
  }
  int getNum(){
    return num;
  }
  boolean getExitFlag(){
    return exitFlag;
  }
  
}
  
