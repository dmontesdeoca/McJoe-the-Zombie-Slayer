class Bat extends MeleeWeapon {
  
  Bat() {
    super( BAT ); 
  }
  
  void upgrade( int coins ) {
    super.upgrade( coins );
    damage += 20 * coins; 
  }
}