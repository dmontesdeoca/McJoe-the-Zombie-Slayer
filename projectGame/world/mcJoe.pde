int WEAPON = 0;

class Player extends GameCharacter {


  //int d = grid_size;       // diameter of the player (McJoe)
  Weapon weapon;

  /** Player constructor **/
<<<<<<< HEAD
  Player( Map map) {
=======
  Player( Map map ) {
>>>>>>> origin/master
    //default image for mcJoe is a bat
    super( map, "2", WEAPON );    
              
    //ellipseMode(CORNERS);
    
    this.map = map;
    this.weapon = new Sword();
    pos = new PVector( 0, 0 );
  }
  
  void draw() {
    if ( state == BATTLE ) {
      if ( !keyPressed && !jump && !fall) {
          vel.clear(); 
      }
    }
    super.draw();
    weapon.reset( (int) pos.x + grid_size, (int) pos.y + grid_size );
    weapon.draw();
  }
  
  void attack( float x, float y ) {
    if ( weapon instanceof MeleeWeapon ) {
      if ( x >= pos.x + grid_size ) {
        ( (MeleeWeapon) weapon ).attackRight();
      }
      else {
        ( (MeleeWeapon) weapon ).attackLeft();
      }
    }
    else {
       ( (RangedWeapon) weapon ).shoot( x, y );
    }
  }
  
} //Player class