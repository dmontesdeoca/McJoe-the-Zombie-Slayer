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
Player mcJoe; // player

// zombies
Zombie zombie;
Zombie zombieF;
Zombie zombieMM;
Zombie zombieMF;
Zombie zombieQ;

Coin[] coins;
int countCoins = 0;

Heart heart;

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
  frameRate( 15 ); // the lower the number the slower it is
  size( 700, 700);
  state = MAIN;
  running = true;
  setWorld(); // here set the main page, create the buttons
} // setup()

void draw() {
  // TEST make sure
  if ( running ) {
    if( state == MAIN ){
       updateMouse();
      if(weaponPicked){ // if a weapon was clicked set state to dungeon and set world accordingly
        state = DUNGEON;
        setWorld(); // set world as dungeon
      }
    }
    else if ( state == DUNGEON ) {
      checkCollision();
      drawWorld();
      drawLevel();
      frame++;
    }
    else if ( state == BATTLE ){
        imageMode(CORNERS);
        image(screen, 0, 0, WIDTH, LENGTH);        
        drawLevel();
        displayHealth();
        checkMcJoeAttacked();
        frame++;
    }
    else if ( state == END || state == GAMEOVER) {
      imageMode(CORNERS);
      image(screen, 0, 0, WIDTH, LENGTH);
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
} // keyPressed()

// sets world according to what state the game is in MAIN or DUNGEON
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
    coins = new Coin[5];
    dungeonLevel();
    
    if(CURRENTSTATE == 0 || CURRENTSTATE == 2 || CURRENTSTATE == 4){
      screen = loadImage( "../Graphics/map/mapOne.jpg" );
    }
    else if(CURRENTSTATE == 1 || CURRENTSTATE == 3){
     screen = loadImage( "../Graphics/map/mapOne_B.jpg" );
    }
    
    // depending on the value in the map we set the PVector for each object 
      for ( int x = 0; x < map.getMaxX(); x++ ) {
        for ( int y = 0; y < map.getMaxY(); y++ ) {
          String value = map.getValue( x, y );
          switch ( value ) {
            case "2":
              mcJoe.reset( x * grid_size, y * grid_size );
              break;
            case "3":
              hole.reset( x * grid_size, y * grid_size );
              break;
            case "4":
             coins[countCoins] = new Coin(x,y);
             countCoins++;
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
            case "10":
              heart =  new Heart(x,y);
        } // switch
      } 
    }  
    // rest countCoins for future use
    countCoins = 0;
  }
} // setWorld()

void setBattle() {
  state = BATTLE;
  screen = loadImage( "../Graphics/battle/battle.png" );
  mcJoe.setState( BATTLE );
  
  // set battles depending on which state it is on
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
  
    mcJoe.reset( WIDTH/4, WIDTH - (WIDTH/5) );
    zombieQ.reset( (WIDTH/4)*3, WIDTH - (WIDTH/5) );
  }
  
} // setBattle()

void setDungeon() {
  state = DUNGEON;  
  mcJoe.setState( DUNGEON );
  
  if(CURRENTSTATE == 0){
    screen = loadImage( "../Graphics/map/mapOne.jpg" );
    zombie.setState( DUNGEON );
    zombieF.setState( DUNGEON );
    hole.setState( DUNGEON );
  }
  else if(CURRENTSTATE == 3){
    screen = loadImage( "../Graphics/map/mapOne_B.jpg" );
    zombieMM.setState( DUNGEON );
    zombieMF.setState( DUNGEON );
    hole.setState( DUNGEON );
  }
  else if(CURRENTSTATE == 2){
    screen = loadImage( "../Graphics/map/mapOne.jpg" );
    zombie.setState( DUNGEON );
    zombieMF.setState( DUNGEON );
    hole.setState( DUNGEON );
  }
  else if(CURRENTSTATE == 1){
    screen = loadImage( "../Graphics/map/mapOne_B.jpg" );
    zombieF.setState( DUNGEON );
    zombieMM.setState( DUNGEON );
    hole.setState( DUNGEON );
  }
  else if(CURRENTSTATE == 4){
    screen = loadImage( "../Graphics/map/mapOne.jpg" );
    zombieQ.setState( DUNGEON );
  }
  
  for ( int x = 0; x < map.getMaxX(); x++ ) {
        for ( int y = 0; y < map.getMaxY(); y++ ) {
          String value = map.getValue( x, y );
          switch ( value ) {
            case "2":
              mcJoe.reset( x * grid_size, y * grid_size );
              break;
            case "5":
              map.setValue( x, y, "0" );
              break;
            case "6":
              map.setValue( x, y, "0" );
              break;
            case "7":
              map.setValue( x, y, "0" );
              break;
            case "8":
              map.setValue( x, y, "0" );
              break;
            case "9":
              map.setValue( x, y, "0" );
              break;
        } // switch
      } 
  }
} // setBattle()

