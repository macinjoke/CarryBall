/*
  ボールを入れるべき場所のボックス
*/

class Box{
  
  int x;
  int y;
  int sizeX;
  int sizeY;
  int num;
  boolean fillFlag;
  
  Box(int x, int y, int sizeX, int sizeY, int num){
    this.x = x;
    this.y = y;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    this.num = num;
    fillFlag = false;
  }
  
  void show(){
    
    if(fillFlag == false)
      fill(255,255,0,100);
    else
      fill(122,122,0,100);
    rect(x,y,sizeX,sizeY);
    fill(0, 100);
    textSize(30);
    textAlign(CENTER, CENTER);
    text(num, x +sizeX/2, y +sizeY/2);
    
  }
  
  void collision( Ball[] ball , int allBallNum){
    
    boolean[] fillFlags = new boolean[ball.length]; //ボールの数が要素数の配列を宣言
    for( int i=0; i< allBallNum; i++){ //全てのボールに対して
      if(this.pointSquareMatch( ball[i].getX(), ball[i].getY(), x, y, sizeX, sizeY) 
      && num == ball[i].getNum() ) // 番号が同じの箱に触れているか判定する 
        fillFlags[i] = true;
      else
        fillFlags[i] = false;
    }
    
    if( this.totalFillFlag(fillFlags, true, ball.length) == this.totalBallNum(ball, num, allBallNum) )
      fillFlag = true;
    else
      fillFlag = false;  
    
  }
  
  //点と長方形の当たり判定の結果を返すメソッド
  boolean pointSquareMatch(float x, float y, float sqX, float sqY, float sizeX, float sizeY){
    boolean result;
    if ( x > sqX && x < sqX +sizeX && y > sqY && y < sqY +sizeY)
      result = true;
    else
      result = false;
    
    return result;
  }
  
  // fillFlagsのtrueかfalseの合計を返すメソッド
  int totalFillFlag(boolean[] fillFlags, boolean tf , int num){
    int number = 0;
    for(int i=0; i < num; i++){
      if(fillFlags[i] == tf)
        number ++;
    }
    return number;
  }
  
  // 番号がnumであるボールの数を返すメソッド
  int totalBallNum(Ball[] ball, int num ,int allBallNum){
    int number = 0;
    for(int i=0; i < allBallNum; i++){
      if(ball[i].getNum() == num)
        number ++;
    }
    return number;
  }
  
  // 以下getterとsetter
  int getNum(){
    return num;
  }
  boolean getFillFlag(){
    return fillFlag;
  }
  
}
