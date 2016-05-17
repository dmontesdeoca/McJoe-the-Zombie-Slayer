
class Weapon extends GameObject {
  
  protected boolean attack;
  protected int damage, exp;
  
  Weapon() {
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
  
  void upgrade() {
    exp++;
  }
  
  int getDamage() {
    return damage;
  }
}