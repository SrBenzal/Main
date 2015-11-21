import SimpleOpenNI.*;
SimpleOpenNI  kinect;

void setup()
{
  size(1024, 768);
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();  
}

void draw()
{
/*  kinect.update();

  PImage depthImage = kinect.depthImage();
  image(depthImage, 0, 0);*/
  
  // declare these within the draw loop
  // so they change every time
  int closestValue = 8000;
  int currentX = 0;
  int currentY = 0;

  kinect.update();

  // get the depth array from the kinect
  int[] depthValues = kinect.depthMap();

  // for each row in the depth image
  for (int y = 0; y < 480; y++) {
    // look at each pixel in the row
    for (int x = 0; x < 640; x++) {
      // pull out the corresponding value from the depth array
      int i = x + y * 640;
      int currentDepthValue = depthValues[i];

      // if that pixel is the closest one we've seen so far
      if (currentDepthValue > 0 && currentDepthValue < closestValue) {
        // save its value
        closestValue = currentDepthValue;
        // and save its position (both X and Y coordinates)
        currentX = x;
        currentY = y;
      }
    }
  }

  // closestX and closestY become
  // a running average with currentX and currentY
  closestX = (closestX + currentX) / 2;
  closestY = (closestY + currentY) / 2;

  //draw the depth image on the screen
  image(kinect.depthImage(), 0, 0);

  // draw a red circle over it, 
  // positioned at the X and Y coordinates 
  // we saved of the closest pixel.
  fill(255, 0, 0);
  ellipse(closestX, closestY, 25, 25);
}

void mousePressed(){
  int[] depthValues = kinect.depthMap();
  int clickPosition = mouseX + (mouseY * 640);
  int clickedDepth = depthValues[clickPosition];
  
  float inches = clickedDepth / 25.4;
  
  println("inches: " + inches);
}

