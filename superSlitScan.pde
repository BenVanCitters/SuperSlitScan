import processing.video.*;
PGraphics backBuffer;
Movie movie;

void setup() 
{
  size(1000, 1000, P2D);
  
  initMovie("/Users/admin/Documents/Processing/componentColors/data/GOPR5008.MP4");
  
  backBuffer = createGraphics(6391,975,P3D);
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
                                         new double[] {0,1},
                                         new double[] {1,0});
   if(currentBufferX < backBuffer.width)
    {
      backBuffer.beginDraw();
      backBuffer.image(line,currentBufferX,0,1,backBuffer.height);
      incrementMovieTime();
      currentBufferX++;
      backBuffer.endDraw();
    }
}

void saveOutput()
{
  String fileName = "superSlitScan-"+year()+"-"+month()+"-"+day()+":"+hour()+":"+minute()+":"+second()+":"+millis() +".png";
  backBuffer.save(fileName);
  println("File saved!: " + fileName);
}
