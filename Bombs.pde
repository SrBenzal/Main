//FALTA HACER QUE NO SEA UN RECTANGULO, SI NO UN TRIANGULO


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
    
    for (int i=0; i < nBombs*2; i+=2)
    {
        z = random(1000f, 5000f);
        
        maxX = (float)tan(radians(57)/2) * z;
        
        bombVector[i] = random(-maxX,maxX);
        bombVector[i+1] = z;

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

 
  
