class Timer
{
  int startSeconds;
  int secs;
  int maxSeconds;
  

  boolean stopped = true;

  Timer(int maxTime)
  {
      maxSeconds = maxTime;
  }
  
  void start()
  {
     startSeconds = second();
     stopped = false;
  }
  
  void stop()
  {
    stopped = true;
  }
  
  boolean isTimeOver()
  {
    if(!stopped)
    {
      secs = second();
      
      print(secs - startSeconds + "\n");
      if(secs - startSeconds > maxSeconds)
      {
        stopped = true;
        return true;
      }
    }
    return false;
  }
}


