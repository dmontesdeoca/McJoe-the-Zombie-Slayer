class Heart extends GameObject {
  private PImage heartImg;
  Heart(int x, int y) {
   super(); 
   pos = new PVector(x * grid_size,y * grid_size);
    heartImg = loadImage( "../Graphics/items/heart.png" );
  }
  
  void draw() {
    if ( state == DUNGEON ) {
      imageMode( CORNER );
      image( heartImg, pos.x, pos.y, grid_size, grid_size );
    }
  } 
} // class Heart