int WEAPON = 0;

class Player extends GameCharacter {
  
  Weapon weapon;
  int hitPoints;

  /** Player constructor **/
  
  Player( Map map ) {
    //default image for mcJoe is a bat
    super( map, "2", WEAPON );    
              
    //ellipseMode(CORNERS);
    
    this.map = map;
    this.weapon = new Sword();
    hitPoints = 100;
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
  
  void kick( int direction ) {
    super.kick( direction );
    if ( state == DUNGEON ) {
      map.setValue( ( int )( pos.x / grid_size ), ( int ) ( pos.y / grid_size ), "0" );
      switch( direction ) {
        case NORTH:
          if ( map.getValue( ( int )( pos.x / grid_size ), ( int ) ( ( pos.y - grid_size ) / grid_size ) ).equals( "4" ) ||
            map.getValue( ( int )( pos.x / grid_size ), ( int ) ( ( pos.y - grid_size ) / grid_size ) ).equals( "10" ) ) {
            pos.y -= grid_size;
          }
          break;
        case SOUTH:
          if ( map.getValue( ( int )( pos.x / grid_size ), ( int ) ( ( pos.y + grid_size ) / grid_size ) ).equals( "4" ) ||
            map.getValue( ( int )( pos.x / grid_size ), ( int ) ( ( pos.y + grid_size ) / grid_size ) ).equals( "10" ) ) {
            pos.y += grid_size;
          }
          break;
        case WEST:
          if ( map.getValue( ( int )( ( pos.x - grid_size ) / grid_size ), ( int )( pos.y / grid_size ) ).equals( "4" ) ||
            map.getValue( ( int )( ( pos.x - grid_size ) / grid_size ), ( int )( pos.y / grid_size ) ).equals( "10" )) {
            pos.x -= grid_size;
          }
          break;
        case EAST:
          if ( map.getValue( ( int )( ( pos.x + grid_size ) / grid_size ), ( int )( pos.y / grid_size ) ).equals( "4" ) ||
            map.getValue( ( int )( ( pos.x + grid_size ) / grid_size ), ( int )( pos.y / grid_size ) ).equals( "10" )) {
            pos.x += grid_size;
          }
          break;
      } // switch
      map.setValue( ( int )( pos.x / grid_size ), ( int ) ( pos.y / grid_size ), ID );
    }
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
  
  void levelUp() {
    hitPoints += 10; 
  }
  
} //Player class