class Bat extends MeleeWeapon {
  
  Bat() {
    super(); 
    damage = 5;
  }
  
  void upgrade() {
    super.upgrade();
    damage += 5; 
  }
}