void drawWorld(){
    imageMode(CORNERS);
    image(screen, 0, 0, WIDTH, LENGTH); 
} // drawWorld()

void checkCollision() {
  
  for ( int direction = 0; direction < 4; direction++ ) {
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
  
  //check collision with coins if it over laps count up the coin count and get it to -1 -1
  for(int i = 0; i < COIN_GOAL; i++){
      if(coins[i].getPos().x == mcJoe.getPos().x && coins[i].getPos().y == mcJoe.getPos().y){
               mcJoe.upgradeWeapon();
               COIN_COLLECTED++;
               coins[i] = new Coin(-1,-1); // gets rid of the coin when mcJoe collects
               // if all coins are collected we set acess to the hole true
               if(COIN_COLLECTED == COIN_GOAL){
                 hole_access = true;
               }
      }
  }
  // check heart collision, if it collides upgrade
  if(heart.getPos().x == mcJoe.getPos().x && heart.getPos().y == mcJoe.getPos().y){
               mcJoe.levelUp();
               heart = new Heart(-1,-1); // get rid of the coin when mcJoe collects
  }
  
  // checks if everything is met in order to move up the level
  if(hole.getPos().x == mcJoe.getPos().x && hole.getPos().y == mcJoe.getPos().y && hole_access == true){
               CURRENTSTATE++;       // moves to the next state
               COIN_COLLECTED = 0;   // resets coins collected for the new map
               hole_access = false;  // resets hole access to false
               setWorld();           // resets world to the next state
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
} // creatButtons()

void updateMouse() {
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
} // updateMouse()

//pass coordinates of buttons
boolean overButton(int x, int y, int width, int height)  {
  if(mouseX >= x && mouseX <= x+width && mouseY >= y && mouseY <= y+height){
    return true;
  } 
  else { return false; }
} // overButton()


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
    checkAttackHit( mouseX, mouseY );
  }
} // mouseClicked()

