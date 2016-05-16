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


Map map;
Hole hole;
int state;

//for the main screen buttons 
int swordX, swordY, bowX, bowY, gunX, gunY, batX, batY;  // position of the buttons
int buttonSize = WIDTH / 5;     // diameter of button
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
  // TEST make sure
  if ( running ) {
      // TEST make sure
   /* if(frame == 300 || frame == 600 || frame == 900 || frame == 1200){
      CURRENTSTATE++;
      setWorld();
    }*/
    if( state == MAIN ){
       updateMouse(mouseX, mouseY);
      if(weaponPicked){ // if a weapon was clicked set state to dungeon and set world accordingly
        state = DUNGEON;
        setWorld(); // set world as dungeon
      }
    }
    else if ( state == DUNGEON ) {
      checkCollision();
      drawWorld();
      // make a function to call accordingly
      drawLevel();
      /*mcJoe.draw();
      zombie.checkSight(mcJoe.getPos()); // checks if it is int the line of sight if it it will move towards mcjoe
      zombieF.checkSight(mcJoe.getPos()); // checks if it is int the line of sight if it it will move towards mcjoe
      
      zombie.draw();
      zombieF.draw();
      hole.draw();*/
      //end of the change
      frame++;
    }
    else if ( state == BATTLE ){
        imageMode(CORNERS);
        image(screen, 0, 0, WIDTH, LENGTH);
        
        drawLevel();
        /*
        //MAKE FUNCTION ACCORDINGLY
        mcJoe.draw();
        zombie.draw();
        // CHECK
        zombieF.draw();
        hole.draw();*/
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
    else {
      switch ( key ) {
        case 'w':
          mcJoe.kick( NORTH );
          break;
        case 'W':
          mcJoe.kick( NORTH );
          break;
        case 's':
          mcJoe.kick( SOUTH );
          break;
        case 'S':
          mcJoe.kick( SOUTH );
          break;
        case 'a':
          mcJoe.kick( WEST );
          break;
        case 'A':
          mcJoe.kick( WEST );
          break;
        case 'd':
          mcJoe.kick( EAST );
          break;
        case 'D':
          mcJoe.kick( EAST );
          break;
        case 'q':
          exit();
          break;
        case 'Q':
          exit();
          break;
      }
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
    else {
      switch ( key ) {
        case 'w':
          mcJoe.kick( NORTH );
          break;
        case 'W':
          mcJoe.kick( NORTH );
          break;
        case 's':
          mcJoe.kick( SOUTH );
          break;
        case 'S':
          mcJoe.kick( SOUTH );
          break;
        case 'a':
          mcJoe.kick( WEST );
          break;
        case 'A':
          mcJoe.kick( WEST );
          break;
        case 'd':
          mcJoe.kick( EAST );
          break;
        case 'D':
          mcJoe.kick( EAST );
          break;
        case 'q':
          exit();
          break;
        case 'Q':
          exit();
          break;
      }
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
    dungeonLevel();
    /*mcJoe = new Player( map );
    zombie = new Zombie( map, ZOMBIE_M, ZOM_M);
    // check
    zombieF = new Zombie( map, ZOMBIE_F, ZOM_F);*/


// make a function draw map draws depending on the current state
    if(CURRENTSTATE == 0 ||CURRENTSTATE == 1 || CURRENTSTATE == 2 || CURRENTSTATE == 3 || CURRENTSTATE == 4){
      screen = loadImage( "../Graphics/map/mapOne.jpg" );
    }
    
      for ( int x = 0; x < map.getMaxX(); x++ ) {
        for ( int y = 0; y < map.getMaxY(); y++ ) {
          String value = map.getValue( x, y );
          switch ( value ) { // create one for each level
            case "2":
              mcJoe.reset( x * grid_size, y * grid_size );
              break;
            case "3":
              hole.reset( x * grid_size, y * grid_size );
              break;
            case "5":
              zombieF.reset( x * grid_size, y * grid_size );
              break;
            case "6":
              zombie.reset( x * grid_size, y * grid_size );
              break;
            case "7":
              zombieMF.reset( x * grid_size, y * grid_size );
              break;
            case "8":
              zombieMM.reset( x * grid_size, y * grid_size );
              break;
            case "9":
              zombieQ.reset( x * grid_size, y * grid_size );
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
  
  // for zombie creat a zombiefunction depending on each level
  if(CURRENTSTATE == 0){
    zombie.setState( BATTLE );
    zombieF.setState( BATTLE );
    hole.setState( BATTLE );
  
    mcJoe.reset( WIDTH/4, WIDTH - (WIDTH/5) );
    zombie.reset( (WIDTH/4)*2, WIDTH - (WIDTH/5) );
    zombieF.reset( (WIDTH/4)*4, WIDTH - (WIDTH/5) );
  }
  else if(CURRENTSTATE == 3){
    zombieMM.setState( BATTLE );
    zombieMF.setState( BATTLE );
    hole.setState( BATTLE );
  
    mcJoe.reset( WIDTH/4, WIDTH - (WIDTH/5) );
    zombieMM.reset( (WIDTH/4)*2, WIDTH - (WIDTH/5) );
    zombieMF.reset( (WIDTH/4)*3, WIDTH - (WIDTH/5) );
  }
  else if(CURRENTSTATE == 2){
    zombie.setState( BATTLE );
    zombieMF.setState( BATTLE );
    hole.setState( BATTLE );
  
    mcJoe.reset( WIDTH/4, WIDTH - (WIDTH/5) );
    zombie.reset( (WIDTH/4)*2, WIDTH - (WIDTH/5) );
    zombieMF.reset( (WIDTH/4)*3, WIDTH - (WIDTH/5) );
  }
  else if(CURRENTSTATE == 1){
    zombieF.setState( BATTLE );
    zombieMM.setState( BATTLE );
    hole.setState( BATTLE );
    
    mcJoe.reset( WIDTH/4, WIDTH - (WIDTH/5) );
    zombieF.reset( (WIDTH/4)*2, WIDTH - (WIDTH/5) );
    zombieMM.reset( (WIDTH/4)*3, WIDTH - (WIDTH/5) );
  }
  else if(CURRENTSTATE == 4){
    zombieQ.setState( BATTLE );
    hole.setState( BATTLE );
  
    mcJoe.reset( WIDTH/4, WIDTH - (WIDTH/5) );
    zombieQ.reset( (WIDTH/4)*3, WIDTH - (WIDTH/5) );
  }
  
}

void drawWorld(){
    imageMode(CORNERS);
    image(screen, 0, 0, WIDTH, LENGTH); 
} // drawWorld()

void checkCollision() {
  
  for ( int direction = 0; direction < 4; direction++ ) { // change so it can check if it is all the zombies and the queen
    switch( direction ) {
      case NORTH:
        if ( map.getValue( ( int )( mcJoe.getPos().x / grid_size ), ( int ) ( ( mcJoe.getPos().y - grid_size ) / grid_size ) ).equals( "5" ) ||
             map.getValue( ( int )( mcJoe.getPos().x / grid_size ), ( int ) ( ( mcJoe.getPos().y - grid_size ) / grid_size ) ).equals( "6" ) ||
             map.getValue( ( int )( mcJoe.getPos().x / grid_size ), ( int ) ( ( mcJoe.getPos().y - grid_size ) / grid_size ) ).equals( "7" ) ||
             map.getValue( ( int )( mcJoe.getPos().x / grid_size ), ( int ) ( ( mcJoe.getPos().y - grid_size ) / grid_size ) ).equals( "8" ) ||
             map.getValue( ( int )( mcJoe.getPos().x / grid_size ), ( int ) ( ( mcJoe.getPos().y - grid_size ) / grid_size ) ).equals( "9" ) ) {
          setBattle();
          return;
        }
        break;
      case SOUTH:
        if ( map.getValue( ( int )( mcJoe.getPos().x / grid_size ), ( int ) ( ( mcJoe.getPos().y + grid_size ) / grid_size ) ).equals( "5" ) ||
             map.getValue( ( int )( mcJoe.getPos().x / grid_size ), ( int ) ( ( mcJoe.getPos().y + grid_size ) / grid_size ) ).equals( "6" ) ||
             map.getValue( ( int )( mcJoe.getPos().x / grid_size ), ( int ) ( ( mcJoe.getPos().y + grid_size ) / grid_size ) ).equals( "7" ) ||
             map.getValue( ( int )( mcJoe.getPos().x / grid_size ), ( int ) ( ( mcJoe.getPos().y + grid_size ) / grid_size ) ).equals( "8" ) ||
             map.getValue( ( int )( mcJoe.getPos().x / grid_size ), ( int ) ( ( mcJoe.getPos().y + grid_size ) / grid_size ) ).equals( "9" ) ) {
          setBattle();
          return;
        }
        break;
      case WEST:
        if ( map.getValue( ( int )( ( mcJoe.getPos().x - grid_size ) / grid_size ), ( int )( mcJoe.getPos().y / grid_size ) ).equals( "5" ) ||
             map.getValue( ( int )( ( mcJoe.getPos().x - grid_size ) / grid_size ), ( int )( mcJoe.getPos().y / grid_size ) ).equals( "6" ) ||
             map.getValue( ( int )( ( mcJoe.getPos().x - grid_size ) / grid_size ), ( int )( mcJoe.getPos().y / grid_size ) ).equals( "7" ) ||
             map.getValue( ( int )( ( mcJoe.getPos().x - grid_size ) / grid_size ), ( int )( mcJoe.getPos().y / grid_size ) ).equals( "8" ) ||
             map.getValue( ( int )( ( mcJoe.getPos().x - grid_size ) / grid_size ), ( int )( mcJoe.getPos().y / grid_size ) ).equals( "9" ) ) {
          setBattle();
          return;
        }
        break;
      case EAST:
        if ( map.getValue( ( int )( ( mcJoe.getPos().x + grid_size ) / grid_size ), ( int )( mcJoe.getPos().y / grid_size ) ).equals( "5" ) ||
             map.getValue( ( int )( ( mcJoe.getPos().x + grid_size ) / grid_size ), ( int )( mcJoe.getPos().y / grid_size ) ).equals( "6" ) ||
             map.getValue( ( int )( ( mcJoe.getPos().x + grid_size ) / grid_size ), ( int )( mcJoe.getPos().y / grid_size ) ).equals( "7" ) ||
             map.getValue( ( int )( ( mcJoe.getPos().x + grid_size ) / grid_size ), ( int )( mcJoe.getPos().y / grid_size ) ).equals( "8" ) ||
             map.getValue( ( int )( ( mcJoe.getPos().x + grid_size ) / grid_size ), ( int )( mcJoe.getPos().y / grid_size ) ).equals( "9" ) ) {
          setBattle();
          return;
        }
        break;
      } // switch 
  }
  
}

// create the buttons for the weapons
void createButtons(){
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
void mouseClicked() {
  if ( state == MAIN ) {
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
  else if ( state == BATTLE ) {
    mcJoe.attack( mouseX, mouseY ); 
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
   
void drawLevel(){ // from the draw battle
      if(state == DUNGEON){
        // make a function for each level
        if(CURRENTSTATE == 0){
          zombie.checkSight(mcJoe.getPos()); // checks if it is int the line of sight if it it will move towards mcjoe
          zombieF.checkSight(mcJoe.getPos()); // checks if it is int the line of sight if it it will move towards mcjoe
      
          zombie.draw();
          zombieF.draw();
          hole.draw();
          mcJoe.draw();
        }
        else if(CURRENTSTATE == 3){
          zombieMM.checkSight(mcJoe.getPos()); // checks if it is int the line of sight if it it will move towards mcjoe
          zombieMF.checkSight(mcJoe.getPos()); // checks if it is int the line of sight if it it will move towards mcjoe
      
          zombieMM.draw();
          zombieMF.draw();
          hole.draw();
          mcJoe.draw();
        }
        else if(CURRENTSTATE == 2){
          mcJoe.draw();
          zombie.checkSight(mcJoe.getPos()); // checks if it is int the line of sight if it it will move towards mcjoe
          zombieMF.checkSight(mcJoe.getPos()); // checks if it is int the line of sight if it it will move towards mcjoe
 
          zombie.draw();
          zombieMF.draw();
          hole.draw();
        }
        else if(CURRENTSTATE == 1){
          mcJoe.draw();
          zombieF.checkSight(mcJoe.getPos()); // checks if it is int the line of sight if it it will move towards mcjoe
          zombieMM.checkSight(mcJoe.getPos()); // checks if it is int the line of sight if it it will move towards mcjoe

          zombieF.draw();
          zombieMM.draw();
          hole.draw();
        }
        else if(CURRENTSTATE == 4){
          mcJoe.draw();
          zombieQ.checkSight(mcJoe.getPos()); // checks if it is int the line of sight if it it will move towards mcjoe
      
          zombieQ.draw();
          hole.draw();
          mcJoe.draw();
        }
      }
      
      if(state == BATTLE){
        // make a function for each level
        if(CURRENTSTATE == 0){
            zombie.checkSight(mcJoe.getPos()); // checks if it is int the line of sight if it it will move towards mcjoe
            zombieF.checkSight(mcJoe.getPos()); // checks if it is int the line of sight if it it will move towards mcjoe
      
            zombie.draw();
            zombieF.draw();
            hole.draw();
            mcJoe.draw();
        }
        else if(CURRENTSTATE == 3){
            zombieMM.checkSight(mcJoe.getPos()); // checks if it is int the line of sight if it it will move towards mcjoe
            zombieMF.checkSight(mcJoe.getPos()); // checks if it is int the line of sight if it it will move towards mcjoe
      
            zombieMM.draw();
            zombieMF.draw();
            hole.draw();
            mcJoe.draw();
        }
        else if(CURRENTSTATE == 2){
            mcJoe.draw();
            zombie.checkSight(mcJoe.getPos()); // checks if it is int the line of sight if it it will move towards mcjoe
            zombieMF.checkSight(mcJoe.getPos()); // checks if it is int the line of sight if it it will move towards mcjoe
      
            zombie.draw();
            zombieMF.draw();
            hole.draw();
        }
        else if(CURRENTSTATE == 1){
            mcJoe.draw();
            zombieF.checkSight(mcJoe.getPos()); // checks if it is int the line of sight if it it will move towards mcjoe
            zombieMM.checkSight(mcJoe.getPos()); // checks if it is int the line of sight if it it will move towards mcjoe
      
            zombieF.draw();
            zombieMM.draw();
            hole.draw();
        }
        else if(CURRENTSTATE == 4){
            mcJoe.draw();
            zombieQ.checkSight(mcJoe.getPos()); // checks if it is int the line of sight if it it will move towards mcjoe
      
            zombieQ.draw();
            hole.draw();
            mcJoe.draw();
        }
      }
}

void dungeonLevel(){
    mcJoe = new Player( map);
    if(CURRENTSTATE == 0){
      zombie = new Zombie( map, ZOMBIE_M, ZOM_M);
      zombieF = new Zombie( map, ZOMBIE_F, ZOM_F);
    }
    else if(CURRENTSTATE == 3){
      zombieMM = new Zombie( map, ZOMBIE_MM, ZOM_MM);
      zombieMF = new Zombie( map, ZOMBIE_MF, ZOM_MF);
    }
    else if(CURRENTSTATE ==2){
      zombie = new Zombie( map, ZOMBIE_M, ZOM_M);
      zombieMF = new Zombie( map, ZOMBIE_MF, ZOM_MF);
    }
    else if(CURRENTSTATE == 1){
      zombieF = new Zombie( map, ZOMBIE_F, ZOM_F);
      zombieMM = new Zombie( map, ZOMBIE_MM, ZOM_MM);
    }
    else if(CURRENTSTATE == 4){
      zombieQ = new Zombie( map, ZOMBIE_Q, ZOM_Q);
    }
}