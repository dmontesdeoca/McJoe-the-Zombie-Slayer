
class RangedWeapon extends Weapon {
 
   private ArrayList<Projectile> shotsFired;
   protected int speed;
  
  RangedWeapon() {
    super();
    shotsFired = new ArrayList<Projectile>();
    speed = grid_size;
  }
  
  void shoot( float x, float y ) {
     Projectile p = new Projectile( x, y, speed );
     p.reset( (int) pos.x, (int) pos.y );
     shotsFired.add( p );
  }
  
  void draw() {
     for(Projectile p : shotsFired) {
       p.draw(); 
     }
  }
}