
class Weapon extends GameObject {
  
  protected PImage wpnImg;
  protected boolean attack;
  protected int damage, exp;
  
  Weapon( int weapon ) {
    super(); 
    switch ( weapon ) {
      case SWORD:
        wpnImg = loadImage( "../Graphics/weapons/sword.png" );
        break;
      case BOW:
        wpnImg = loadImage( "../Graphics/weapons/bow.png" );
        break;
      case GUN:
        wpnImg = loadImage( "../Graphics/weapons/gun.png" );
        break;
      case BAT:
        wpnImg = loadImage( "../Graphics/weapons/bat.png" );
        break;
    }
    
    exp = 0;
    attack = false;
  }
  
  void draw() {
    if ( state == BATTLE && attack ) {
      image( wpnImg, pos.x, pos.y, grid_size * 2, grid_size * 2 );
    }
  }
  
  void attack() {
    attack = true;
  }
  
  void upgrade( int coins ) {
    exp += coins;
  }
  
  int getDamage() {
    return damage;
  }
}