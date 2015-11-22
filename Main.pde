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
  AudioPlayer DogCrying;
  AudioPlayer DogBarking;
  AudioPlayer Beep;
  AudioPlayer Victory;
  AudioPlayer explosion;
  
  //Imagenes
  PImage fondo_tiempo;
  PImage dead;
  PImage found;
  PImage mina;
  PImage perro;
  PImage intro;
  PImage inicio;
  
  //Bombs
  Bombs bombs;
  
  //Stage viewer
  StageViewer stageViewer;
  
  //Limites
  int maxZ = stageWidth;
  int minZ = 1000;
  float maxX; 
  
  //Pantallas
  int screen = 0;
  
  Timer timer;
  
  void setup()
  {
    size(screenWidth, screenHeight);
    
    //Kinect
    kinect = new SimpleOpenNI(this);
    kinect.enableDepth();  
    
    //Sonido
    minim = new Minim(this);
    DogCrying = minim.loadFile("Dob_Crying.mp3");
    DogBarking = minim.loadFile("Dog_Barking.mp3");
    Beep = minim.loadFile("Beep.mp3");
    Victory = minim.loadFile("Victory.mp3");
    explosion = minim.loadFile("explosion.mp3");
    
    //Imagenes
    fondo_tiempo = loadImage("fondo_tiempo.jpg");
    dead = loadImage("dead.jpg");
    found = loadImage("found.jpg");
    mina = loadImage("mina.png");
    perro = loadImage("perro.png");
    intro = loadImage("intro.jpg");
    inicio = loadImage("inicio.jpg");
    
    //Bombs
    bombs = new Bombs(5, 200, 500);
    
    //StageViewer
    stageViewer = new StageViewer(bombs, stageWidth, stageDepth, screenWidth, screenHeight, true);
    
    //Timer
    timer = new Timer(120);
    timer.start();
  }
  
  void draw()
  {
    background(255);
    
    //Dibujar Imagenes en Pantalla
    image(fondo_tiempo,screenWidth/2,0);
    fondo_tiempo.resize(screenWidth/2,screenHeight);
    closestValue = 8000;
    int currentX = 0;
    float realAngle;

    int maxZ = 5000;
  
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
    
    //Limites pantalla
    
    maxX = tan(radians(57/2)) * closestValue - 200;
    
    if(closestValue >= maxZ || realX > maxX || realX < - maxX && closestValue > minZ)
    {
      
      if(!DogCrying.isPlaying()){
        
        DogCrying.play();
        DogCrying.rewind();
      
      }
       
    }
    if(closestValue <= minZ)
    {
      
      if(!Victory.isPlaying()){
        
        Victory.play();
      
      }
    }
    
    
    stageViewer.atDraw(realX, closestValue);
    

    if(bombs.checkBombsAlarm(realX, closestValue))
    {
       //println("WARNING!");
      
      if(!Beep.isPlaying()){
        
        Beep.play();
        Beep.rewind();
      
      }
       
       if(bombs.checkBombsExplosion(realX, closestValue))
      {
        // println("BOOOM");
        if(!explosion.isPlaying()){
        
        explosion.play();
      
        }
      }
    }
    else
    {
      //println("NO PROBLEM");
    }
    
   if( timer.isTimeOver())
   {
     print("TIEMPO ACABADO");
   }
  
}



void GameOver(boolean win){
  
  //true- win  false- bomb
  
  if(win){
  
    
    }

}
  
  

