class Player {
  float fitness;
  Genome brain;
  float[] vision = new float[8];//the input array fed into the neuralNet 
  float[] decision = new float[4]; //the out put of the NN 
  float unadjustedFitness;
  int lifespan = 0;//how long the player lived for fitness
  int bestScore =0;//stores the score achieved used for replay
  boolean dead;
  int score;
  int gen = 0;
  
  int genomeInputs = 13;
  int genomeOutputs = 4;
  //---------------------------------------------------------------------------------------------------------------------------------------------------------
  //constructor

  Player() {
    brain = new Genome(genomeInputs,genomeOutputs);
  }

  //---------------------------------------------------------------------------------------------------------------------------------------------------------
  void show() {
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<replace
  }
  //---------------------------------------------------------------------------------------------------------------------------------------------------------
  void move() {
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<replace
  }
  //---------------------------------------------------------------------------------------------------------------------------------------------------------
  void update() {
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<replace
  }
  //----------------------------------------------------------------------------------------------------------------------------------------------------------

  void look() {
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<replace
   
  }




 

  //---------------------------------------------------------------------------------------------------------------------------------------------------------
  //gets the output of the brain then converts them to actions
  void think() {

    float max = 0;
    int maxIndex = 0;
    //get the output of the neural network
    decision = brain.feedForward(vision);

    for (int i = 0; i < decision.length; i++) {
      if (decision[i] > max) {
        max = decision[i];
        maxIndex = i;
      }
    }
    
    //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<replace


  }
  //---------------------------------------------------------------------------------------------------------------------------------------------------------  
  //returns a clone of this player with the same brian
  Player clone() {
    Player clone = new Player();
    clone.brain = brain.clone();
    clone.fitness = fitness;
    clone.brain.generateNetwork(); 
    clone.gen = gen;
    clone.bestScore = score;
    return clone;
  }

//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//since there is some randomness in games sometimes when we want to replay the game we need to remove that randomness
//this fuction does that

  Player cloneForReplay() {
    Player clone = new Player();
    clone.brain = brain.clone();
    clone.fitness = fitness;
    clone.brain.generateNetwork();
    clone.gen = gen;
    clone.bestScore = score;
    //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<replace
    return clone;
  }

  //---------------------------------------------------------------------------------------------------------------------------------------------------------
  //fot Genetic algorithm
  void calculateFitness() {
    //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<replace

  }

  //---------------------------------------------------------------------------------------------------------------------------------------------------------
  Player crossover(Player parent2) {
    Player child = new Player();
    child.brain = brain.crossover(parent2.brain);
    child.brain.generateNetwork();
    return child;
  }
}