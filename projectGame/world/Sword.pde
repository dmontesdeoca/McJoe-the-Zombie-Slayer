
//Sword weapon which is also a MeleeWeapon
//Does has a chance to do critical damage
class Sword extends MeleeWeapon {
  
  //Calls super constructor
  //Initializes damage
  Sword() {
    super(); 
    damage = 2;
  }
  
  //Increases damage
  void upgrade() {
    super.upgrade();
    damage += 2;
  }
  
  //Gets damage from sword, which has a chance of adding on critical damage
  int getDamage() {
    return super.getDamage() + ( (int) random( 0, 2 ) == 0 ? 5 * (int) random( 1, exp + 1 ) : 0 );
  }
}