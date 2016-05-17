static final String ZOM_F = "5";
static final String ZOM_M = "6";
static final String ZOM_MF = "7";
static final String ZOM_MM = "8";
static final String ZOM_Q = "9";

//Enemy class of this game
class Zombie extends GameCharacter {
  String move;
  boolean inSight = false;
  PVector mcJoeLocation; // mcJoes current location
  
  //Calls super constructor
  Zombie( Map map , int typeZombie, String zombieKind) {
    super( map, zombieKind, typeZombie );
  }
  
  //Class super class's draw function adding AI to the zombie agents
  void draw() {
     super.draw();
     
     if ( state == BATTLE && pos.dist( mcJoeLocation, pos ) > grid_size ) {
       if ( !damaged ) {
         chase();
       }
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
  } 
  
  //Makes a random move in any of 4 directions
  void makeRandomMove() { 
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
        
  } // checkSight()
  
  
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
    
  } // chase()
} // class Zombie