import processing.video.*;
PGraphics backBuffer;
Movie movie;
LogWrap logger;

void setup() 
{
  size(700, 700, P2D);
  logger = new LogWrap(getClass().getSimpleName());
  
  initMovie("/Users/admin/Documents/Processing/componentColors/data/GOPR5008.MP4");
  
  backBuffer = createGraphics(6391,975,P3D);
  movieIncrementTm = movie.duration()/backBuffer.width; //1/70??
  
}

long lastDrawStart = 0;
void draw() 
{
  double elapsedSeconds = (System.nanoTime()-lastDrawStart)/(nanoSecondsPerSecond*1.0);
  logScr("draw diff seconds: " + elapsedSeconds);
  lastDrawStart = System.nanoTime();
  
  background(0);
//  image(movie, 0, 0, width, height);
  grabLineAndDrawToBuffer();
  image(backBuffer,0,0,width,height);
  
  float tmRm = 1/(getPercentMovieComplete()/(millis()/1000.f));
  logScr("seconds remaining: " + tmRm + " frameRate: " + frameRate + " curMillis(): " + millis());
  logger.flushLogs();
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
  logCon("File saved!: " + fileName);
}

void logCon(String s)
{
  logger.addLog(s, LOG_TYPE_CONSOLE | LOG_TYPE_FILE);
}

void logScr(String s)
{
  logger.addLog(s, LOG_TYPE_SCREEN | LOG_TYPE_FILE);
}
void log(String s)
{
  logger.addLog(s, LOG_TYPE_SCREEN | LOG_TYPE_FILE | LOG_TYPE_CONSOLE);
}
