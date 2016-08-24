/*
  キーの状態を管理
*/
class Key {
  
  char key; // keyの値
  int keyCode; // keyCodeの値
  boolean isPressed; // 押されているか否か

  // コンストラクタ
  Key(char tempKey, int tempKeyCode) {
    key = tempKey;
    keyCode = tempKeyCode;
    isPressed = false;
  }
  
  Key(char tempKey){
    this(tempKey, 0);
  }
  Key(int tempKeyCode){
    this((char)CODED, tempKeyCode);
  }

  // 引数で指定されたキーと一致するかどうかを判定
  boolean equals(char tempKey, int tempKeyCode) {
    if (tempKey != CODED) {
      if (key == tempKey) {
        return true;
      } else {
        return false;
      }
    } else {
      if (keyCode == tempKeyCode) {
        return true;
      } else {
        return false;
      }
    }
  }

  // 引数で指定されたキーが押された
  void pressed(char tempKey, int tempKeyCode) {
    if (equals(tempKey, tempKeyCode) == true) {
      isPressed = true;
    }
  }

  // 引数で指定されたキーが離された
  void released(char tempKey, int tempKeyCode) {
    if (equals(tempKey, tempKeyCode) == true) {
      isPressed = false;
    }
  }
  
  boolean getIsPressed(){
    return isPressed;
  }
  
}