// highlights if the mouse is over the button
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
} // buttonHighLight()
 
   
void drawLevel(){ // from the draw battle
      if(state == DUNGEON){
        if(CURRENTSTATE == 0){
          zombie.checkSight(mcJoe.getPos());  // checks if it is int the line of sight if it it will move towards mcjoe
          zombieF.checkSight(mcJoe.getPos()); // checks if it is int the line of sight if it it will move towards mcjoe
      
          if ( zombie.getHitPoints() > 0 ) {
              zombie.draw();
          }
          if ( zombieF.getHitPoints() > 0 ) {
            zombieF.draw();
          }
          hole.draw();
          mcJoe.draw();
          drawCoin();
          heart.draw();

        }
        else if(CURRENTSTATE == 3){
          zombieMM.checkSight(mcJoe.getPos()); // checks if it is int the line of sight if it it will move towards mcjoe
          zombieMF.checkSight(mcJoe.getPos()); // checks if it is int the line of sight if it it will move towards mcjoe
      
          if ( zombieMM.getHitPoints() > 0 ) {
            zombieMM.draw();
          }
          if ( zombieMF.getHitPoints() > 0 ) {
            zombieMF.draw();
          }
          hole.draw();
          mcJoe.draw();
          drawCoin();
          heart.draw();
          
        }
        else if(CURRENTSTATE == 2){
          zombie.checkSight(mcJoe.getPos()); // checks if it is int the line of sight if it it will move towards mcjoe
          zombieMF.checkSight(mcJoe.getPos()); // checks if it is int the line of sight if it it will move towards mcjoe
 
          if ( zombie.getHitPoints() > 0 ) {
            zombie.draw();
          }
          if ( zombieMF.getHitPoints() > 0 ) {
            zombieMF.draw();
          }
          hole.draw();
          mcJoe.draw();
          drawCoin();
          heart.draw();


        }
        else if(CURRENTSTATE == 1){
          zombieF.checkSight(mcJoe.getPos()); // checks if it is int the line of sight if it it will move towards mcjoe
          zombieMM.checkSight(mcJoe.getPos()); // checks if it is int the line of sight if it it will move towards mcjoe

          if ( zombieF.getHitPoints() > 0 ) {
            zombieF.draw();
          }
          if ( zombieMM.getHitPoints() > 0 ) {
            zombieMM.draw();
          }
          hole.draw();
          mcJoe.draw();
          drawCoin();
          heart.draw();


        }
        else if(CURRENTSTATE == 4){
          zombieQ.checkSight(mcJoe.getPos()); // checks if it is int the line of sight if it it will move towards mcjoe
      
          zombieQ.draw();
          mcJoe.draw();
          drawCoin();

        }
      }
      
      if(state == BATTLE){
        if(mcJoe.getHitPoints() <= 0){
          state = GAMEOVER;
          screen = loadImage("../Graphics/gameOver.png");
        }
        
        if(CURRENTSTATE == 0){
            zombie.checkSight(mcJoe.getPos()); // checks if it is int the line of sight if it it will move towards mcjoe
            zombieF.checkSight(mcJoe.getPos()); // checks if it is int the line of sight if it it will move towards mcjoe
            
            if ( zombie.getHitPoints() > 0 ) {
              zombie.draw();
            }
            if ( zombieF.getHitPoints() > 0 ) {
              zombieF.draw();
            }
            
            if ( zombie.getHitPoints() <= 0 && zombieF.getHitPoints() <= 0 ) {
              setDungeon(); 
            }
            mcJoe.draw();
        }
        else if(CURRENTSTATE == 3){
            zombieMM.checkSight(mcJoe.getPos()); // checks if it is int the line of sight if it it will move towards mcjoe
            zombieMF.checkSight(mcJoe.getPos()); // checks if it is int the line of sight if it it will move towards mcjoe
      
            if ( zombieMM.getHitPoints() > 0 ) {
              zombieMM.draw();
            }
            if ( zombieMF.getHitPoints() > 0 ) {
              zombieMF.draw();
            }
            
            if ( zombieMM.getHitPoints() <= 0 && zombieMF.getHitPoints() <= 0 ) {
              setDungeon(); 
            }
            mcJoe.draw();
        }
        else if(CURRENTSTATE == 2){
            zombie.checkSight(mcJoe.getPos()); // checks if it is int the line of sight if it it will move towards mcjoe
            zombieMF.checkSight(mcJoe.getPos()); // checks if it is int the line of sight if it it will move towards mcjoe
            
            if ( zombie.getHitPoints() > 0 ) {
              zombie.draw();
            }
            if ( zombieMF.getHitPoints() > 0 ) {
              zombieMF.draw();
            }
            
            if ( zombie.getHitPoints() <= 0 && zombieMF.getHitPoints() <= 0 ) {
              setDungeon(); 
            }
            mcJoe.draw();
        }
        else if(CURRENTSTATE == 1){
            zombieF.checkSight(mcJoe.getPos()); // checks if it is int the line of sight if it it will move towards mcjoe
            zombieMM.checkSight(mcJoe.getPos()); // checks if it is int the line of sight if it it will move towards mcjoe
      
            if ( zombieF.getHitPoints() > 0 ) {
              zombieF.draw();
            }
            if ( zombieMM.getHitPoints() > 0 ) {
              zombieMM.draw();
            }
            
            if ( zombieF.getHitPoints() <= 0 && zombieMM.getHitPoints() <= 0 ) {
              setDungeon(); 
            }
            mcJoe.draw();
        }
        else if(CURRENTSTATE == 4){
            zombieQ.checkSight(mcJoe.getPos()); // checks if it is int the line of sight if it it will move towards mcjoe
      
            if ( zombieQ.getHitPoints() <= 0 ) {
              state = END;
              screen = loadImage("../Graphics/theEnd.png");
            }
            zombieQ.draw();
            mcJoe.draw();
        }
      }
} // drawLevel()

// sets zombies accordoring to the current state and set mcJoe to current map
void dungeonLevel(){

    if(CURRENTSTATE == 0){
      zombie = new Zombie( map, ZOMBIE_M, ZOM_M);
      zombieF = new Zombie( map, ZOMBIE_F, ZOM_F);
      mcJoe = new Player( map );
    }
    else if(CURRENTSTATE == 3){
      zombieMM = new Zombie( map, ZOMBIE_MM, ZOM_MM);
      zombieMF = new Zombie( map, ZOMBIE_MF, ZOM_MF);
      mcJoe.setMap(map);
    }
    else if(CURRENTSTATE == 2){
      zombie = new Zombie( map, ZOMBIE_M, ZOM_M);
      zombieMF = new Zombie( map, ZOMBIE_MF, ZOM_MF);
      mcJoe.setMap(map);
    }
    else if(CURRENTSTATE == 1){
      zombieF = new Zombie( map, ZOMBIE_F, ZOM_F);
      zombieMM = new Zombie( map, ZOMBIE_MM, ZOM_MM);
      mcJoe.setMap(map);
    }
    else if(CURRENTSTATE == 4){
      zombieQ = new Zombie( map, ZOMBIE_Q, ZOM_Q);
      mcJoe.setMap(map);
    }
} // dungeonLevel()

