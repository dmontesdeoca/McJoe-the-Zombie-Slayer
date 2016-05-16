
class RangedWeapon extends Weapon {
 
   private ArrayList<Projectile> shotsFired;
   protected int speed;
  
  RangedWeapon( int weapon ) {
    super( weapon );
    shotsFired = new ArrayList<Projectile>();
    speed = 5;
  }
  
  void shoot( float x, float y ) {
     shotsFired.add( new Projectile( x, y, speed ) );
  }
}