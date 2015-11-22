class Timer
{
  int startSeconds;
  int secs;
  int maxSeconds;
  
  
  Timer(int maxTime)
  {
      maxSeconds = maxTime;
  }
  
  void start()
  {
     startSeconds = seconds();
     stopped = false;
  }
  
  void stop()
  {
    stopped = true;
  }
  
  bool isTimeOver()
  {
    if(!stopped)
    {
      secs = seconds();
      
      if(secs - startSeconds > maxSeconds)
      {
        return true;
      }
      return false;
    }
  }
}