// draw coins
void drawCoin(){
          for(int i = 0; i < 5; i++){
            coins[i].draw();
          }
}// drzawCloin()

//Displays all GameCharacter objects hit points
void displayHealth() {
  if ( state == BATTLE ) {
    textSize( grid_size / 2 );
    fill( 255 );
    text( "mcJoe: " + mcJoe.getHitPoints() , grid_size / 2, grid_size );
    fill( 0, 255, 0 );
    if(CURRENTSTATE == 0){
      text( "Male Zombie: " + ( zombie.getHitPoints() < 0 ? 0 : zombie.getHitPoints() ) , grid_size / 2, grid_size * 2 );
      text( "Memale Zombie: " + ( zombieF.getHitPoints() < 0 ? 0 : zombieF.getHitPoints() ), grid_size / 2, grid_size * 3);
    }
    else if(CURRENTSTATE == 3){
      text( "Mutated Male Zombie: " + ( zombieMM.getHitPoints() < 0 ? 0 : zombieMM.getHitPoints() ) , grid_size / 2, grid_size * 2 );
      text( "Mutated Female Zombie: " + ( zombieMF.getHitPoints() < 0 ? 0 : zombieMF.getHitPoints() ), grid_size / 2, grid_size * 3);

    }
    else if(CURRENTSTATE == 2){
      text( "Male Zombie: " + ( zombie.getHitPoints() < 0 ? 0 : zombie.getHitPoints() ) , grid_size / 2, grid_size * 2 );
      text( "Mutated Female Zombie: " + ( zombieMF.getHitPoints() < 0 ? 0 : zombieMF.getHitPoints() ), grid_size / 2, grid_size * 3);
    }
    else if(CURRENTSTATE == 1){
      text( "Female Zombie: " + ( zombieF.getHitPoints() < 0 ? 0 : zombieF.getHitPoints() ) , grid_size / 2, grid_size * 2 );
      text( "Mutated Male Zombie: " + ( zombieMM.getHitPoints() < 0 ? 0 : zombieMM.getHitPoints() ), grid_size / 2, grid_size * 3);
    }
    else if(CURRENTSTATE == 4){
      text( "Zombie Queen: " + ( zombieQ.getHitPoints() < 0 ? 0 : zombieQ.getHitPoints() ), grid_size / 2, grid_size * 2 );
    }
    noFill();
  }
}

//Check if mcJoe is being attacked
void checkMcJoeAttacked() {
    if ( CURRENTSTATE == 0 ) {
         if ( dist( mcJoe.getPos().x + grid_size, mcJoe.getPos().y + grid_size, zombie.getPos().x + grid_size, zombie.getPos().y + grid_size ) < grid_size * 2 ) {
             mcJoe.damage( 1 );
         }
         if ( dist( mcJoe.getPos().x + grid_size, mcJoe.getPos().y + grid_size, zombieF.getPos().x + grid_size, zombieF.getPos().y + grid_size ) < grid_size * 2 ) {
             mcJoe.damage( 1 );
         }
        }
        else if(CURRENTSTATE == 3){
          if ( dist( mcJoe.getPos().x + grid_size, mcJoe.getPos().y + grid_size, zombieMM.getPos().x + grid_size, zombieMM.getPos().y + grid_size ) < grid_size * 2 ) {
             mcJoe.damage( 2 );
         }
         if ( dist( mcJoe.getPos().x + grid_size, mcJoe.getPos().y + grid_size, zombieMF.getPos().x + grid_size, zombieMF.getPos().y + grid_size ) < grid_size * 2 ) {
             mcJoe.damage( 2 );
         }
        }
        else if(CURRENTSTATE == 2){
          if ( dist( mcJoe.getPos().x + grid_size, mcJoe.getPos().y + grid_size, zombie.getPos().x + grid_size, zombie.getPos().y + grid_size ) < grid_size * 2 ) {
             mcJoe.damage( 1 );
         }
         if ( dist( mcJoe.getPos().x + grid_size, mcJoe.getPos().y + grid_size, zombieMF.getPos().x + grid_size, zombieMF.getPos().y + grid_size ) < grid_size * 2 ) {
             mcJoe.damage( 2 );
         }
        }
        else if(CURRENTSTATE == 1){
          if ( dist( mcJoe.getPos().x + grid_size, mcJoe.getPos().y + grid_size, zombieF.getPos().x + grid_size, zombieF.getPos().y + grid_size ) < grid_size * 2 ) {
             mcJoe.damage( 1 );
         }
         if ( dist( mcJoe.getPos().x + grid_size, mcJoe.getPos().y + grid_size, zombieMM.getPos().x + grid_size, zombieMM.getPos().y + grid_size ) < grid_size * 2 ) {
             mcJoe.damage( 2 );
         }
        }
        else if(CURRENTSTATE == 4){
          if ( dist( mcJoe.getPos().x + grid_size, mcJoe.getPos().y + grid_size, zombieQ.getPos().x + grid_size, zombieQ.getPos().y + grid_size ) < grid_size * 2 ) {
             mcJoe.damage( 4 );
         }
        }
}

