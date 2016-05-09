class Player extends GameCharacter {

  //int d = grid_size;       // diameter of the player (McJoe)

  /** Player constructor **/
  Player( Map map ) {
    super( map, "2", loadImage("../Graphics/battle/bat.png") );
    //ellipseMode(CORNERS);
    
    this.map = map;
    pos = new PVector( 0, 0 ); // start bottom left corner
  }
  
} //Player class