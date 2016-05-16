static final int COIN_GOAL = 5;
int COIN_COLLECTED = 0;

class Coin extends GameObject {
  private PImage coinImg;
  Coin(int x, int y) {
   super(); 
   pos = new PVector(x * grid_size,y * grid_size);
    coinImg = loadImage( "../Graphics/items/coins.png" );
  }
  
  void draw() {
    if ( state == DUNGEON ) {
      imageMode( CORNER );
      image( coinImg, pos.x, pos.y, grid_size, grid_size );
    }
  } 
}