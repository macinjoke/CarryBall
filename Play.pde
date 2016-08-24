/*
  プレイ中の処理
*/

class Play{
  
  Key[] keys;
  
  Player player;
  MouseBall[] mouseBall;
  Ball[] ball;
  Square[] square;
  Circle[] circle;
  Box[] box;
  
  int stage;
  int[][] squareMap;
  int[][] circleMap;
  int[][] ballMap;
  int[][] boxMap;
  
  int mouseBallNum;
  int mouseBallMax;
  int allBallNum;
  
  float mouseBallR;
  float mouseBallDR = 0.5;
  
  boolean backFlag;
  boolean nextFlag;
  boolean retryFlag;
  boolean congratsFlag;
  
  PImage titleBar3;
  PImage titleBar3on;
  PImage titleBar4;
  PImage titleBar4on;
  PImage titleBar5;
  PImage titleBar5on;
  PImage titleBar6;
  PImage titleBar6on;
  
  Play(int stage, int[][] squareMap, int[][] circleMap, int[][] ballMap, int[][] boxMap, int mouseBallMax){
    keys = new Key[8];
    keys[0] = new Key('w');
    keys[1] = new Key('s');
    keys[2] = new Key('a');
    keys[3] = new Key('d');
    keys[4] = new Key('y');
    keys[5] = new Key('u');
    keys[6] = new Key('i');
    keys[7] = new Key('o');
    
    titleBar3 = loadImage("title_bar_3.png");
    titleBar3on = loadImage("title_bar_3_on.png");
    titleBar4 = loadImage("title_bar_4.png");
    titleBar4on = loadImage("title_bar_4_on.png");
    titleBar5 = loadImage("title_bar_5.png");
    titleBar5on = loadImage("title_bar_5_on.png");
    titleBar6 = loadImage("title_bar_6.png");
    titleBar6on = loadImage("title_bar_6_on.png");
    
    this.stage = stage;
    
    this.mouseBallMax = mouseBallMax;
    
    mouseBall = new MouseBall[mouseBallMax];
    
    this.squareMap = squareMap;
    square = new Square[squareMap.length];
    for(int i=0; i < squareMap.length; i++)
      square[i] = new Square(squareMap[i][0], squareMap[i][1], squareMap[i][2],
                             squareMap[i][3], squareMap[i][4], squareMap[i][5] );
                             
    this.circleMap = circleMap;
    circle = new Circle[circleMap.length];
    for(int i=0; i < circleMap.length; i++)
      circle[i] = new Circle(circleMap[i][0], circleMap[i][1], circleMap[i][2], circleMap[i][3] );
      
    this.ballMap = ballMap;
    player = new Player(ballMap[0][0], ballMap[0][1], ballMap[0][2], ballMap[0][3], ballMap[0][4], ballMap[0][5] );
    ball = new Ball[ballMap.length + mouseBallMax];
    ball[0] = player;
    for(int i=1; i < ballMap.length; i++)
      ball[i] = new Ball(ballMap[i][0], ballMap[i][1], ballMap[i][2], ballMap[i][3], ballMap[i][4], ballMap[i][5] );
    
    this.boxMap = boxMap;
    box = new Box[boxMap.length];
    for(int i=0; i < boxMap.length; i++)
      box[i] = new Box(boxMap[i][0], boxMap[i][1], boxMap[i][2], boxMap[i][3], boxMap[i][4] );
      
  }
  
  
  void draw(){
    
    allBallNum = ballMap.length + mouseBallNum; //総ボールナンバー=初めからあるボール+マウスボール
    
    //プレイ中のキー入力による状態変化
    this.keyAction(keys);
    //自機のキーによる動き
    player.keyMove(keys, square);
    
    //ボールの処理
    for(int i=0; i < allBallNum ; i ++){//全てのボールに対して
      for( int j=0; j < square.length ; j++)//全ての四角に対して
        square[j].collision( ball[i] , i);
      for( int j=0; j < circle.length ; j++)//全ての円に対して
        circle[j].collision( ball[i] );
      
      if(totalFillFlag() != box.length)//クリアしてなかったら
        ball[i].move();
      ball[i].show();
      ball[i].collision( ball , i , allBallNum);
    
    }
    
    //四角と円の箱の表示処理
    for( int i=0; i < square.length ; i++){//全ての四角に対して
      square[i].show();
    }
    for( int i=0; i < circle.length ; i++){//全ての円に対して
      circle[i].show();
    }
    for( int i=0; i < box.length ; i++){//全ての箱に対して
      box[i].show();
      box[i].collision( ball , allBallNum );
    }
    
    //テキスト表示処理
    textSize(30);
    fill(0);
    textAlign(LEFT, CENTER);
    text( "Ball:" +(mouseBallMax -mouseBallNum), 700,10);
    
    //左クリックが押されている間の処理
    if(mousePressed && mouseButton == LEFT){
      mouseBallR += mouseBallDR;
      fill(0, 10);
      ellipse(mouseX, mouseY, mouseBallR*2, mouseBallR*2);
    }
    
    //ゲームクリア処理
    if(totalFillFlag() == box.length) {
      fill(0);
      textSize(35);
      textAlign(CENTER, CENTER);
      text("Clear!!", 400, 300);
      if(mouseX >= 50 && mouseX <= 250 && mouseY >= 540 && mouseY <= 580)
        image(titleBar3on,50,540);
      else
        image(titleBar3,50,540);
      if(stage == 6){
        if(mouseX >= 390 && mouseX <= 590 && mouseY >= 540 && mouseY <= 580)
          image(titleBar6on,390,540);
        else
          image(titleBar6,390,540);
      }
      else{
        if(mouseX >= 390 && mouseX <= 590 && mouseY >= 540 && mouseY <= 580)
          image(titleBar4on,390,540);
        else
          image(titleBar4,390,540);
      }
    }
    
    //ゲームオーバー処理
    else if( gameOver() ) {
      fill(0);
      textSize(35);
      textAlign(CENTER, CENTER);
      text("Game Over!!", 400, 300);
      
      if(mouseX >= 50 && mouseX <= 250 && mouseY >= 540 && mouseY <= 580)
        image(titleBar3on,50,540);
      else
        image(titleBar3,50,540);
      if(mouseX >= 390 && mouseX <= 590 && mouseY >= 540 && mouseY <= 580)
        image(titleBar5on,390,540);
      else
        image(titleBar5,390,540);
    }
    
    if(mouseX >= 710 && mouseX <= 790 && mouseY >= 575 && mouseY <= 595)
        image(titleBar5on,710, 575, 80, 20);
      else
        image(titleBar5,710, 575, 80, 20);
    
  }
  
