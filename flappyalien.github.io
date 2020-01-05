PImage bg, alien, topPipe, botPipe;
int bgx, bgy, kx, ky, g, Vky;
int[] pipeX, pipeY;
int gameState, score;
void setup()
{
  size(1200,780);
  bg = loadImage("./tools/otherbg.png");
  alien = loadImage("./tools/alien.png");
  botPipe = loadImage("./tools/botpipe.png");
  topPipe = loadImage("./tools/toppipe.png");
  kx = 100;
  ky = 50;
  g = 1;
  pipeX = new int[4]; //[0,0,0,0]
  pipeY = new int[pipeX.length];
  
  for(int i = 0; i < pipeX.length; i++)
  {
    pipeX[i] = width + 350*i;
    pipeY[i] = (int)random(-350, 0);
  }
  gameState = -1;
    
}
void draw()
{
  if(gameState == -1)
  {
    startScreen();
  }
  else if(gameState==0)
  {
  setBg();
  alien();
  setPipes(); 
  points();
  
  }
  else
  {
    fill(255, 0, 0);
    text("YOU LOSE!!", 20, 100);
  }
 }

void mousePressed()
{
  Vky = -20;
  
}
void setBg()
{
  image(bg, bgx, bgy);
  image(bg, bgx + bg.width, bgy);
  bgx = bgx - 1;
  if(bgx < -bg.width)
  {
    bgx = 0;
  }
}
void alien()
{
  image(alien, kx, ky);
  ky = ky + Vky;
  Vky++;
  if(ky > height || ky < 0)
  {
    text("Kirby fell off the screen!!", 40, 34);
    gameState=1;
  }
}
void setPipes()
{
  for(int i = 0; i < pipeX.length; i++)
  {
   image(topPipe, pipeX[i], pipeY[i]);
   image(botPipe, pipeX[i], pipeY[i] + 780);
   pipeX[i]-= 5;
   if(pipeX[i] < -200)
   {
     pipeX[i] = width;
   }
   if(kx > (pipeX[i]-45) && kx < pipeX[i] + 113)
   {
     if(!(ky > pipeY[i]-38 + 500 && ky < pipeY[i] + (500 + 320-49)))
     {
       gameState = 1;
     }
     else if(kx==pipeX[i] || kx == pipeX[i] + 1)
     {
       score++;
     }
     
   }
  }
}
void points()
{
  fill(0);
  textSize(32);
  text("Score: " + score, width - 170, 40);
}
void startScreen()
{
  fill(0);
  image(bg, 0, 0);
  textSize(50);
  text("Welcome To FlappyAlien!!", 40, 100);
  text("Click Anywhere to Start Game...:)", 40, 200);
  if(mousePressed)
  {
    ky = height/2;
    gameState = 0;
    
  }
}
