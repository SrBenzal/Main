class StageViewer
{
  float posPlayerX;
  float posPlayerZ;
  
  Bombs bombs;
  
  int stageX;
  int stageZ;
  
  int screenX;
  int screenY;
  
  boolean twoScreens;
  
  float drawedStageWidth;
  float drawedStagePos;
  
  float previousPlayerPosX;
  float previousPlayerPosY;
  
  StageViewer(Bombs bms, int stageWidth, int stageDepth, int screenWidth, int screenHeight, boolean usingTwoScreens)
  {
     bombs = bms;
     
     stageX = stageWidth;
     stageZ = stageDepth;
     
     screenX = screenWidth;
     screenY = screenHeight;
     
     twoScreens = usingTwoScreens;
  }

  
  void atDraw(float realX, int closestValue)
  {
    drawedStageWidth =  (float)stageX/stageZ*480;
   
   if(twoScreens) 
   {
     drawedStagePos = screenX/2+(screenX/2-drawedStageWidth)/2;
   }
   else
   {
     drawedStagePos = (screenX-drawedStageWidth)/2;
   }
   
    
    float scale = drawedStageWidth/stageX; 
    
    stroke(208, 0, 0);
    strokeWeight(3);
    fill(70, 36, 0, 100);
    //rect(drawedStagePos , 0,  drawedStageWidth, screenY);
    
   // float maxZ = 
    
   triangle(realToScreenX(0f), realToScreenY(0f), realToScreenX(-(float)tan(radians(57)/2) * stageZ), realToScreenY((float)stageZ) , realToScreenX((float)tan(radians(57)/2) * stageZ), (float)realToScreenY(stageZ));
   
   image(perro,realToScreenX(0f)-perro.width/2, (realToScreenY(0f)-perro.height/2)- 20);
   perro.resize(100,75);
    
    for (int i=0; i < bombs.nBombs*2; i+=2)
    {
      float bx = realToScreenX( bombs.bombVector[i]);
      float bz = realToScreenY(bombs.bombVector[i+1]);
      
      strokeWeight(0);
      
      fill(255, 255, 0, 150);
      ellipse(bx, bz, bombs.alRange*2 *scale,bombs.alRange*2*scale);
      
      
      image(mina,bx-mina.width/2,bz-mina.height/2);
      
      int size = int(bombs.exRange*2 *scale);
      
      //mina.scale(size / mina.width, size / mina.width);
      
      mina.resize(size, size);
      
      /*
      fill(255, 0, 0);
      ellipse(bx, bz, bombs.exRange*2 *scale,bombs.exRange*2*scale);
      */
      
      
      
    }
    
      stroke(0, 208, 0);
      strokeWeight(2);
    
     fill(0, 255, 0);
     
     float playerPosX = drawedStagePos + ( realX + 2000) / stageX * drawedStageWidth;
     float playerPosY = screenY - ( (float)closestValue / stageZ) * screenY;
     
     playerPosX = lerp(playerPosX, previousPlayerPosX, 0.25);
     playerPosY = lerp(playerPosY, previousPlayerPosY, 0.25);
     
     ellipse(playerPosX, playerPosY, 200 *scale, 200*scale);
     
     previousPlayerPosX = playerPosX;
     previousPlayerPosY = playerPosY;
     
    
     fill(0); //Timer Color
  }
  
  float realToScreenX(float value)
  {
      return drawedStagePos + ( value + 2000) / stageX * drawedStageWidth;
  }
  
  float realToScreenY(float value)
  {
      return screenY - ( value / stageZ) * screenY;
  }
  
  
}
