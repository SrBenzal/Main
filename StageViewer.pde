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
    
    fill(255, 255, 255);
    //rect(drawedStagePos , 0,  drawedStageWidth, screenY);
    
   // float maxZ = 
    
   triangle(realToScreenX(0f), realToScreenY(0f), realToScreenX(-(float)tan(radians(57)/2) * stageZ), realToScreenY((float)stageZ) , realToScreenX((float)tan(radians(57)/2) * stageZ), (float)realToScreenY(stageZ));
    

    
    for (int i=0; i < bombs.nBombs*2; i+=2)
    {
      float bx = realToScreenX( bombs.bombVector[i]);
      float bz = realToScreenY(bombs.bombVector[i+1]);
      
      fill(255, 255, 0);
      ellipse(bx, bz, bombs.alRange*2 *scale,bombs.alRange*2*scale);
      
      fill(255, 0, 0);
      ellipse(bx, bz, bombs.exRange*2 *scale,bombs.exRange*2*scale);
    }
    
     fill(0, 255, 0);
     ellipse(drawedStagePos + ( realX + 2000) / stageX * drawedStageWidth, screenY - ( (float)closestValue / stageZ) * screenY, 200 *scale, 200*scale);
    
  }
  
  float realToScreenX(float value)
  {
      return drawedStagePos + ( value + stageX/2) / stageX * drawedStageWidth;
  }
  
  float realToScreenY(float value)
  {
      return screenY - ( value / stageZ) * screenY;
  }
  
  
}
