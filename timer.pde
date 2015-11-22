class Timer
{
  int startFrame;
  int secs;
  int maxSeconds;
  int tiempoActual;
  int tiempoAnterior;
  

  boolean stopped = true;

  Timer(int maxTime)
  {
      maxSeconds = maxTime;
  }
  
  void start()
  {
     tiempoAnterior = maxSeconds;
     startFrame = frameCount;
     stopped = false;
  }
  
  void stop()
  {
    stopped = true;
  }
  
  boolean isTimeOver()
  {
    tiempoActual = maxSeconds - secs;
    
    
    if(!stopped)
    {
      
      secs = (int) ((frameCount - startFrame) / frameRate);
      
      tiempoActual = maxSeconds - secs;
      
      if (tiempoAnterior < tiempoActual)
        tiempoActual = tiempoAnterior;
      
      textSize(32);
      text(tiempoActual, screenWidth - 100, screenHeight - 28);
      
      
      //print(secs - startSeconds + "\n");
      if(secs > maxSeconds)
      {
        stopped = true;
        return true;
      }
      tiempoAnterior = tiempoActual;
      
    }
    return false;
  }
}


