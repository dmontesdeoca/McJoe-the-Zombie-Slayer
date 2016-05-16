
class MeleeWeapon extends Weapon {
  
  protected boolean left, right;
  protected int attackFrame;
  
  MeleeWeapon( int weapon ) {
    super( weapon );
    left = false;
    right = false;
    attackFrame = 0;
  }
  
  void draw() {
     if ( state == BATTLE && attack ) {
       imageMode( CENTER );
       if ( right ) {
         rotate( PI / 30 );  
         if ( attackFrame == 30 ) {
           right = false;
           attack = false;
         }
       }
       else if ( left ) {
         scale( -1, 1 );
         translate( grid_size * -4, 0 );
         rotate( PI / -30 );
         if ( attackFrame == 30 ) {
           left = false;
           attack = false;
         }
       }
       super.draw();
     }
  }
  
  void attackRight() {
    right = true;
    left = false;
    attackFrame = 0;
    attack();
  }
  
  void attackLeft() {
    left = true;
    right = false;
    attackFrame = 0;
    attack();
  }
  
}