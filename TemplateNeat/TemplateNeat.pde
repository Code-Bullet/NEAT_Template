//this is a template to add a NEAT ai to any game
//note //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<replace 
//this means that there is some information specific to the game to input here


int nextConnectionNo = 1000;
Population pop;
int speed = 60;


boolean showBest = true;//true if only show the best of the previous generation
boolean runBest = false; //true if replaying the best ever game
boolean humanPlaying = false; //true if the user is playing

Player humanPlayer;

boolean runThroughSpecies = false;
int upToSpecies = 0;
Player speciesChamp;

boolean showBrain = false;

boolean showBestEachGen = false;
int upToGen = 0;
Player genPlayerTemp;

boolean showNothing = false;


//--------------------------------------------------------------------------------------------------------------------------------------------------

void setup() {
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<replace
  pop = new Population(500);
  humanPlayer = new Player();
}
//--------------------------------------------------------------------------------------------------------------------------------------------------------
void draw() {
  drawToScreen();
  if (showBestEachGen) {//show the best of each gen
    if (!genPlayerTemp.dead) {//if current gen player is not dead then update it

      genPlayerTemp.look();
      genPlayerTemp.think();
      genPlayerTemp.update();
      genPlayerTemp.show();
    } else {//if dead move on to the next generation
      upToGen ++;
      if (upToGen >= pop.genPlayers.size()) {//if at the end then return to the start and stop doing it
        upToGen= 0;
        showBestEachGen = false;
      } else {//if not at the end then get the next generation
        genPlayerTemp = pop.genPlayers.get(upToGen).cloneForReplay();
      }
    }
  } else
    if (runThroughSpecies ) {//show all the species 
      if (!speciesChamp.dead) {//if best player is not dead
        speciesChamp.look();
        speciesChamp.think();
        speciesChamp.update();
        speciesChamp.show();
      } else {//once dead
        upToSpecies++;
        if (upToSpecies >= pop.species.size()) { 
          runThroughSpecies = false;
        } else {
          speciesChamp = pop.species.get(upToSpecies).champ.cloneForReplay();
        }
      }
    } else {
      if (humanPlaying) {//if the user is controling the ship[
        if (!humanPlayer.dead) {//if the player isnt dead then move and show the player based on input
          humanPlayer.look();
          humanPlayer.update();
          humanPlayer.show();
        } else {//once done return to ai
          humanPlaying = false;
        }
      } else 
      if (runBest) {// if replaying the best ever game
        if (!pop.bestPlayer.dead) {//if best player is not dead
          pop.bestPlayer.look();
          pop.bestPlayer.think();
          pop.bestPlayer.update();
          pop.bestPlayer.show();
        } else {//once dead
          runBest = false;//stop replaying it
          pop.bestPlayer = pop.bestPlayer.cloneForReplay();//reset the best player so it can play again
        }
      } else {//if just evolving normally
        if (!pop.done()) {//if any players are alive then update them
          pop.updateAlive();
        } else {//all dead
          //genetic algorithm 
          pop.naturalSelection();
        }
      }
    }
}


//---------------------------------------------------------------------------------------------------------------------------------------------------------
//draws the display screen
void drawToScreen() {
  if (!showNothing) {
   //pretty stuff
    //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<replace
    
    drawBrain();
    writeInfo();
  }
}
//-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
void drawBrain() {  //show the brain of whatever genome is currently showing
  int startX = 0;//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<replace
  int startY = 0;
  int w = 0;
  int h = 0;
  if (runThroughSpecies) {
    speciesChamp.brain.drawGenome(startX,startY,w,h);
  } else
    if (runBest) {
      pop.bestPlayer.brain.drawGenome(startX,startY,w,h);
    } else
      if (humanPlaying) {
        showBrain = false;
      } else if (showBestEachGen) {
        genPlayerTemp.brain.drawGenome(startX,startY,w,h);
      } else {
        pop.pop.get(0).brain.drawGenome(startX,startY,w,h);
      }
}
//-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//writes info about the current player
void writeInfo() {
  fill(200);
  textAlign(LEFT);
  textSize(30);
  if (showBestEachGen) {
    text("Score: " + genPlayerTemp.score, 650, 50);//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<replace
    text("Gen: " + (genPlayerTemp.gen +1), 1150, 50);
  } else
    if (runThroughSpecies) {
      text("Score: " + speciesChamp.score, 650, 50);//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<replace
      text("Species: " + (upToSpecies +1), 1150, 50);
      text("Players in this Species: " + pop.species.get(upToSpecies).players.size(), 50, height/2 + 200);
    } else
      if (humanPlaying) {
        text("Score: " + humanPlayer.score, 650, 50);//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<replace
      } else
        if (runBest) {
          text("Score: " + pop.bestPlayer.score, 650, 50);//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<replace
          text("Gen: " + pop.gen, 1150, 50);
        } else {
          if (showBest) {          
            text("Score: " + pop.pop.get(0).score, 650, 50);//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<replace
            text("Gen: " + pop.gen, 1150, 50);
            text("Species: " + pop.species.size(), 50, height/2 + 300);
            text("Global Best Score: " + pop.bestScore, 50, height/2 + 200);
          }
        }
}

//--------------------------------------------------------------------------------------------------------------------------------------------------

void keyPressed() {
  switch(key) {
  case ' ':
    //toggle showBest
    showBest = !showBest;
    break;
  case '+'://speed up frame rate
    speed += 10;
    frameRate(speed);
    println(speed);
    break;
  case '-'://slow down frame rate
    if (speed > 10) {
      speed -= 10;
      frameRate(speed);
      println(speed);
    }
    break;
  case 'b'://run the best
    runBest = !runBest;
    break;
  case 's'://show species
    runThroughSpecies = !runThroughSpecies;
    upToSpecies = 0;
    speciesChamp = pop.species.get(upToSpecies).champ.cloneForReplay();
    break;
  case 'g'://show generations
    showBestEachGen = !showBestEachGen;
    upToGen = 0;
    genPlayerTemp = pop.genPlayers.get(upToGen).clone();
    break;
  case 'n'://show absolutely nothing in order to speed up computation
    showNothing = !showNothing;
    break;
  case 'p'://play
    humanPlaying = !humanPlaying;
    humanPlayer = new Player();
    break; 
  case CODED://any of the arrow keys
    switch(keyCode) {
    case UP://the only time up/ down / left is used is to control the player
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<replace
      break;
    case DOWN:
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<replace
      break;
    case LEFT:
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<replace
      break;
    case RIGHT://right is used to move through the generations
      if (runThroughSpecies) {//if showing the species in the current generation then move on to the next species
        upToSpecies++;
        if (upToSpecies >= pop.species.size()) {
          runThroughSpecies = false;
        } else {
          speciesChamp = pop.species.get(upToSpecies).champ.cloneForReplay();
        }
      } else 
      if (showBestEachGen) {//if showing the best player each generation then move on to the next generation
        upToGen++;
        if (upToGen >= pop.genPlayers.size()) {//if reached the current generation then exit out of the showing generations mode
          showBestEachGen = false;
        } else {
          genPlayerTemp = pop.genPlayers.get(upToGen).cloneForReplay();
        }
      } else if (humanPlaying) {//if the user is playing then move player right

        //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<replace
      }
      break;
    }
    break;
  }
}