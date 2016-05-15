static final int NORTH = 0;
static final int WEST  = 1;
static final int SOUTH = 2;
static final int EAST  = 3;
static final int grid_size = 28;         //  20,  28,  40
static final int WIDTH = 700;            // 500, 700, 1000  when changing size make sure to change size() in setup
static final int LENGTH = 700;           // 500, 700, 1000  
PImage screen;

int frame = 0;

boolean running; // flag set to true while the game is running
Player mcJoe; // player (human)
Zombie zombie;
Zombie zombieF;
Zombie zombieMM;
Zombie zombieMF;
Zombie zombieQ;
/*static final int ZOMBIE_F = 5;
static final int ZOMBIE_M = 6;
static final int ZOMBIE_MF = 7;
static final int ZOMBIE_MM = 8;
static final int ZOMBIE_Q = 9*/

Map map;
Hole hole;
int state;

//for the main screen buttons 
int swordX, swordY, bowX, bowY, gunX, gunY, batX, batY;  // position of the buttons
int buttonSize = WIDTH / 5;     // diameter of button
color swordColor, bowColor, gunColor, batColor;
color highLight;
boolean sword = false;
boolean bow = false;
boolean gun = false;
boolean bat = false;
boolean weaponPicked = false;


void setup() {
  frameRate( 30 );
  size( 700, 700);
  state = MAIN;
  running = true;
  setWorld(); // here set the main page, create the buttons
} // setup()

void draw() {
  if ( running ) {
    
    if( state == MAIN ){
       updateMouse(mouseX, mouseY);
      if(weaponPicked){ // if a weapon was clicked set state to dungeon and set world accordingly
        state = DUNGEON;
        setWorld(); // set world as dungeon
      }
    }
    else if ( state == DUNGEON ) {
      // make a function to call accordingly
      checkCollision();
      drawWorld();
      mcJoe.draw();
      zombie.checkSight(mcJoe.getPos()); // checks if it is int the line of sight if it it will move towards mcjoe
      zombie.draw();
      hole.draw();
      //end of the change
      frame++;
    }
    else if ( state == BATTLE ){
        imageMode(CORNERS);
        image(screen, 0, 0, WIDTH, LENGTH);
        mcJoe.draw();
        zombie.draw();
        hole.draw();
        frame++;
    }
  }
} // draw()

/** this function is called when the user releases a key.
    the arrow keys act like giving the player (mcJoe) a kick in the direction of the arrow.
     and when q or Q is pressed it will quit the game **/

void keyReleased() {
  if ( state == DUNGEON ) {
    if ( key == CODED ) {
      switch ( keyCode ) {
      case UP:
        mcJoe.kick( NORTH );
        break;
      case DOWN:
        mcJoe.kick( SOUTH );
        break;
      case LEFT:
        mcJoe.kick( WEST );
        break;
      case RIGHT:
        mcJoe.kick( EAST );
        break;
      }
    }
    else if (( key == 'q' ) || ( key == 'Q' )) {
      exit();
    }
  }
} // keyReleased()

void keyPressed() {
  if ( state == BATTLE ) {
      if ( key == CODED ) {
        switch ( keyCode ) {
        case UP:
          mcJoe.kick( NORTH );
          break;
        case DOWN:
          mcJoe.kick( SOUTH );
          break;
        case LEFT:
          mcJoe.kick( WEST );
          break;
        case RIGHT:
          mcJoe.kick( EAST );
          break;
        }
      }
      else if (( key == 'q' ) || ( key == 'Q' )) {
        exit();
      }
  }
}

/** set obstacles **/ // call when the image is clicked
void setWorld(){ 
  if(state == MAIN){
         screen = loadImage( "../Graphics/mainScreen.png" );
         imageMode(CORNERS);
         image(screen, 0, 0, WIDTH, LENGTH);
         createButtons();
  }
  if(state == DUNGEON){
  map = new Map();
  hole = new Hole();
  running = true;
  map.read();
  
  //here make a function to do it accordingly to each level
  mcJoe = new Player( map );
  zombie = new Zombie( map );
    screen = loadImage( "../Graphics/map/mapOne.jpg" );
    for ( int x = 0; x < map.getMaxX(); x++ ) {
      for ( int y = 0; y < map.getMaxY(); y++ ) {
        String value = map.getValue( x, y );
        switch ( value ) {
          /*
          case "1":
            obstacles.add( new PVector( x * grid_size, y * grid_size ) );
            break;
          */
          case "2":
            mcJoe.reset( x * grid_size, y * grid_size );
            break;
          case "3":
            hole.reset( x * grid_size, y * grid_size );
            break;
          case "6":
            zombie.reset( x * grid_size, y * grid_size );
            break;
        }
      }
    }
  }
  
} // setWorld()

void setBattle() {
  state = BATTLE;
  screen = loadImage( "../Graphics/battle/battle.png" );
  mcJoe.setState( BATTLE );
  zombie.setState( BATTLE );
  hole.setState( BATTLE );
  
 /* mcJoe.reset( 125 * 2, 400 * 2 ); 
  zombie.reset( 375 * 2, 400 *2 );*/
  
  mcJoe.reset( WIDTH/4, WIDTH - (WIDTH/5) );
  zombie.reset( (WIDTH/4)*3, WIDTH - (WIDTH/5) );
  
}

