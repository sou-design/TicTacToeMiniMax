// Tic tac Toe game
// player 1 draws a cross
// player 2 draws a circle
import javax.swing.*;
import java.awt.Color;
import java.util.ArrayList;

Square[][] grid;                 // array of squares makes up a grid
int row, col, spaces;            // grid layout
float x, y, w, h;                // values for the grid to be passed to class
int player = 1;                  // start with player 1
boolean gameOver;                // check if the game is finished
int winner;                      // holds the winning player (1 or 2)
boolean play;                    // continue playing - set to false if game won before all squares filled

float w_button = 150;            // play again button
float h_button = 40;
float x_button = 500;
float y_button = 150; 

color color1,color2;

boolean startFirst = false;

String[] possibilities = {"moi", "pc"};
   
void setup(){
  ArrayList<String> myStrings = new ArrayList<String>();
  myStrings.add("jaune");myStrings.add("rouge");myStrings.add("vert");
  myStrings.add("noire");myStrings.add("bleu");myStrings.add("orange");
  
  size (700,425);
  row = 3; col = 3; spaces = 9;  
  grid = new Square[row][col];

   
  
  String c1 = (String)JOptionPane.showInputDialog(
                   frame,
                   "choisiez couleur de joueur 1:",
                   "choix",
                   JOptionPane.WARNING_MESSAGE,
                   null,
                   myStrings.toArray(),myStrings.get(0)
                   );
                   myStrings.remove(c1);
  String c2 = (String)JOptionPane.showInputDialog(
                   frame,
                   "choisiez couleur de joueur 2:",
                   "choix",
                   JOptionPane.WARNING_MESSAGE,
                   null,
                   myStrings.toArray(),myStrings.get(0)
                   );
    color1=setColor(c1);
    color2=setColor(c2);
  startGame();    // set up a game
  
}



void draw(){
  
  checkGameOver();  // check if the game is over
  
  
  // game is not finished - continue playing
  
  if (gameOver == false){
    
    // draw the grid over the neutral background
    background(255);
    for(int i = 0; i < row; i++){
      for(int j = 0; j < col; j++){
        grid[i][j].display();
      }
    }
  
  }
  
  
  // game is finished - game over
  
  else {
    play = false;
    // set the background depending on the winner (if there is one)
    if (winner == 1){background(0,0,0);}
    else if (winner == 2){background(0,0,0);}
    else{background(0);}
        
    endOfGameText(winner);    // display the winner 

    // then redraw the grid on top
    for(int i = 0; i < row; i++){
      for(int j = 0; j < col; j++){
        grid[i][j].display();
      }
    }
    
    playAgainButton();      // display the button option to play again
    
    
  }
 
}



class Square{
  
 float xPos, yPos, s_width, s_height;    // used to draw the square
 int value;                              // 1 = cross, 2 = square

 Square(float x, float y, float w, float h){
   xPos = x;
   yPos = y;
   s_width = w;
   s_height = h;
   value = 0;       // default value, use later to check if square is empty
 }
 
 // display the square
 // then display a cross or square as appropriate
 // the values are set in the click function
 void display(){
   color colorSquare = color(0, 26, 0);
   fill(colorSquare);
   stroke(255);
   strokeWeight(5);
   rect(xPos, yPos, s_width, s_height);
   if(value == 1){
     drawCircle(color1);
   }
   else if(value == 2){
     drawCircle(color2);
   }
 }
 
 // called on mouse click
 // if click is on a square check if it is empty, before drawing a cross or circle
 // only draw if game is not completed
 void click(float m_X, float m_Y){
   
   float mX = m_X;
   float mY = m_Y;
   
   // only so this is the mouse has clicked in a square
   if(mX > xPos && mX < xPos + s_width &&
      mY > yPos && mY < yPos + s_height){
      
      if(value == 0 && play == true){
          
        // player 1, set value for cross, then player 2 turn 
        if(player==1){
          value = 1;
          player = 2;
         }
       
         // player 2, set value for circle, then player 1 turn
         else{
           value = 2;
           player = 1;
         }
       
         // a turn has been taken, and a space used on the board
         spaces--;
      }
    }   
 }
 

 // draw a circle with a specific stroke colour and weight
 void drawCircle(color c){
   
   stroke(c);// strokeWeight(20);
   fill(c);
   circle(xPos+(s_width/2), yPos+(s_height/2),50);
   stroke(0); strokeWeight(1);
 }
 
