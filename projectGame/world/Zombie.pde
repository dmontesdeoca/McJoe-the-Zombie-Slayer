static final String ZOM_F = "5";
static final String ZOM_M = "6";
static final String ZOM_MF = "7";
static final String ZOM_MM = "8";
static final String ZOM_Q = "9";

class Zombie extends GameCharacter {
  String move;
  boolean inSight = false;
  PVector mcJoeLocation; // mcJoes current location
  
  Zombie( Map map , int typeZombie, String zombieKind) {
    super( map, zombieKind, typeZombie );
    pos = new PVector( 0, 0 ); // start bottom left corner
  }
  
  void draw() {
     super.draw();
     
     if ( state == BATTLE && pos.dist( mcJoeLocation, pos ) > grid_size * 3 ) {
       chase(); 
     }
     else if ( state == DUNGEON ) {
       if ( frame % 10 == 0 ) {
           if(inSight){
               chase();
           }
           else{
                makeRandomMove();         
           }
       }
    }
  } // draw()
  
  void makeRandomMove() { // call make move in the world
    int direction = ( int ) random( 0, 4 );
    
    super.kick( direction );
  }


  void checkSight(PVector location){
    mcJoeLocation = new PVector(location.x, location.y);
     if((mcJoeLocation.x > pos.x - (grid_size * 7) && mcJoeLocation.x < pos.x + (grid_size * 7))  && 
        (mcJoeLocation.y > pos.y - (grid_size * 7) && mcJoeLocation.y < pos.y + (grid_size * 7)) ){ 
       inSight = true;
     }
     else
        inSight = false;
        
  }
  
  
 // if mcJoe is in the zombies sight, the zombie will chase mcJoe
  void chase(){
    // here move accordingly to mcJoes current location
    if(mcJoeLocation.x < pos.x){
      super.kick( WEST );
    }
    if(mcJoeLocation.x > pos.x){
      super.kick( EAST );
    }
    if(mcJoeLocation.y < pos.y){
      super.kick( NORTH );
    }
    if(mcJoeLocation.y > pos.y){
      super.kick( SOUTH );
    }
    
  }
}