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
    float drawedStageWidth =  (float)stageX/stageZ*480;
    
    float drawedStagePos;
   
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
    rect(drawedStagePos , 0,  drawedStageWidth, screenY);
    

    
    for (int i=0; i < bombs.nBombs*2; i+=2)
    {
      float bx = drawedStagePos + ( bombs.bombVector[i] + 2000) / stageX * drawedStageWidth;
      float bz = screenY - ( bombs.bombVector[i+1] / stageZ) * screenY;
      
      fill(255, 255, 0);
      ellipse(bx, bz, bombs.alRange*2 *scale,bombs.alRange*2*scale);
      
      fill(255, 0, 0);
      ellipse(bx, bz, bombs.exRange*2 *scale,bombs.exRange*2*scale);
    }
    
     fill(0, 255, 0);
     ellipse(drawedStagePos + ( realX + 2000) / stageX * drawedStageWidth, screenY - ( (float)closestValue / stageZ) * screenY, 200 *scale, 200*scale);
    
  }
  
  
  
}