void drawWorld(){
    imageMode(CORNERS);
    image(screen, 0, 0, WIDTH, LENGTH); 
} // drawWorld()

void checkCollision() {
  
  for ( int direction = 0; direction < 4; direction++ ) { // change so it can check if it is all the zombies and the queen
    switch( direction ) {
      case NORTH:
        if ( map.getValue( ( int )( mcJoe.getPos().x / grid_size ), ( int ) ( ( mcJoe.getPos().y - grid_size ) / grid_size ) ).equals( "6" ) ) {
          setBattle();
          return;
        }
        break;
      case SOUTH:
        if ( map.getValue( ( int )( mcJoe.getPos().x / grid_size ), ( int ) ( ( mcJoe.getPos().y + grid_size ) / grid_size ) ).equals( "6" ) ) {
          setBattle();
          return;
        }
        break;
      case WEST:
        if ( map.getValue( ( int )( ( mcJoe.getPos().x - grid_size ) / grid_size ), ( int )( mcJoe.getPos().y / grid_size ) ).equals( "6" ) ) {
          setBattle();
          return;
        }
        break;
      case EAST:
        if ( map.getValue( ( int )( ( mcJoe.getPos().x + grid_size ) / grid_size ), ( int )( mcJoe.getPos().y / grid_size ) ).equals( "6" ) ) {
          setBattle();
          return;
        }
        break;
      } // switch 
  }
  
}

// create the buttons for the weapons
void createButtons(){
  //highLight = color(100);  // change to red maybe?
  //swordColor = color(255); // replace to image
  //bowColor = color(255); // replace to image
  //gunColor = color(255); // replace to image
  //batColor = color(255); // replace to image

  // set coor for the buttons
  swordX = grid_size;
  swordY = width - buttonSize - (grid_size*3);
  bowX = buttonSize + (grid_size*2);
  bowY = width - buttonSize - (grid_size*3);
  gunX = (buttonSize*2) + (grid_size*3);
  gunY = width - buttonSize - (grid_size*3);
  batX = WIDTH - buttonSize - grid_size;
  batY = width - buttonSize - (grid_size*3);
}

void updateMouse(int x, int y) {
  buttonHighLight(); // highlights if the mouse is over button
  
  if( overButton(swordX, swordY, buttonSize, buttonSize) ){ // pass sword coor
        sword = true;
        bow = false;
        gun = false;
        bat = false;
  }
  else if( overButton(bowX, bowY, buttonSize, buttonSize) ){ // pass bow coor
        sword = false;
        bow = true;
        gun = false;
        bat = false;
  }
        else if( overButton(gunX, gunY, buttonSize, buttonSize) ){ // pass gun coor
              sword = false;
              bow = false;
              gun = true;
              bat = false;
        } 
              else if( overButton(batX, batY, buttonSize, buttonSize) ){ // pass bat coor
                    sword = false;
                    bow = false;
                    gun = false;
                    bat = true;
              } 
                  else { sword = bow = gun = bat = false; }
}

//pass coordinates of buttons
boolean overButton(int x, int y, int width, int height)  {
  if(mouseX >= x && mouseX <= x+width && mouseY >= y && mouseY <= y+height){
    return true;
  } 
  else { return false; }
}

// depending where the mouse was pressed the weapon would be choosen
// weapon is picked so make it true
void mousePressed() {
  if(sword){
    weaponPicked = true;
    WEAPON = SWORD; // assign mcjoes weapon to sword
  }
  if(bow){
        weaponPicked = true;
        WEAPON = BOW; // assign mcjoes weapon to bow

  }
  if(gun){
        weaponPicked = true;
        WEAPON = GUN; // assign mcjoes weapon to gun
  }
  if(bat){
        weaponPicked = true;
        WEAPON = BAT; // assign mcjoes weapon to bat
  }
}

void buttonHighLight(){
  //put in a function called highlight button
      if (sword){
        noFill();
        strokeWeight(7);
        stroke(199, 149, 42);
      } 
      else{
        noFill();
        strokeWeight(7);
        stroke(0);
      }
      rect(swordX, swordY, buttonSize, buttonSize);
  
      if (bow){
        noFill();
        strokeWeight(7);
        stroke(199, 149, 42);
      } 
      else{
        noFill();
        strokeWeight(7);
        stroke(0);
      }
      rect(bowX, bowY, buttonSize, buttonSize);
      
      if (gun){
        noFill();
        strokeWeight(7);
        stroke(199, 149, 42);
      } 
      else{
        noFill();
        strokeWeight(7);
        stroke(0);
      }
      rect(gunX, gunY, buttonSize, buttonSize);
      
      if (bat) {
        noFill();
        strokeWeight(7);
        stroke(199, 149, 42);
      } 
      else{
        noFill();
        strokeWeight(7);
        stroke(0);
      }
      rect(batX, batY, buttonSize, buttonSize);
}
    