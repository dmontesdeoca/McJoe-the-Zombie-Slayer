
class Projectile extends GameObject {
  
  private PVector dest;
  private int speed;
  private float rotation;
  
  Projectile( float x, float y, int s ) {
    dest = new PVector();
    dest.x = x;
    dest.y = y;
    dest.normalize();
    speed = s;
    rotation = dest.angleBetween( new PVector( 0, 1 ), dest );
  }
  
  void draw() {
    rotate( rotation );
    
    //imageMode( CENTER );
    
    pos.x += dest.x * speed;
    pos.y += dest.y * speed;
  }
  
}