  boolean gameOver(){
    int number = 0;
    for(int i=0; i< ballMap.length; i++)
      if( ball[i].getExitFlag() )
        number ++;
    if( number > 0)
      return true;
    else
      return false;
    
  }
  
  // 箱のfillFlagのtrueの合計を返すメソッド
  int totalFillFlag(){
    int number = 0;
    for(int i=0; i < box.length; i++){
      if( box[i].getFillFlag() )
        number ++;
    }
    return number;
  }
  
  //２つの円の当たり判定の結果を返すメソッド
  boolean twoCircleMatch(float x1, float y1, float r1, float x2, float y2, float r2){
    boolean result;
    float distance = sqrt( sq(x1-x2) + sq(y1-y2) );
    if ( distance < r1 + r2)
      result = true;
    else
      result = false;
    
    return result;
  }
  
  //点と四角形の当たり判定の結果を返すメソッド
  boolean pointSquareMatch(float x, float y, float sqX, float sqY, float sizeX, float sizeY){
    if( x > sqX && x < sqX + sizeX && y > sqY && y < sqY +sizeY)
      return true;
    else
      return false;
  }
  //円とマップ上の物体すべてとの当たり判定の結果を返すメソッド
  boolean manyMatch( float x, float y, float r, Ball[] ball){
    
    boolean result;
    int number = 0;
    for(int i=0; i< allBallNum; i++){
      if( this.twoCircleMatch( x, y, r, ball[i].getX(), ball[i].getY(), ball[i].getR() ) )
        number ++;
    }
    for(int i=0; i< circleMap.length; i++){
      if( this.twoCircleMatch( x, y, r, circle[i].getX(), circle[i].getY(), circle[i].getR() ) )
        number ++;
    }
    for(int i=0; i< squareMap.length; i++){
      if( this.twoCircleMatch( x, y, r,
            square[i].getX() +square[i].getR(),
            square[i].getY() +square[i].getR(), square[i].getR() ) 
       || this.twoCircleMatch( x, y, r,
            square[i].getX() -square[i].getR() +square[i].getSizeX(),
            square[i].getY() +square[i].getR(), square[i].getR() ) 
       || this.twoCircleMatch( x, y, r,
            square[i].getX() +square[i].getR(),
            square[i].getY() -square[i].getR() +square[i].getSizeY(), square[i].getR() ) 
       || this.twoCircleMatch( x, y, r,
            square[i].getX() -square[i].getR() +square[i].getSizeX(),
            square[i].getY() -square[i].getR() +square[i].getSizeY(), square[i].getR() )
            
       || this.pointSquareMatch( x +r, y, square[i].getX(), square[i].getY(), square[i].getSizeX(), square[i].getSizeY() )
       || this.pointSquareMatch( x, y +r, square[i].getX(), square[i].getY(), square[i].getSizeX(), square[i].getSizeY() )
       || this.pointSquareMatch( x -r, y, square[i].getX(), square[i].getY(), square[i].getSizeX(), square[i].getSizeY() )
       || this.pointSquareMatch( x, y -r, square[i].getX(), square[i].getY(), square[i].getSizeX(), square[i].getSizeY() )
       || (x -r > square[i].getX() && x +r < square[i].getX() + square[i].getSizeX() 
        && y -r < square[i].getY() && y +r > square[i].getY() + square[i].getSizeY() )
       || (x -r < square[i].getX() && x +r > square[i].getX() + square[i].getSizeX() 
        && y -r > square[i].getY() && y +r < square[i].getY() + square[i].getSizeY() )
      )
        number ++;
    }
    if(number > 0)
      return true;
    else
      return false;
    
  }
    
