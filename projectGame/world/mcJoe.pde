int WEAPON = 0;

class Player extends GameCharacter {


  //int d = grid_size;       // diameter of the player (McJoe)

  /** Player constructor **/
  Player( Map map ) {
    //default image for mcJoe is a bat
    super( map, "2", WEAPON );    
              
    //ellipseMode(CORNERS);
    
    this.map = map;
    pos = new PVector( 0, 0 );
  }
  
} //Player class