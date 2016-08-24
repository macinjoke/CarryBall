/* 
  Carry ball(ボールアクションゲーム)
  
  番号が書かれたボールを所定の場所まで運ぶのが目的のパズル感覚２Ｄアクションゲーム。
  ボールの動きは大きさ、重さ、空気抵抗、反発係数などを考慮しリアルな表現にしてある。
  rキーでタイトル画面に戻る。
  詳しい遊び方はタイトル画面のHOW TO PLAY に記載。
*/ 

StartScreen startScreen;

final float gravity = 0.3;   //重力
final float k = 0.4;           //空気抵抗比例定数(実際はこれに半径rをかける)
final float divM = 1;     //重さを調整するために割る値

void setup(){
  size(800,600);
  fill(0, 0, 0);          // 塗りつぶし初期値
  frameRate(60);
  startScreen = new StartScreen();
}

void draw(){
  background(255,255,255);
  startScreen.show();
  
}

void keyPressed(){
  if(key == 'r')
    startScreen = new StartScreen();
    
  startScreen.keyPressed(key, keyCode);
}

void keyReleased(){
  startScreen.keyReleased(key, keyCode);
}

void mousePressed() {
  startScreen.mousePressed();
}
void mouseReleased(){
  startScreen.mouseReleased();
}
  

