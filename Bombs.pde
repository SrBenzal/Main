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
    
    for (int i=0; i < nBombs*2; i+=2)
    {
       bombVector[i] = random(-2000f,2000f);
       bombVector[i+1] = random(1000f, 5000f);
    }
  }
  
  boolean checkBombs(float realX, float closestValue)
  {
     for (int i=0; i< nBombs * 2; i+=2)
     {
        float dx = realX - bombVector[i];
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
  
}
