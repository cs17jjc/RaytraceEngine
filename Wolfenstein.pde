PVector Player = new PVector(200,200);
float Dir = 0;
int Fov = 45;
int SegWidth = 0;
PImage Map;
  
void setup(){
  size(640,480); 
  background(0);
  noStroke();
  Map = loadImage("MapImg.png");
  SegWidth = width/(2*Fov);
  println(SegWidth);
}


void draw(){
  background(100,100,100);
  fill(150,0,0);
  rect(0,height/2,width,height);
  //image(Map,0,0);
  //fill(0,255,0);
  //rect(Player.x,Player.y,10,5);
  for(int i = -1 * Fov; i < Fov; i++)
  {
   float Angle = DegToRad(Dir + i);
   boolean Hit = false;
   float RayX = 0;
   float RayY = 0;
   int Dist = 0;
   while(Hit == false)
   {
      RayX = Player.x + (Dist * cos(Angle));
      RayY = Player.y + (Dist * sin(Angle));
      //fill(255,0,0);
      //rect(RayX,RayY,1,1);
     if(alpha(Map.get((int)RayX,(int)RayY)) == 255)
     {
      Hit = true; 
     }
     else
     {
      Dist += 1;
     }
   }
   int CorDist = (int)(Dist * cos(DegToRad((float)i))); //Correct fisheye lensing.
   fill(150);
   int Height = floor(height/(1 + abs(CorDist)));
   rect((width/2) - ((i+1) * SegWidth),(height/2)-(Height/2),SegWidth,Height);
  }
  
  
}


void keyPressed(){
 if(key == 'd')
 {
  Dir += 5;
 }
 if(key == 'a')
 {
  Dir -= 5;
 }
 if(key == 'w')
 {
  Player.x += cos((Dir/180)*3.14);
  Player.y += sin((Dir/180)*3.14);
 }
 if(key == 's')
 {
  Player.x -= cos((Dir/180)*3.14);
  Player.y -= sin((Dir/180)*3.14);
 }
 
 if(key == 'q')
 {
  Player.x -= sin((Dir/180)*3.14);
  Player.y -= cos((Dir/180)*3.14);
 }
 if(key == 'e')
 {
  Player.x += sin((Dir/180)*3.14);
  Player.y += cos((Dir/180)*3.14);
 }
}

float DegToRad(float i)
{
 return (i/180)*PI;
}

PImage GetSeg(int X, int Y)
{
  
  
  
  return null;
  
}
