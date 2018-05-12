


PVector Player = new PVector(3,5);
float Dir = 0;
float Fov = 45;
int Segments = 1;
int SegWidth = 0;

PImage Wall;
  
void setup(){
  size(640,480); 
  background(0);
  noStroke();
  Wall = loadImage("Wall1.png");
  SegWidth = (int)(width/(Wall.width/Segments));
}


void draw(){
  background(0);
  for(float i = -1*Fov; i <= Fov; i += Segments)
  {
     float Angle = Dir + i;
     int Dist = 0;
     boolean hit = false;
     float CosX = cos((Angle/180)*3.14);
     float SinY = sin((Angle/180)*3.14);
     float X = 0;
     float Y = 0;
     while(hit == false){
       X = Player.x + (Dist * CosX);
       Y = Player.y + (Dist * SinY);
       //println(X + " + " + Y);
       if(MapData.Data[(int)X][(int)Y] != 0)
       {
          hit = true;
          if(MapData.Data[(int)X][(int)Y] == 1){
             DrawSegment(color(255,0,0),Dist,i);
          }
          if(MapData.Data[(int)X][(int)Y] == 2){
             DrawSegment(color(255,150,150),Dist,i);
          }
       }
       else
       {
         fill(255,0,0);
         rect(X * 5,Y * 5,5,5);
        Dist ++;
       }
     }
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

void DrawSegment(color c,int Dist,float i)
{
  fill(c);
  float Height = (100/Dist) * (height/100);
  image(Wall,(i + Fov)*Wall.width,(height/2)-(Height/2),SegWidth,Height);
}

















