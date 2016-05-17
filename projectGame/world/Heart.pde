
//Coin class is a GameObject used for mcJoe health replenishment
class Heart extends GameObject {
  private PImage heartImg;
  
  //Calls super constructor and initializes heart image and location
  Heart(int x, int y) {
   super(); 
   pos = new PVector(x * grid_size,y * grid_size);
    heartImg = loadImage( "../Graphics/items/heart.png" );
  }
  
  //Draws heart image during DUNGEON state
  void draw() {
    if ( state == DUNGEON ) {
      imageMode( CORNER );
      image( heartImg, pos.x, pos.y, grid_size, grid_size );
    }
  } 
} //Heart class