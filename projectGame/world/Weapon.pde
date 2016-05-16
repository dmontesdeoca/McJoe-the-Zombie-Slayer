
class Weapon extends GameObject {
  
  protected PImage wpnImg;
  protected boolean attack;
  protected int damage, exp;
  
  Weapon( int weapon ) {
    super(); 
    state = BATTLE;
    exp = 0;
    attack = false;
  }
  
  void draw() {
  }
  
  void attack() {
    attack = true;
  }
  
  void upgrade( int coins ) {
    exp += coins;
  }
  
  int getDamage() {
    return damage;
  }
}