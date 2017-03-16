

import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
int row = 40;
int col = 40;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs; 

void setup ()
{
    size(400, 400);
    //textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
  bombs = new ArrayList <MSButton> ();
  buttons = new MSButton[row][col];

  for (int i = 0; i<row; i++)
    for (int j = 0; j<col; j++)

        buttons[i][j]= new MSButton(i,j);
    
    
    setBombs();
}
public void setBombs()
{
  while (bombs.size()<11)
  {
    int rows = (int)(Math.random()*row);
    int cols = (int)(Math.random()*col);
    if (!bombs.contains(buttons[rows][cols]))
    {
      bombs.add(buttons[rows][cols]);
    }
  }
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
     for (int i =0; i< bombs.size(); i++) {
    if (bombs.get(i).isMarked() == false) {
      return false;
    }
  }
  return true;
}
public void displayLosingMessage()
{
  buttons[20][11].setLabel("Y");
  buttons[20][12].setLabel("O");
  buttons[20][13].setLabel("U");
  buttons[20][14].setLabel(" ");
  buttons[20][15].setLabel("L");
  buttons[20][16].setLabel("O");
  buttons[20][17].setLabel("S");
  buttons[20][18].setLabel("E");
  buttons[20][19].setLabel(":");
  buttons[20][20].setLabel("(");
  for (int i =0; i < bombs.size(); i++) {
    bombs.get(i).marked = false;
    bombs.get(i).clicked = true;
}
}
public void displayWinningMessage()
{
buttons[20][11].setLabel("Y");
  buttons[20][12].setLabel("O");
  buttons[20][13].setLabel("U");
  buttons[20][14].setLabel(" ");
  buttons[20][15].setLabel("W");
  buttons[20][16].setLabel("I");
  buttons[20][17].setLabel("N");
  buttons[20][18].setLabel(":");
  buttons[20][19].setLabel(")");
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/col;
        height = 400/row;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
  
    
    public void mousePressed () 
  {
    clicked = true;
    if (mouseButton == RIGHT) {
      marked = !marked;
    } else if (bombs.contains(this)) {
      displayLosingMessage();
    } else if ( countBombs(r, c) > 0) {fill(255); 
      setLabel(str(countBombs(r, c)));
    } else {
      if (isValid(r, c-1) && buttons[r][c-1].isClicked() == false) {
        buttons[r][c-1].mousePressed();
      }
      if (isValid(r, c+1) && buttons[r][c+1].isClicked() == false) {
        buttons[r][c+1].mousePressed();
      }
      if (isValid(r-1, c-1) && buttons[r-1][c-1].isClicked() == false) {
        buttons[r-1][c-1].mousePressed();
      }
      if (isValid(r-1, c) && buttons[r-1][c].isClicked() == false) {
        buttons[r-1][c].mousePressed();
      }
      if (isValid(r-1, c+1) && buttons[r-1][c+1].isClicked() == false) {
        buttons[r-1][c+1].mousePressed();
      }
      if (isValid(r+1, c) && buttons[r+1][c].isClicked() == false) {
        buttons[r+1][c].mousePressed();
      }
      if (isValid(r+1, c+1) && buttons[r+1][c+1].isClicked() == false) {
        buttons[r+1][c+1].mousePressed();
      }
      if (isValid(r+1, c-1) && buttons[r+1][c-1].isClicked() == false) {
        buttons[r+1][c-1].mousePressed();
      }
    }
  }


    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        return r >= 0 && r < row && c >= 0 && c < col;  
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        if (isValid(r, c+1) && bombs.contains(buttons[r][c+1]))
            numBombs++;
        if (isValid(r, c-1) && bombs.contains(buttons[r][c-1]))
            numBombs++;
        if (isValid(r+1, c) && bombs.contains(buttons[r+1][c]))
            numBombs++;
        if (isValid(r-1, c) && bombs.contains(buttons[r-1][c]))
            numBombs++;
        if (isValid(r+1, c+1) && bombs.contains(buttons[r+1][c+1]))
            numBombs++;
        if (isValid(r+1, c-1) && bombs.contains(buttons[r+1][c-1]))
            numBombs++;
        if (isValid(r-1, c+1) && bombs.contains(buttons[r-1][c+1]))
            numBombs++;
        if (isValid(r-1, c-1) && bombs.contains(buttons[r-1][c-1]))
            numBombs++;
        return numBombs;
    }
}