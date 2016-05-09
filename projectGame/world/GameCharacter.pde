
class GameCharacter extends GameObject {
  protected Map map;
  protected String ID;
  protected PImage charImg;
  
  private boolean jump;
  private boolean fall;
  private PVector beforeJump;
  private PVector vel;
  
  GameCharacter( Map map, String ID, PImage charImg ) {
    super();
    this.ID = ID;
    this.map = map;
    this.charImg = charImg;
    fall = false;
    jump = false;
    beforeJump = new PVector();
    vel = new PVector();
  }
  
  void kick( int direction ) {
    if ( state == DUNGEON ) {
      map.setValue( ( int )( pos.x / grid_size ), ( int ) ( pos.y / grid_size ), "0" );
      switch( direction ) {
        case NORTH:
          if ( map.getValue( ( int )( pos.x / grid_size ), ( int ) ( ( pos.y - grid_size ) / grid_size ) ).equals( "0" ) ) {
            pos.y -= grid_size;
          }
          break;
        case SOUTH:
          if ( map.getValue( ( int )( pos.x / grid_size ), ( int ) ( ( pos.y + grid_size ) / grid_size ) ).equals( "0" ) ) {
            pos.y += grid_size;
          }
          break;
        case WEST:
          if ( map.getValue( ( int )( ( pos.x - grid_size ) / grid_size ), ( int )( pos.y / grid_size ) ).equals( "0" ) ) {
            pos.x -= grid_size;
          }
          break;
        case EAST:
          if ( map.getValue( ( int )( ( pos.x + grid_size ) / grid_size ), ( int )( pos.y / grid_size ) ).equals( "0" ) ) {
            pos.x += grid_size;
          }
          break;
      } // switch
      map.setValue( ( int )( pos.x / grid_size ), ( int ) ( pos.y / grid_size ), ID );
    }
    else {
      switch( direction ) {
        case NORTH:
          if ( !jump && !fall ) {
            jump = true;
            beforeJump.y = pos.y;
          }
          break;
        case SOUTH:
          //jump.y += grid_size * 4;
          break;
        case WEST:
          vel.x -= grid_size / 2;
          break;
        case EAST:
          vel.x += grid_size / 2;
          break;
        } // switch
    }
  }
  
  String getID() { return ID; }
  
  void draw() {
    
    imageMode(CORNER);
    image(charImg, pos.x, pos.y, ( state == DUNGEON ? grid_size : grid_size * 2 ), ( state == DUNGEON ? grid_size : grid_size * 2 ) );
    
    if ( state == BATTLE ) {
      if ( jump ) {
        pos.y -= grid_size / 2;
        if ( beforeJump.y - pos.y > 150 ) {
          jump = false;
          fall = true;
        }
      }
      else if ( fall ) {
         pos.y += grid_size / 2;
         if ( beforeJump.y <= pos.y ) {
           pos.y = beforeJump.y;
           fall = false;
         }
      }
      //if ( keyPressed ) {
        pos.x += vel.x;
      //}
      
      if ( pos.x < 0 ) {
        pos.x = 0;
        vel.x = 0;
      }
      else if ( pos.x >= width ) {
        pos.x = width - grid_size * 2;
        vel.x = 0;
      }
    }
  } // draw()
}