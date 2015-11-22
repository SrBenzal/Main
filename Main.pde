  import SimpleOpenNI.*;
  SimpleOpenNI  kinect;
  import ddf.minim.*; //Sonido
    
  //Stage & Screen
  int stageWidth = 4000;
  int stageDepth = 4000;
   
  int screenWidth = 800;
  int screenHeight = 600;
  
  //Position
  float realX;
  int closestValue;
  
  //Sonido
  Minim minim;
  AudioPlayer DogCrying;
  AudioPlayer DogBarking;
  AudioPlayer Beep;
  AudioPlayer Victory;
  AudioPlayer Dogs_Victory;
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
  int maxZ = stageDepth;
  int minZ = 1000;
  float maxX; 
  
  //Pantallas
  int screen = 0;
  
  boolean win;
  
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
    Dogs_Victory = minim.loadFile("Dogs_Victory.mp3");
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
    bombs = new Bombs(5, 200, 500, minZ, maxZ);
    
    //StageViewer
    stageViewer = new StageViewer(bombs, stageWidth, stageDepth, screenWidth, screenHeight, false);
    
    //Timer
    timer = new Timer(120);
  }
  
  void draw()
  {
    background(255);
    
    switch(screen){
  
        case 0:
            image(intro,0,0);
            intro.resize(screenWidth,screenHeight);
            break;
            
        case 1:
            image(inicio,0,0);
            inicio.resize(screenWidth,screenHeight);
            break;
      
        case 2://Dibujar Imagenes en Pantalla
            image(fondo_tiempo,0,0);
            fondo_tiempo.resize(screenWidth,screenHeight);
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
          
            //image(kinect.depthImage(), 0, 0);
          
            //fill(255, 0, 0);
            //ellipse(currentX, 240, 25, 25);
           // println("CURRENTX: " + currentX, "REAL X: " + realX, "Z: "+closestValue);
            
            //Limites pantalla
            
            maxX = tan(radians(57/2)) * closestValue - 200;
            
            if(closestValue >= maxZ || realX > maxX || realX < - maxX && closestValue > minZ)
            {
              
              if(!DogCrying.isPlaying() && screen == 2){
                
                  DogCrying.play();
                  DogCrying.rewind();
              
              }
               
            }
            else{
              if(!DogBarking.isPlaying() && screen == 2){
                
                DogBarking.play();
                DogBarking.rewind();
              
              }
            }
                
            if(closestValue <= minZ)
            {
              
              {
                  if(!Victory.isPlaying()){
                  Victory.play();
                  win = true;
                  screen = 3;   
                  }
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
                    win = false;
                    screen = 3;
              
                }
              }
            }
            else
            {
              //println("NO PROBLEM");
            }
            
           if( timer.isTimeOver())
           {
              explosion.play();
              win = false;
              screen = 3;
           }
          break;
  
    case 3:
          
          if (!Dogs_Victory.isPlaying()) Dogs_Victory.play();
    
          if (win){
                image(found,0,0);
                found.resize(screenWidth,screenHeight);
                break;
          }
          else{
                image(dead,0,0);
                dead.resize(screenWidth,screenHeight);
                break;
          }
          
    }
    
    println("Pantalla: " + screen);
    
  
}
  
void mousePressed(){
 
 screen += 1;
 if (screen > 3) screen = 1;
 if (screen == 2)
{
  Victory.rewind();
  explosion.rewind();
  timer.start();
}
  
} 

