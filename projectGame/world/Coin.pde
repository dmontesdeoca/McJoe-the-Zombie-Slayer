
class Coin extends GameObject {
  
  private PImage coinImg;
  
  Coin() {
    super(); 
    coinImg = loadImage( "../Graphics/items/coins.png" );
  }
  
  void draw() {
    if ( state == DUNGEON ) {
      imageMode( CORNER );
      image( coinImg, pos.x, pos.y, grid_size, grid_size );
    }
  }
  
}