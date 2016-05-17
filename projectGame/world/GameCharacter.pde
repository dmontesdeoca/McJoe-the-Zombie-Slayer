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
  
  protected boolean jump;
  protected boolean fall;
  protected boolean damaged;
  protected PVector beforeJump;
  protected ArrayList<Integer> vel;
  protected int hitPoints;
  protected int damageFrame;
  
  GameCharacter( Map map, String ID, int character) {
    super();
    this.ID = ID;
    this.map = map;
    //this.charImg = charImg;
    fall = false;
    jump = false;
    damaged = false;
    beforeJump = new PVector();
    vel = new ArrayList<Integer>();
    chooseCharacter(character);
  }
  
  void setMap( Map map ) {
    this.map = map;
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
    
    if ( damaged ) {
      tint( 255, 0, 0 ); 
      damageFrame++;
      if ( damageFrame >= 15 ) {
        damaged = false;
      }
    }
    
    imageMode(CORNER);
    image(charImg, pos.x, pos.y, ( state == DUNGEON ? grid_size : grid_size * 2 ), ( state == DUNGEON ? grid_size : grid_size * 2 ) );
    
    noTint();
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
        hitPoints = 100;
    }
    else if(charImage == BOW){
             charImg = loadImage("../Graphics/battle/bowArrow.png");
             hitPoints = 100;
    }
         else if(charImage == GUN){
                charImg = loadImage("../Graphics/battle/gun.png");
                hitPoints = 100;
         }
          else if(charImage == BAT){
                  charImg = loadImage("../Graphics/battle/bat.png");
                  hitPoints = 100;
           }
                else if(charImage == ZOMBIE_F){
                        charImg = loadImage("../Graphics/battle/zombieFemale.png");
                        hitPoints = 200;
                }
                      else if(charImage == ZOMBIE_M){
                              charImg = loadImage("../Graphics/battle/zombieMale.png");
                              hitPoints = 200;
                      }
                            else if(charImage == ZOMBIE_MF){
                                    charImg = loadImage("../Graphics/battle/zombieFemaleM.png");
                                    hitPoints = 300;
                            }
                                  else if(charImage == ZOMBIE_MM){
                                          charImg = loadImage("../Graphics/battle/zombieMaleM.png");
                                          hitPoints = 300;
                                  }
                                        else if(charImage == ZOMBIE_Q){
                                                charImg = loadImage("../Graphics/battle/zombieQueen.png");
                                                hitPoints = 400;
                                        }   
  }
  
  int getHitPoints() { return hitPoints; }
  void damage( int damage ) {
    hitPoints -= damage;
    damageFrame = 0;
    damaged = true;
  }
} // chooseCharacter()