//Check if mcJoe's attack hit a zombie in BATTLE state
void checkAttackHit( float x, float y ) {
  if (  WEAPON == SWORD || WEAPON == BAT ) {
     if ( x >= mcJoe.getPos().x + grid_size ) {
       if ( CURRENTSTATE == 0 ) {
         if ( ( ( zombie.getPos().x < mcJoe.getPos().x + grid_size * 5 && zombie.getPos().x > mcJoe.getPos().x + grid_size ) || 
           ( zombie.getPos().x + grid_size * 2 > mcJoe.getPos().x + grid_size && zombie.getPos().x + grid_size * 2 < mcJoe.getPos().x + grid_size * 5 ) ) &&
           ( ( zombie.getPos().y < mcJoe.getPos().y + grid_size * 2 && zombie.getPos().y > mcJoe.getPos().y - grid_size * 2 ) || 
           ( zombie.getPos().y + grid_size * 2 > mcJoe.getPos().y - grid_size * 2 && zombie.getPos().y + grid_size * 2 < mcJoe.getPos().y + grid_size * 2 ) ) ) {
             zombie.damage( mcJoe.getWeaponDamage() );
         }
         if ( ( ( zombieF.getPos().x < mcJoe.getPos().x + grid_size * 5 && zombieF.getPos().x > mcJoe.getPos().x + grid_size ) || 
           ( zombieF.getPos().x + grid_size * 2 > mcJoe.getPos().x + grid_size && zombieF.getPos().x + grid_size * 2 < mcJoe.getPos().x + grid_size * 5 ) ) &&
           ( ( zombieF.getPos().y < mcJoe.getPos().y + grid_size * 2 && zombieF.getPos().y > mcJoe.getPos().y - grid_size * 2 ) || 
           ( zombieF.getPos().y + grid_size * 2 > mcJoe.getPos().y - grid_size * 2 && zombieF.getPos().y + grid_size * 2 < mcJoe.getPos().y + grid_size * 2 ) ) ) {
             zombieF.damage( mcJoe.getWeaponDamage() );
         }
        }
        else if(CURRENTSTATE == 3){
         if ( ( ( zombieMM.getPos().x < mcJoe.getPos().x + grid_size * 5 && zombieMM.getPos().x > mcJoe.getPos().x + grid_size ) || 
           ( zombieMM.getPos().x + grid_size * 2 > mcJoe.getPos().x + grid_size && zombieMM.getPos().x + grid_size * 2 < mcJoe.getPos().x + grid_size * 5 ) ) &&
           ( ( zombieMM.getPos().y < mcJoe.getPos().y + grid_size * 2 && zombieMM.getPos().y > mcJoe.getPos().y - grid_size * 2 ) || 
           ( zombieMM.getPos().y + grid_size * 2 > mcJoe.getPos().y - grid_size * 2 && zombieMM.getPos().y + grid_size * 2 < mcJoe.getPos().y + grid_size * 2 ) ) ) {
             zombieMM.damage( mcJoe.getWeaponDamage() );
         }
         if ( ( ( zombieMF.getPos().x < mcJoe.getPos().x + grid_size * 5 && zombieMF.getPos().x > mcJoe.getPos().x + grid_size ) || 
           ( zombieMF.getPos().x + grid_size * 2 > mcJoe.getPos().x + grid_size && zombieMF.getPos().x + grid_size * 2 < mcJoe.getPos().x + grid_size * 5 ) ) &&
           ( ( zombieMF.getPos().y < mcJoe.getPos().y + grid_size * 2 && zombieMF.getPos().y > mcJoe.getPos().y - grid_size * 2 ) || 
           ( zombieMF.getPos().y + grid_size * 2 > mcJoe.getPos().y - grid_size * 2 && zombieMF.getPos().y + grid_size * 2 < mcJoe.getPos().y + grid_size * 2 ) ) ) {
             zombieMF.damage( mcJoe.getWeaponDamage() );
         }
        }
        else if(CURRENTSTATE == 2){
          if ( ( ( zombie.getPos().x < mcJoe.getPos().x + grid_size * 5 && zombie.getPos().x > mcJoe.getPos().x + grid_size ) || 
           ( zombie.getPos().x + grid_size * 2 > mcJoe.getPos().x + grid_size && zombie.getPos().x + grid_size * 2 < mcJoe.getPos().x + grid_size * 5 ) ) &&
           ( ( zombie.getPos().y < mcJoe.getPos().y + grid_size * 2 && zombie.getPos().y > mcJoe.getPos().y - grid_size * 2 ) || 
           ( zombie.getPos().y + grid_size * 2 > mcJoe.getPos().y - grid_size * 2 && zombie.getPos().y + grid_size * 2 < mcJoe.getPos().y + grid_size * 2 ) ) ) {
             zombie.damage( mcJoe.getWeaponDamage() );
         }
          if ( ( ( zombieMF.getPos().x < mcJoe.getPos().x + grid_size * 5 && zombieMF.getPos().x > mcJoe.getPos().x + grid_size ) || 
           ( zombieMF.getPos().x + grid_size * 2 > mcJoe.getPos().x + grid_size && zombieMF.getPos().x + grid_size * 2 < mcJoe.getPos().x + grid_size * 5 ) ) &&
           ( ( zombieMF.getPos().y < mcJoe.getPos().y + grid_size * 2 && zombieMF.getPos().y > mcJoe.getPos().y - grid_size * 2 ) || 
           ( zombieMF.getPos().y + grid_size * 2 > mcJoe.getPos().y - grid_size * 2 && zombieMF.getPos().y + grid_size * 2 < mcJoe.getPos().y + grid_size * 2 ) ) ) {
             zombieMF.damage( mcJoe.getWeaponDamage() );
         }
        }
        else if(CURRENTSTATE == 1){
          if ( ( ( zombieF.getPos().x < mcJoe.getPos().x + grid_size * 5 && zombieF.getPos().x > mcJoe.getPos().x + grid_size ) || 
           ( zombieF.getPos().x + grid_size * 2 > mcJoe.getPos().x + grid_size && zombieF.getPos().x + grid_size * 2 < mcJoe.getPos().x + grid_size * 5 ) ) &&
           ( ( zombieF.getPos().y < mcJoe.getPos().y + grid_size * 2 && zombieF.getPos().y > mcJoe.getPos().y - grid_size * 2 ) || 
           ( zombieF.getPos().y + grid_size * 2 > mcJoe.getPos().y - grid_size * 2 && zombieF.getPos().y + grid_size * 2 < mcJoe.getPos().y + grid_size * 2 ) ) ) {
             zombieF.damage( mcJoe.getWeaponDamage() );
         }
         if ( ( ( zombieMM.getPos().x < mcJoe.getPos().x + grid_size * 5 && zombieMM.getPos().x > mcJoe.getPos().x + grid_size ) || 
           ( zombieMM.getPos().x + grid_size * 2 > mcJoe.getPos().x + grid_size && zombieMM.getPos().x + grid_size * 2 < mcJoe.getPos().x + grid_size * 5 ) ) &&
           ( ( zombieMM.getPos().y < mcJoe.getPos().y + grid_size * 2 && zombieMM.getPos().y > mcJoe.getPos().y - grid_size * 2 ) || 
           ( zombieMM.getPos().y + grid_size * 2 > mcJoe.getPos().y - grid_size * 2 && zombieMM.getPos().y + grid_size * 2 < mcJoe.getPos().y + grid_size * 2 ) ) ) {
             zombieMM.damage( mcJoe.getWeaponDamage() );
         }
        }
        else if(CURRENTSTATE == 4){
          if ( ( ( zombieQ.getPos().x < mcJoe.getPos().x + grid_size * 5 && zombieQ.getPos().x > mcJoe.getPos().x + grid_size ) || 
           ( zombieQ.getPos().x + grid_size * 2 > mcJoe.getPos().x + grid_size && zombieQ.getPos().x + grid_size * 2 < mcJoe.getPos().x + grid_size * 5 ) ) &&
           ( ( zombieQ.getPos().y < mcJoe.getPos().y + grid_size * 2 && zombieQ.getPos().y > mcJoe.getPos().y - grid_size * 2 ) || 
           ( zombieQ.getPos().y + grid_size * 2 > mcJoe.getPos().y - grid_size * 2 && zombieQ.getPos().y + grid_size * 2 < mcJoe.getPos().y + grid_size * 2 ) ) ) {
             zombieQ.damage( mcJoe.getWeaponDamage() );
         }
        }
     }
     else {
       if ( CURRENTSTATE == 0 ) {
         if ( ( ( zombie.getPos().x > mcJoe.getPos().x - grid_size * 4 && zombie.getPos().x < mcJoe.getPos().x + grid_size ) || 
           ( zombie.getPos().x + grid_size * 2 < mcJoe.getPos().x + grid_size && zombie.getPos().x + grid_size * 2 > mcJoe.getPos().x - grid_size * 4 ) ) &&
           ( ( zombie.getPos().y < mcJoe.getPos().y + grid_size * 2 && zombie.getPos().y > mcJoe.getPos().y - grid_size * 2 ) || 
           ( zombie.getPos().y + grid_size * 2 > mcJoe.getPos().y - grid_size * 2 && zombie.getPos().y + grid_size * 2 < mcJoe.getPos().y + grid_size * 2 ) ) ) {
             zombie.damage( mcJoe.getWeaponDamage() );
         }
         if ( ( ( zombieF.getPos().x > mcJoe.getPos().x - grid_size * 4 && zombieF.getPos().x < mcJoe.getPos().x + grid_size ) || 
           ( zombieF.getPos().x + grid_size * 2 < mcJoe.getPos().x + grid_size && zombieF.getPos().x + grid_size * 2 > mcJoe.getPos().x - grid_size * 4 ) ) &&
           ( ( zombieF.getPos().y < mcJoe.getPos().y + grid_size * 2 && zombieF.getPos().y > mcJoe.getPos().y - grid_size * 2 ) || 
           ( zombieF.getPos().y + grid_size * 2 > mcJoe.getPos().y - grid_size * 2 && zombieF.getPos().y + grid_size * 2 < mcJoe.getPos().y + grid_size * 2 ) ) ) {
             zombieF.damage( mcJoe.getWeaponDamage() );
         }
        }
        else if(CURRENTSTATE == 3){
         if ( ( ( zombieMM.getPos().x > mcJoe.getPos().x - grid_size * 4 && zombieMM.getPos().x < mcJoe.getPos().x + grid_size ) || 
           ( zombieMM.getPos().x + grid_size * 2 < mcJoe.getPos().x + grid_size && zombieMM.getPos().x + grid_size * 2 > mcJoe.getPos().x - grid_size * 4 ) ) &&
           ( ( zombieMM.getPos().y < mcJoe.getPos().y + grid_size * 2 && zombieMM.getPos().y > mcJoe.getPos().y - grid_size * 2 ) || 
           ( zombieMM.getPos().y + grid_size * 2 > mcJoe.getPos().y - grid_size * 2 && zombieMM.getPos().y + grid_size * 2 < mcJoe.getPos().y + grid_size * 2 ) ) ) {
             zombieMM.damage( mcJoe.getWeaponDamage() );
         }
         if ( ( ( zombieMF.getPos().x > mcJoe.getPos().x - grid_size * 4 && zombieMF.getPos().x < mcJoe.getPos().x + grid_size ) || 
           ( zombieMF.getPos().x + grid_size * 2 < mcJoe.getPos().x + grid_size && zombieMF.getPos().x + grid_size * 2 > mcJoe.getPos().x - grid_size * 4 ) ) &&
           ( ( zombieMF.getPos().y < mcJoe.getPos().y + grid_size * 2 && zombieMF.getPos().y > mcJoe.getPos().y - grid_size * 2 ) || 
           ( zombieMF.getPos().y + grid_size * 2 > mcJoe.getPos().y - grid_size * 2 && zombieMF.getPos().y + grid_size * 2 < mcJoe.getPos().y + grid_size * 2 ) ) ) {
             zombieMF.damage( mcJoe.getWeaponDamage() );
         }
        }
        else if(CURRENTSTATE == 2){
          if ( ( ( zombie.getPos().x > mcJoe.getPos().x - grid_size * 4 && zombie.getPos().x < mcJoe.getPos().x + grid_size ) || 
           ( zombie.getPos().x + grid_size * 2 < mcJoe.getPos().x + grid_size && zombie.getPos().x + grid_size * 2 > mcJoe.getPos().x - grid_size * 4 ) ) &&
           ( ( zombie.getPos().y < mcJoe.getPos().y + grid_size * 2 && zombie.getPos().y > mcJoe.getPos().y - grid_size * 2 ) || 
           ( zombie.getPos().y + grid_size * 2 > mcJoe.getPos().y - grid_size * 2 && zombie.getPos().y + grid_size * 2 < mcJoe.getPos().y + grid_size * 2 ) ) ) {
             zombie.damage( mcJoe.getWeaponDamage() );
         }
          if ( ( ( zombieMF.getPos().x > mcJoe.getPos().x - grid_size * 4 && zombieMF.getPos().x < mcJoe.getPos().x + grid_size ) || 
           ( zombieMF.getPos().x + grid_size * 2 < mcJoe.getPos().x + grid_size && zombieMF.getPos().x + grid_size * 2 > mcJoe.getPos().x - grid_size * 4 ) ) &&
           ( ( zombieMF.getPos().y < mcJoe.getPos().y + grid_size * 2 && zombieMF.getPos().y > mcJoe.getPos().y - grid_size * 2 ) || 
           ( zombieMF.getPos().y + grid_size * 2 > mcJoe.getPos().y - grid_size * 2 && zombieMF.getPos().y + grid_size * 2 < mcJoe.getPos().y + grid_size * 2 ) ) ) {
             zombieMF.damage( mcJoe.getWeaponDamage() );
         }
        }
        else if(CURRENTSTATE == 1){
          if ( ( ( zombieF.getPos().x > mcJoe.getPos().x - grid_size * 4 && zombieF.getPos().x < mcJoe.getPos().x + grid_size ) || 
           ( zombieF.getPos().x + grid_size * 2 < mcJoe.getPos().x + grid_size && zombieF.getPos().x + grid_size * 2 > mcJoe.getPos().x - grid_size * 4 ) ) &&
           ( ( zombieF.getPos().y < mcJoe.getPos().y + grid_size * 2 && zombieF.getPos().y > mcJoe.getPos().y - grid_size * 2 ) || 
           ( zombieF.getPos().y + grid_size * 2 > mcJoe.getPos().y - grid_size * 2 && zombieF.getPos().y + grid_size * 2 < mcJoe.getPos().y + grid_size * 2 ) ) ) {
             zombieF.damage( mcJoe.getWeaponDamage() );
         }
         if ( ( ( zombieMM.getPos().x > mcJoe.getPos().x - grid_size * 4 && zombieMM.getPos().x < mcJoe.getPos().x + grid_size ) || 
           ( zombieMM.getPos().x + grid_size * 2 < mcJoe.getPos().x + grid_size && zombieMM.getPos().x + grid_size * 2 > mcJoe.getPos().x - grid_size * 4 ) ) &&
           ( ( zombieMM.getPos().y < mcJoe.getPos().y + grid_size * 2 && zombieMM.getPos().y > mcJoe.getPos().y - grid_size * 2 ) || 
           ( zombieMM.getPos().y + grid_size * 2 > mcJoe.getPos().y - grid_size * 2 && zombieMM.getPos().y + grid_size * 2 < mcJoe.getPos().y + grid_size * 2 ) ) ) {
             zombieMM.damage( mcJoe.getWeaponDamage() );
         }
        }
        else if(CURRENTSTATE == 4){
          if ( ( ( zombieQ.getPos().x > mcJoe.getPos().x - grid_size * 4 && zombieQ.getPos().x < mcJoe.getPos().x + grid_size ) || 
           ( zombieQ.getPos().x + grid_size * 2 < mcJoe.getPos().x + grid_size && zombieQ.getPos().x + grid_size * 2 > mcJoe.getPos().x - grid_size * 4 ) ) &&
           ( ( zombieQ.getPos().y < mcJoe.getPos().y + grid_size * 2 && zombieQ.getPos().y > mcJoe.getPos().y - grid_size * 2 ) || 
           ( zombieQ.getPos().y + grid_size * 2 > mcJoe.getPos().y - grid_size * 2 && zombieQ.getPos().y + grid_size * 2 < mcJoe.getPos().y + grid_size * 2 ) ) ) {
             zombieQ.damage( mcJoe.getWeaponDamage() );
         }
        }
     }
   }
}