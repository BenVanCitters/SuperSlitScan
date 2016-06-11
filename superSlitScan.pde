import processing.video.*;
PGraphics backBuffer;
Movie movie;

void setup() 
{
  size(1000, 1000, P2D);
  
  initMovie("/Users/admin/Documents/Processing/componentColors/data/GOPR5008.MP4");
  
  backBuffer = createGraphics(17*300,1080,P3D);
  movieIncrementTm = movie.duration()/backBuffer.width; //1/70??
}

long lastDrawStart = 0;
void draw() 
{
  double elapsedSeconds = (System.nanoTime()-lastDrawStart)/(nanoSecondsPerSecond*1.0);
  println("draw diff seconds: " + elapsedSeconds);
  lastDrawStart = System.nanoTime();
  
  
//  image(movie, 0, 0, width, height);
grabLineAndDrawToBuffer();
  image(backBuffer,0,0,width,height);
  
  float tmRm = 1/(getPercentMovieComplete()/(millis()/1000.f));
  println("seconds remaining: " + tmRm + " frameRate: " + frameRate + " curMillis(): " + millis());
}


int currentBufferX;
double currentMovieTime = 0;

void grabLineAndDrawToBuffer()
{
  //  grabOneLine();
  //get pixel line
   if (!movie.available()) 
   { return; }
   
   PImage line = getPixelStripBetweenPts(movie, 
                                         new double[] {0,0},
                                         new double[] {1,1});
   if(currentBufferX < backBuffer.width)
    {
      backBuffer.beginDraw();
      backBuffer.image(line,currentBufferX,0);
      incrementMovieTime();
      currentBufferX++;
      backBuffer.endDraw();
    }
}


void grabOneLine()
{
  if(currentBufferX < backBuffer.width)
  {
    backBuffer.beginDraw();
    
    if (movie.available()) 
    {
      movie.loadPixels();
      backBuffer.loadPixels();
      for(int i = 0; i < movie.width; i++)
      {
        float normalizedMvIndex = i*1.0/movie.width;
        int mvIndex = movie.pixels.length-movie.width+i;
        float normalizedBufIndex = normalizedMvIndex * movie.height;
        int bufferIndex = backBuffer.width*(int)normalizedBufIndex+currentBufferX;
        if(bufferIndex < backBuffer.pixels.length)
          backBuffer.pixels[bufferIndex] = movie.pixels[mvIndex];
          else
          { 
  //          println("oh shit we fucked up? index:" + bufferIndex + " bufferpixLen: " +  backBuffer.pixels.length);
          }
      }
      
    incrementMovieTime();
    currentBufferX++;
    } 
    else
    {
      println("movie.available() returned false");
    }
    backBuffer.updatePixels();
    backBuffer.endDraw();
  }
  else
  {
    println("completed scan");
  }
}

void saveOutput
{
  backBuffer.save("superSlitScan-"+year()+"-"+month()+"-"+day()+":"+hour()+":"+minute()+":"+second()+":"+millis() +".png");
}
