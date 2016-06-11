
float getPercentMovieComplete()
{
  return (float)currentMovieTime/movie.duration();
}

double movieIncrementTm=0;

void initMovie(String mvFilePath)
{
//  String mvFilePath = "/Volumes/Ben's Pictures/samsung galaxy s6 active/april trip to amsterdam and SF/videos/pans/20160430_130833.mp4";
  ///Volumes/Ben\'s\ Pictures/samsung\ galaxy\ s6\ active/april\ trip\ to\ amsterdam\ and\ SF/videos/pans/20160426_120149.mp4
  movie = new Movie(this, mvFilePath);
  movie.play();
  movie.jump(0.0);
  movie.pause();
  movie.read();
  logCon("opened movie with size (wxh): (" + movie.width + "x" + movie.height + ")");
  long mFrameCount = (long)(movie.duration()*getVideoFrameRate());
  logCon("movie duration(sec): " + movie.duration() + "(" + mFrameCount + " frames)" );
//   movieIncrementTm = movie.duration()/backBuffer.width; //1/70??
}

// does this even ever get called??? ...what is the event???
void movieEvent(Movie m) 
{
//  println("movieEvent got called");
//  m.read();
}

long curMovieFrame = 0;
void incrementMovieTime()
{
  currentMovieTime += movieIncrementTm;
  long newFrameNum = (long)(currentMovieTime*getVideoFrameRate());
  if(newFrameNum != curMovieFrame)
  {
    curMovieFrame = newFrameNum;
    movie.play();
    movie.jump((float)currentMovieTime);
    movie.pause();
    logCon("currentMovieTime: " + currentMovieTime + " curMovieFrame: " + curMovieFrame);
  }
  logCon("currentMovieTime/30.01 = " + currentMovieTime*getVideoFrameRate());
//  println("XXXXXXXXX currentMovieTime: " + currentMovieTime + " newFrameNum: " + newFrameNum + " curMovieFrame: " + curMovieFrame);
}

double getVideoFrameRate()
{
  return 119.87;
}
