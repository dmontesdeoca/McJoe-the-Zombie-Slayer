static final int COIN_GOAL = 5;
int COIN_COLLECTED = 0;

//Coin class is a GameObject used for weapon upgrades
class Coin extends GameObject {
  private PImage coinImg;
  
  //Calls super constructor and initializes coin image and location
  Coin(int x, int y) {
   super(); 
   pos = new PVector(x * grid_size,y * grid_size);
   coinImg = loadImage( "../Graphics/items/coins.png" );
  }
  
  //Draws coin image during DUNGEON state
  void draw() {
    if ( state == DUNGEON ) {
      imageMode( CORNER );
      image( coinImg, pos.x, pos.y, grid_size, grid_size );
    }
  } 
} //Coin class