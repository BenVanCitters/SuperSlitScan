
PImage getPixelStripBetweenPts(PImage frame, double[] pointNorm1, double[] pointNorm2)
{
  long startNanos = System.nanoTime();
  //distance in screen pixels
  double[] p1 = getImgXYFromNorm(pointNorm1);
  double[] p2 = getImgXYFromNorm(pointNorm2);
  double d = dist(p1[0],p1[1],
                  p2[0],p2[1]);
                  
  double dir[] = {p2[0]-p1[0],
                  p2[1]-p1[1]};
                 
  double frameStart[] = getImgXYFromNorm(pointNorm1);
//  dir = getImgXYFromNorm(dir);
  int lineDivisions = (int)(d*4);
//  println("lineDivisions: " + lineDivisions);
  double div[]={dir[0]/lineDivisions,
               dir[1]/lineDivisions};
               
//  println("len: " + div.length);
  PImage result = createImage(1,lineDivisions, RGB);
//   println("dir["+ dir[0] + "," + dir[1]+ "]");
//   println("pixelDistance: " + d);
  result.loadPixels();  
  frame.loadPixels();
  if(result.pixels.length > 0)
  {
    if(frame.pixels.length > 0)
    {
      for(int i = 0; i < lineDivisions; i++)
      {
        //lerp amount
        float pctThru = i*1.f/lineDivisions;
        //lerped position along line
        double pewPt[] = {frameStart[0] + dir[0]*pctThru,
                          frameStart[1] + dir[1]*pctThru,};
        //debug draw
//        fill(255,255,0); ellipse(pewPt[0]/8, pewPt[1]/8, 3, 3);
//        println("i= " + i + " imgStart["+ imgStart[0] + "," + imgStart[1]+ "]");
        
        //img xy index
        int frameIndex = (int)(frameStart[0] + (int)(frameStart[1])*frame.width); 
        if(frameIndex >= 0 && frameIndex < frame.pixels.length)
        { 
          result.pixels[i] = frame.pixels[frameIndex];
        }
//        else
//        { println("problem?"); }

        frameStart[0]+=div[0];
        frameStart[1]+=div[1];
      }
//      println("we got this far");
    }
    else
    {
      println("wtf, img.pixels is not there?!?!"); 
    }
    result.updatePixels();
  }
  else
  {
   println("wtf, tmp.pixels is not there?!?!"); 
  }
  double elapsedSeconds = (System.nanoTime()-startNanos)/(nanoSecondsPerSecond*1.0);
  println("getPixelStripBetweenPts elapsedSeconds: " + elapsedSeconds);
  return result;
//  float imgH = 500;
//  image(result,0,height-imgH,width,imgH);
}
long nanoSecondsPerSecond = 1000000000;
