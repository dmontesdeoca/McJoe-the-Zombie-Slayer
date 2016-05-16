
class Projectile extends GameObject {
  
  private PVector dest;
  private int speed;
  private float rotation;
  private PImage img;
  
  Projectile( float x, float y, int s ) {
    dest = new PVector();
    dest.x = x;
    dest.y = y;
    dest.normalize();
    speed = s;
  }
  
  void draw() {
    rectMode( CENTER );
    rotate( rotation );
    fill( 255 );
    rect( pos.x, pos.y, 20, 5 );
    
    pos.x += dest.x * speed;
    pos.y += dest.y * speed;
  }
  
}