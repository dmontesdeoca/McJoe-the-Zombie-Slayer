
class Sword extends MeleeWeapon {
  
  Sword() {
    super( SWORD ); 
    damage = 10;
  }
  
  void upgrade( int coins ) {
    super.upgrade( coins );
    damage += 10 * coins;
  }
  
  int getDamage() {
    return super.getDamage() + ( (int) random( 0, 2 ) == 0 ? 10 * (int) random( 1, exp + 1 ) : 0 );
  }
}