import SimpleOpenNI.*;
SimpleOpenNI  kinect;
float posPlayerX;
float posPlayerZ;

int bombas=10;

float vectorBooms[] = new float[bombas*2];

void createVectorBooms(){
  /*for (int i=0; i < bombas*2; i+=2)
  {
    vectorBooms[i]=random(-2000f,2000f);
    vectorBooms[+1]=random(1000f, 5000f);
  }*/
  vectorBooms[0]=0;
  vectorBooms[1]=2500;
}

void setup()
{
  size(640,480);
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();  
}

void draw(){
  //ellipse(1000,500,100,100);
  fill(255,255,0);
  //for (int i=0; i < bombas*2; i+=2)
  {
    float bx = 640 + (vectorBooms[0] + 2000) / 4000 * 640;
    float bz = vectorBooms[1] / 5000 * 480;
    ellipse(320,240,50,50);
  }
  
}
