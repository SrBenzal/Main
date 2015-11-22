  import SimpleOpenNI.*;
  SimpleOpenNI  kinect;
  import ddf.minim.*; //Sonido
    
   //Stage & Screen
   int stageWidth = 4000;
   int stageDepth = 5000;
   
   int screenWidth = 1280;
   int screenHeight = 480;
   
    
  //Position
  float realX;
  int closestValue;
  
  //Sonido
  Minim minim;
  AudioPlayer bomb;
  
  //Bombs
  Bombs bombs;
  
  //Stage viewer
  StageViewer stageViewer;
  
  
  void setup()
  {
    size(screenWidth, screenHeight);
    
    //Kinect
  //  kinect = new SimpleOpenNI(this);
   // kinect.enableDepth();  
    
    //Sonido
    minim = new Minim(this);
    bomb = minim.loadFile("Dob_Crying.mp3");
    
    //Bombs
    bombs = new Bombs(5, 200, 500);
    
    //StageViewer
    stageViewer = new StageViewer(bombs, stageWidth, stageDepth, screenWidth, screenHeight, true);
  }
  
  void draw()
  {
    closestValue = 8000;
    int currentX = 0;
    float realAngle;

    int maxZ = 5000;
  
    //kinect.update();
  
   // int[] depthValues = kinect.depthMap();
  
      /*for (int x = 0; x < 640; x++) {
        int i = x + 240 * 640;
        int currentDepthValue = depthValues[i];
  
        if (currentDepthValue > 0 && currentDepthValue < closestValue) {
          closestValue = currentDepthValue;
          currentX = x;
        }
    }*/
    
    realAngle = radians(57) / 640 * (currentX - 320);
    realX =tan(realAngle)*closestValue;
  
    //image(kinect.depthImage(), 0, 0);
  
    fill(255, 0, 0);
    ellipse(currentX, 240, 25, 25);
   // println("CURRENTX: " + currentX, "REAL X: " + realX, "Z: "+closestValue);
    
    if(closestValue >= maxZ)
    {
       bomb.play();
       bomb.rewind();
    }
    
    stageViewer.atDraw(realX, closestValue);

    
    if(bombs.checkBombs(realX, closestValue))
    {
       println("BOOOM");
    }
  }
  
  

