
class Sword extends MeleeWeapon {
  
  Sword() {
    super( SWORD ); 
    damage = 10;
  }
  
  void upgrade() {
    super.upgrade();
    damage += 10;
  }
  
  int getDamage() {
    return super.getDamage() + ( (int) random( 0, 2 ) == 0 ? 10 * (int) random( 1, exp + 1 ) : 0 );
  }
}