
//Class MeleeWeapon is a Weapon for close range combat
class MeleeWeapon extends Weapon {
  
  protected boolean left, right;
  protected int attackFrame;
  
  //Calls super constructor and initializes value
  MeleeWeapon() {
    super();
    left = false;
    right = false;
    attackFrame = 0;
  }
  
  //Draws area of attack from melee weapon when in BATTLE state
  void draw() {
     if ( state == BATTLE && attack ) {
       if ( right ) {
         stroke( 255 );
         curve( pos.x + grid_size * 2, pos.y - grid_size * 2, pos.x + grid_size * 3, pos.y - grid_size, pos.x + grid_size * 3, pos.y + grid_size, pos.x + grid_size * 2, pos.y + grid_size * 2 );
         line( pos.x, pos.y, pos.x + grid_size * 3, pos.y - grid_size + attackFrame * 10 );
         if ( attackFrame == 5 ) {
           right = false;
           attack = false;
         }
       }
       else if ( left ) {
         stroke( 255 );
         curve( pos.x - grid_size * 2, pos.y - grid_size * 2, pos.x - grid_size * 3, pos.y - grid_size, pos.x - grid_size * 3, pos.y + grid_size, pos.x - grid_size * 2, pos.y + grid_size * 2 );
         line( pos.x, pos.y, pos.x - grid_size * 3, pos.y - grid_size + attackFrame * 10 );
         if ( attackFrame == 5 ) {
           left = false;
           attack = false;
         }
       }
       attackFrame++;
       super.draw();
     }
  }
  
  //Prepares right attack
  void attackRight() {
    right = true;
    left = false;
    attackFrame = 0;
    attack();
  }
  
  //Prepares left attack
  void attackLeft() {
    left = true;
    right = false;
    attackFrame = 0;
    attack();
  }
  
}