  void mousePressed(){
    
    //右クリック処理(ボールを消す)
    if(mouseButton == RIGHT){
      for(int i=0; i < mouseBallNum ; i++){//全てのマウスボールに対して
        if( twoCircleMatch( mouseX, mouseY, 0,
            mouseBall[i].getX(), mouseBall[i].getY(), mouseBall[i].getR() ) ){
          mouseBall[i] = new MouseBall(0,999,0,0,0);
          ball[ballMap.length + i] = mouseBall[i];
        }
      }
    }
    
    
    //リトライ
    if(mouseX >= 710 && mouseX <= 790 && mouseY >= 575 && mouseY <= 595)
      retryFlag = true;
    
    //ゲーム終了後の処理
    if(totalFillFlag() == box.length){//クリアしていたら
      if(mouseX >= 20 && mouseX <= 220 && mouseY >= 540 && mouseY <= 580)
        backFlag = true;
      if(mouseX >= 390 && mouseX <= 590 && mouseY >= 540 && mouseY <= 580){
        if(stage == 6)
          congratsFlag = true;
        else
          nextFlag = true;
      }
    }
    else if( gameOver() ) {//ゲームオーバーしてたら
      if(mouseX >= 20 && mouseX <= 220 && mouseY >= 540 && mouseY <= 580)
        backFlag = true;
      if(mouseX >= 390 && mouseX <= 590 && mouseY >= 540 && mouseY <= 580)
        retryFlag = true;
    }
    
  }
  
  void mouseReleased(){
    
    if(mouseButton == LEFT){
      if(mouseBallNum < mouseBallMax && this.manyMatch(mouseX, mouseY, mouseBallR, ball ) == false ){
        
        mouseBall[mouseBallNum] = new MouseBall(mouseX, mouseY, int(mouseBallR), 8, 1);
        ball[allBallNum] = mouseBall[mouseBallNum];
        mouseBallNum++;
      }
      mouseBallR = 0;
    }
    
  }
  
    
  //プレイ中のキー入力による状態変化
  void keyAction(Key[] keys){
    
    /*
    if( keys[4].getIsPressed() )
      frameRate(1);
    if( keys[5].getIsPressed() )
      frameRate(2);
    if( keys[6].getIsPressed() )
      frameRate(4);
    if( keys[7].getIsPressed() )
      frameRate(60);
    */
  
  }
  
  //キーの入力情報をキーオブジェクトに渡す
  void keyPressed(char tempKey, int tempKeyCode) {
    // 全キーに引数で指定されたキーが押されたことを通知
    for (int i = 0; i < keys.length; i++) {
      keys[i].pressed(tempKey, tempKeyCode);
    }
  }
  void keyReleased(char tempKey, int tempKeyCode) {
    // 全キーに引数で指定されたキーが離されたことを通知
    for (int i = 0; i < keys.length; i++) {
      keys[i].released(tempKey, tempKeyCode);
    }
  }
  
  //　以下getter
  boolean getBackFlag(){
    return backFlag;
  }
  boolean getNextFlag(){
    return nextFlag;
  }
  boolean getRetryFlag(){
    return retryFlag;
  }
  boolean getCongratsFlag(){
    return congratsFlag;
  }
  
  
}
