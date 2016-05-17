
class Sword extends MeleeWeapon {
  
  Sword() {
    super(); 
    damage = 2;
  }
  
  void upgrade() {
    super.upgrade();
    damage += 2;
  }
  
  int getDamage() {
    return super.getDamage() + ( (int) random( 0, 2 ) == 0 ? 5 * (int) random( 1, exp + 1 ) : 0 );
  }
}