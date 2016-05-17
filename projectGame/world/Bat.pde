
//Bat weapon which is also a MeleeWeapon
//Does more damage than the sword
class Bat extends MeleeWeapon {
  
  //Calls super constructor
  //Initializes damage
  Bat() {
    super(); 
    damage = 5;
  }
  
  //Increases damage
  void upgrade() {
    super.upgrade();
    damage += 5; 
  }
} //Bat class