 // accessor function to get the value of each square
 //  2 = circle
 // use this to determine if there is a winer
 int getValue(){
   return value;
 }


}

// if mouse press load the click function
void mousePressed(){
  for(int i = 0; i < row; i++){
    for(int j = 0; j < col; j++){
      grid[i][j].click(mouseX, mouseY);
    }
  }
  
  if (mouseX > x_button && mouseX < x_button + w_button &&
      mouseY > y_button && mouseY < y_button + h_button){
    startGame();
  }
}

// check if the game is over
// either all spaces are filled, or 3 in a row

void checkGameOver(){
  
 int r = row;
 int c = col;
 
 // three in a row
 for (int i = 0; i < r; i++){
   if(grid[i][0].getValue() == 1 && grid[i][1].getValue() ==  1 && grid[i][2].getValue() == 1){
     gameOver = true;
     winner = 1;
   }
   if(grid[i][0].getValue() == 2 && grid[i][1].getValue() ==  2 && grid[i][2].getValue() == 2){
     gameOver = true;
     winner = 2;
   }
 }
 
 // three in a column
 for (int i = 0; i < c; i++){
   if(grid[0][i].getValue() == 1 && grid[1][i].getValue() ==  1 && grid[2][i].getValue() == 1){
     gameOver = true;
     winner = 1;
   }
   if(grid[0][i].getValue() == 2 && grid[1][i].getValue() ==  2 && grid[2][i].getValue() == 2){
     gameOver = true;
     winner = 2;
   }
 }
 
 // top left to bottom right
 if(grid[0][0].getValue() == 1 && grid[1][1].getValue() ==  1 && grid[2][2].getValue() == 1){
     gameOver = true;
     winner = 1;
 }
 if(grid[0][0].getValue() == 2 && grid[1][1].getValue() ==  2 && grid[2][2].getValue() == 2){
     gameOver = true;
     winner = 2;
 }
 
 // bottom left to top right
 if(grid[2][0].getValue() == 1 && grid[1][1].getValue() ==  1 && grid[0][2].getValue() == 1){
     gameOver = true;
     winner = 1;
 }
 if(grid[2][0].getValue() == 2 && grid[1][1].getValue() ==  2 && grid[0][2].getValue() == 2){
     gameOver = true;
     winner = 2;
 }
 
 if (spaces == 0){
   gameOver = true;
 }
 
}
  
 void endOfGameText(int win){
   float xPosition = 450, yPosition = 300;
   stroke(255);
   textSize(20);
   if (win==1){text("bingoo ! :\n joueur 1 a gangé", xPosition, yPosition);}
   if (win==2){text("bingoo ! :\n joueur 2 a gangé", xPosition, yPosition);}
   if (win==0){text(":( Personne n'a gagné :D", xPosition-35, yPosition);}
    stroke(0);
 }

 void playAgainButton(){
   fill(200);
   stroke(200);
   rect(x_button, y_button, w_button, h_button); 
   stroke(0);
   fill(0);
   text("REJOUER", x_button+15, y_button+30);
   fill(255);
 }
 
 void startGame(){
   
   player = 1;          // start game with player 1
   play = true;         // begin to play
   spaces = 9;          // 9 empty spaces on the grid
   gameOver = false;    // game will continue in draw function
   winner = 0;          // no current winner (must be player 1 or 2 to win)
   
   background(255);    
   
   // start positions and details of the square
   x = 25;          
   y = 25;
   w = 125; h = 125;
  
   // adjust x, y values when creating squares of the grid
   for(int i = 0; i < row; i++){
    for(int j = 0; j < col; j++){
      grid[i][j] = new Square(x, y, w, h);
      x += w;  // adjust x for width
    }
    y += h;    // after each row, ajust for height
    x = 25;    // reset to same x as row above
  }
 }
 
 
 color setColor(String cS){
   //"jaune", "rouge", "vert", "bleu", "noire","orange"
   if(cS == "jaune"){return color(247, 249, 5);}
   else if(cS == "rouge"){return color(255, 0, 0);}
   else if(cS == "vert"){return color(0, 255, 0);}
   else if(cS == "bleu"){return color(0, 0, 255);}
   else if(cS == "noire"){return color(0, 0, 0);}
   else if(cS == "orange"){return color(255, 127, 0);}
   return color(0,0,0);
 }
