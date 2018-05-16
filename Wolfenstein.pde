PVector Player = new PVector(200,200);
float Dir = 0;
float Fov = 45;
int Segments = 1;
int SegWidth = 0;

PImage Map;
  
void setup(){
  size(640,480); 
  background(0);
  noStroke();
  Map = loadImage("MapImg.png");
  SegWidth = (int)(width/(2*Fov/Segments));
}


void draw(){
  background(0,0,255);
  float PrevX = -1;
  float PrevY = -1;
  int CumulativeX = 0;
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
       if(alpha(Map.get((int)X,(int)Y)) != 0)
       {
          hit = true;
       }
       else
       {
         fill(255,0,0);
         rect(X,Y,1,1);
         Dist ++;
       }
     }
     
     
     
     if(PrevX == -1 || PrevY == -1){
      PrevX = X;
      PrevY = Y; 
     }
     else{
       PImage seg = getSeg(new PVector(X,Y), new PVector(PrevX,PrevY));
       float DrawHeight = (1000/(1 + Dist)) * (height/100);
       image(seg,CumulativeX,(height/2) - (DrawHeight/2),seg.width,DrawHeight);
       CumulativeX += seg.width;
       //println(DrawHeight);
       //image(seg,X,Y - seg.height,seg.width,seg.height);
       
       PrevX = X;
       PrevY = Y; 
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
  rect((i + Fov)*SegWidth,(height/2)-(Height/2),SegWidth,Height);
}

PImage getSeg(PVector p1, PVector p2)
{
  int ClearX = 0;
  int ClearY = 0;
  PImage img = createImage(0,0,RGB);
  for(int x = -1; x < 2;x++)
  {
    for(int y = -1; y < 2;y++)
    {
       if(x == 0 || y == 0)
       {
        if(alpha(Map.get((int)(p1.x + x),(int)(p1.y + y))) == 0){
           ClearX = x;
           ClearY = y;
        }
       }
    }
  }
  //println(ClearX + " : " + ClearY);
  boolean EndSeg = false;
  PVector TopPoint = p1.copy();
  if(ClearX == 0 && ClearY == 1)
  {
    while(EndSeg == false)
    {
      if(alpha(Map.get((int)TopPoint.x,(int)TopPoint.y)) == 0)
      {
       EndSeg = true;
      }
      else{
       TopPoint.y --; 
      }
    }
    img = Map.get((int)p1.x,(int)TopPoint.y,1 + (int)(p1.x - p2.x),(int)(p1.y - TopPoint.y));
  }
  
  if(ClearX == -1 && ClearY == 0)
  {
    while(EndSeg == false)
    {
      if(alpha(Map.get((int)TopPoint.x,(int)TopPoint.y)) == 0)
      {
       EndSeg = true;
      }
      else{
       TopPoint.x ++; 
      }
    }
    img = Map.get((int)p1.x,(int)p1.y,(int)(TopPoint.x - p1.x),(int)(p1.y - p2.y));
  }
  
  
  return img;
}
