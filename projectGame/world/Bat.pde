class Bat extends MeleeWeapon {
  
  Bat() {
    super(); 
  }
  
  void upgrade() {
    super.upgrade();
    damage += 10; 
  }
}