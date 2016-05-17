class Bat extends MeleeWeapon {
  
  Bat() {
    super( BAT ); 
  }
  
  void upgrade() {
    super.upgrade();
    damage += 20; 
  }
}