
//Base class for all weapons in the game
class Weapon extends GameObject {
  
  protected boolean attack;
  protected int damage, exp;
  
  //Calls super constructor and initializes variable
  Weapon() {
    super(); 
    state = BATTLE;
    exp = 0;
    attack = false;
  }
  
  //To be implemented by sub classes
  void draw() {
  }
  
  //Sets attack to true
  void attack() {
    attack = true;
  }
  
  //Increase experience
  void upgrade() {
    exp++;
  }
  
  //Returns damage of the weapon
  int getDamage() {
    return damage;
  }
}