class Bombs
{
  int nBombs;
  float bombVector[];
    
  float exRange;
  float alRange;
  

  Bombs(int numberOfBombs, int explosionRange, int alarmRange)
  {
      nBombs = numberOfBombs;
      exRange = explosionRange;
      alRange = alarmRange;
      
      createBombVector();
  }
  
  void createBombVector()
  {
    bombVector = new float[nBombs*2];
    
    float z;
    float x;
    
    float maxX;
    
    int i = 0;
    
    while(i < nBombs * 2)
    {
        z = random(1000f, 5000f);
        
        maxX = (float)tan(radians(57)/2) * z;
        
        x = random(-maxX,maxX);
        
        int j = 0;
        
        boolean correctPos = true;
        
        while(j < i)
        {
          float dx = (float) x - bombVector[j];
          float dz = (float) z - bombVector[j+1];
          
          float distance=sqrt(dx*dx+dz*dz);
          
          if(distance < alRange * 3)
          {
            correctPos = false;
          }
          
          j += 2;
        }
        
        if(correctPos)
        {
            bombVector[i] = x;
            bombVector[i+1] = z;
            i+= 2;
        }
    }
  }
  
  boolean checkBombsExplosion(float realX, float closestValue)
  {
     for (int i=0; i< nBombs * 2; i+=2)
     {
        float dx = (float) realX - bombVector[i];
        float dz = (float) closestValue - bombVector[i+1];
          
        float distance=sqrt(dx*dx+dz*dz);
    
        boolean result;
    
        if(distance < exRange)
        {
          return true;
        }
     }
     return false;
  }
  
  boolean checkBombsAlarm(float realX, float closestValue)
  {
     for (int i=0; i< nBombs * 2; i+=2)
     {
        float dx = (float) realX - bombVector[i];
        float dz = (float) closestValue - bombVector[i+1];
          
        float distance=sqrt(dx*dx+dz*dz);
    
        boolean result;
        
        if(distance < alRange)
        {
          return true;
        }
     }
     return false;
  }  
}

 
  
