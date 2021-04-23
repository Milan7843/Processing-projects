int size = 3;
int tiles = size*size;

int[] state = new int[tiles];
int[] movesDone = new int[9];
int[][] allMoves = new int[9][9];

int[] winningMoves = new int[9];
int[] losingMoves = new int[9];

boolean[] movePossible = new boolean[9];

int depth_ = 3;

color c1 = color(255, 0, 0);
color c2 = color(120);
color ce = color(255);

int move = 0;

void setup() {
  size(600, 600);
  //Setting all tiles to empty
  for (int i = 0; i < tiles; i++) {
    state[i] = 2;
  }
  
  
  state[0] = 0;
  state[4] = 1;
  state[2] = 0;
  
  int[] st = new int[9];
  arrayCopy(state, st);
  
  
  print("Primary state: " + printState(st) + "\n");
  for (int i = 0; i < tiles; i++) {
    if (movePossible(st, i)) {
      movePossible[i] = true;
      tryMove(i, i, depth_, st, 1);
      print("progress: [");
      for (int p = 0; p < i; p++) {
        print("I");
      }
      for (int p = 0; p < tiles-i; p++) {
        print("-");
      }
      print("]\n");
    }
    else {
      movePossible[i] = false;
    }
  }
  
  int[] score = new int[9];
  
  for (int i = 0; i < state.length; i++) {
    score[i] = winningMoves[i] - losingMoves[i];
  }
  
  int bestMoveIndex = 0;
  int bestScore = -1000;
  
  for (int i = 0; i < state.length; i++) {
    if (score[i] > bestScore && movePossible[i]) {
      bestMoveIndex = i;
      bestScore = score[i];
    }
  }
  
  print("scores: " + printMoves(score) + ", move chosen: " + bestMoveIndex + "\n");
  
  
  print(checkWin(state) + "\n");
  print("state: " + printState(winningMoves) + "\n");
  print("winning moves: " + printMoves(winningMoves) + "\n");
  print("losing moves: " + printMoves(losingMoves) + "\n");
}

void draw() {
  //noStroke();
  for (int i = 0; i < tiles; i++) {
    fill(state[i] == 0 ? c1 : state[i] == 1 ? c2 : ce);
    int x = i % 3;
    int y = floor(i/3);
    rect(x*(width/size), y*(height/size), (x+1)*(width/size), (y+1)*(height/size));
  }
}

//Function should check whether current best move improves on last best move and update it if this is the case

void tryMove(int startMove, int i, int depth, int[] st_, int player) {
  
  int[] st = new int[9];
  
  arrayCopy(st_, st);
  
  for (int c = 0; c < 9; c++) {
    if (movePossible(st, c)) {
      int[] st2 = new int[9];
      arrayCopy(st, st2);
      st2[c] = player;
      //print("move " + c + " was possible, going from " + printState(st) + " to " + printState(st2) + "\n");
      
      int win = checkWin(st2);
      switch (win) {
        
        //No win was found
        case 2:
          if (depth < 5) tryMove(startMove, c, depth+1, st2, player == 0 ? 1 : 0);
          //print("Checking sequence (depth=" + depth + ")" + printState(st2) + "\n");
          break;
          
        //Win for 0
        case 0:
          print("Sequence ended in win for player, from start " + startMove + ", at state " + printState(st2));
          losingMoves[startMove] += 1*(9-depth);
          break;
          
        //Win for 1
        case 1:
          print("Sequence ended in win for computer, from start " + startMove + ", at state " + printState(st2));
          winningMoves[startMove] += 1*(9-depth);
          break;
      }
    } 
    else {
      //print("move " + c + " was not possible, because st[" + c + "] = " + st[c] + ", at depth: " + depth + "\n");
    }
  }
}

void mousePressed() {
  int i = floor(mouseX/(width/3)) + floor(mouseY/(height/3))*3;
  if (state[i] == 2) {
    state[i] = move;
    move = (move == 0 ? 1 : 0);
    print("Checking win: " + checkWin(state) + "\n");
  }
}

String printState(int[] st) {
  String str = "\n";
  /*
  for (int i = 0; i < tiles; i++) {
    if (st[i] != 2 || true) {
      str += "[" + i + ":" + st[i] + "]";
    }
  }
  */
  for (int i = 0; i < tiles; i++) {
    if (st[i] != 2) {
      str += "[" + st[i] + "]";
    }
    else {
      str += "[ ]";
    }
    if (i % 3 == 2 && i != tiles) str += "\n"; 
  }
  return str;
}

String printMoves(int[] st) {
  String str = "";
  for (int i = 0; i < tiles; i++) {
    if (st[i] != 0 || true) {
      str += "[" + i + ":" + st[i] + "]";
    }
  }
  return str;
}

boolean movePossible(int[] st, int i) {
  return st[i] == 2;
}

int checkWin(int[] st) {
  //Horizontal line checking
  for (int i = 0; i < 3; i++) {
    if (st[i] == st[3+i] && st[3+i] == st[6+i]) {
      return st[i];
    }
  }
  for (int i = 0; i < 3; i++) {
    if (st[i*3] == st[1+i*3] && st[1+i*3] == st[2+i*3]) {
      return st[i*3];
    }
  }
  if (st[0] == st[4] && st[4] == st[8]) {
    return st[0];
  }
  if (st[2] == st[4] && st[4] == st[6]) {
    return st[2];
  }
  return 2;
}

int findBestMove() {
  int[] ts = state;
  boolean foundWin = false;
  
  boolean done = false;
  int movesPossible = 9;
  
  while (!done) {
    for (int i = 0; i < movesPossible; i++) {
      
    }
  }
  
  //Looking for win long term
  while (!foundWin) {
    
  }
  return 0;
}
