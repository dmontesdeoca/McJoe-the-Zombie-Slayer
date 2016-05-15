static final int SWORD = 1;
static final int BOW = 2;
static final int GUN = 3;
static final int BAT = 4;
static final int ZOMBIE_F = 5;
static final int ZOMBIE_M = 6;
static final int ZOMBIE_MF = 7;
static final int ZOMBIE_MM = 8;
static final int ZOMBIE_Q = 9;

class GameCharacter extends GameObject {
  protected Map map;
  protected String ID;
  protected PImage charImg;
  
  private boolean jump;
  private boolean fall;
  private PVector beforeJump;
  private ArrayList<Integer> vel;
  
  GameCharacter( Map map, String ID, /*PImage charImg*/ int character) {
    super();
    this.ID = ID;
    this.map = map;
    //this.charImg = charImg;
    fall = false;
    jump = false;
    beforeJump = new PVector();
    vel = new ArrayList<Integer>();
    chooseCharacter(character);
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
          vel.add( grid_size / -2 );
          break;
        case EAST:
          vel.add ( grid_size / 2 );
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
        if ( beforeJump.y - pos.y > 200 ) {
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
      
      if ( !keyPressed && !jump && !fall) {
        vel.clear(); 
      }
      
      if ( vel.size() > 0 ) {
        pos.x += vel.get( 0 );
        vel.remove( 0 );
      }
      
      if ( pos.x < 0 ) {
        pos.x = 0;
        vel.clear();
      }
      else if ( pos.x >= width ) {
        pos.x = width - grid_size * 2;
        vel.clear();
      }
    }
  } // draw()
  
  //choose the character
void chooseCharacter(int charImage){
    if(charImage == SWORD){
        charImg = loadImage("../Graphics/battle/sword.png");
    }
    else if(charImage == BOW){
             charImg = loadImage("../Graphics/battle/bowArrow.png");
    }
         else if(charImage == GUN){
                charImg = loadImage("../Graphics/battle/gun.png");
         }
          else if(charImage == BAT){
                  charImg = loadImage("../Graphics/battle/bat.png");
           }
                else if(charImage == ZOMBIE_F){
                        charImg = loadImage("../Graphics/battle/zombieFemale.png");
                }
                      else if(charImage == ZOMBIE_M){
                              charImg = loadImage("../Graphics/battle/zombieMale.png");
                      }
                            else if(charImage == ZOMBIE_MF){
                                    charImg = loadImage("../Graphics/battle/zombieFemaleM.png");
                            }
                                  else if(charImage == ZOMBIE_MM){
                                          charImg = loadImage("../Graphics/battle/zombieMaleM.png");
                                  }
                                        else if(charImage == ZOMBIE_Q){
                                                charImg = loadImage("../Graphics/battle/zombieQueen.png");
                                        }   
  }
}