  import SimpleOpenNI.*;
  SimpleOpenNI  kinect;
  
  float vectorBooms[] = new float[12];
  float range = 500;
  float realX;
  
  int nBooms = 1;
  
  //Sonido
  
  import ddf.minim.*;
  
  Minim minim;
  AudioPlayer bomb;
  
  void setup()
  {
    size(640, 480);
    kinect = new SimpleOpenNI(this);
    kinect.enableDepth();  
    
    //Sonido
    
    minim = new Minim(this);
    bomb = minim.loadFile("Dob_Crying.mp3");
  }
  
  void draw()
  {
    int closestValue = 8000;
    int currentX = 0;
    float realAngle;

    int maxZ=5000;
  
    kinect.update();
  
    int[] depthValues = kinect.depthMap();
  
      for (int x = 0; x < 640; x++) {
        int i = x + 240 * 640;
        int currentDepthValue = depthValues[i];
  
        if (currentDepthValue > 0 && currentDepthValue < closestValue) {
          closestValue = currentDepthValue;
          currentX = x;
        }
    }
    
    realAngle = radians(57) / 640 * (currentX - 320);
    realX =tan(realAngle)*closestValue;
  
    image(kinect.depthImage(), 0, 0);
  
    fill(255, 0, 0);
    ellipse(currentX, 240, 25, 25);
   // println("CURRENTX: " + currentX, "REAL X: " + realX, "Z: "+closestValue);
    
    if(closestValue >= maxZ){
    
       bomb.play();
       bomb.rewind();
    }
  }
  
  void createVectorBooms()
  {
    for (int aux=0; aux < nBooms * 2; aux+=2)
    {
      vectorBooms[aux]=random((float)-2000.0,(float)2000.0);
      vectorBooms[aux+1]=random(1000, 5000);
    
      println("BOOM X: " +  vectorBooms[aux], "BOOM Z: " + vectorBooms[aux+1]);
      
    }
  }
  
  boolean checkBoom()
  {
    for (int aux=0;aux< nBooms * 2;aux+=2)
    {
      
      float dx = realX - vectorBooms[aux];
      float dz = realZ - vectorBooms[aux+1];
        
      float distance=sqrt(dx*dx+dz*dz);
  
      if (distance < range)
      {
        //BOOM
      }
    }
  }
  

