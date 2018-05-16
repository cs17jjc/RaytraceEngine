PVector Player = new PVector(200,200);
float Dir = 0;
int Fov = 45;

PImage Map;
  
void setup(){
  size(640,480); 
  background(0);
  noStroke();
  Map = loadImage("MapImg.png");
}


void draw(){
  background(0,0,255);
  image(Map,0,0);
  fill(0,255,0);
  rect(Player.x,Player.y,10,5);
  for(int i = -1 * Fov; i < Fov; i++)
  {
   float Angle =((Dir + i)/180)*PI;
   boolean Hit = false;
   float RayX = 0;
   float RayY = 0;
   int Dist = 0;
   while(Hit == false)
   {
      RayX = Player.x + (Dist * cos(Angle));
      RayY = Player.y + (Dist * sin(Angle));
      fill(255,0,0);
      rect(RayX,RayY,1,1);
     if(alpha(Map.get((int)RayX,(int)RayY)) == 255)
     {
      Hit = true; 
     }
     else
     {
      Dist += 1;
     }
   }
   float CosI = cos(((float)i/180)*PI);
   int CorDist = (int)(Dist * CosI); //Correct fisheye lensing.
   fill(CorDist%255,0,0);
   rect(RayX-5,RayY-5,10,10);
   fill(150);
   float Height = (1000/CorDist) * (height/100);
   rect((width/2) + (i * 2),(height/2)-(Height/2),2,Height);
   
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
