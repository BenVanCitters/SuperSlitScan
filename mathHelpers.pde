void ellipse(double x, double y, double r1, double r2)
{
  ellipse((float)x,(float)y,(float)r1,(float)r2);
}

double dist(double x1, double y1, double x2, double y2)
{
  double x = (x1-x2);
  double y = (y1-y2);
  return java.lang.Math.sqrt(x*x+y*y);
}
double[] getNormXYFromWind(double[] wind)
{ return new double[]{wind[0]*1.0/width,wind[1]*1.0/height};}

double[] getWindXYFromNorm(double[] norm)
{ return new double[]{norm[0]*width,norm[1]*height};}

double[] getImgXYFromNorm(double[] norm)
{ return new double[]{norm[0]*movie.width,norm[1]*movie.height};}

double[] getImgXYFromWind(double[] wind)
{ return new double[]{wind[0]*movie.width*1.f/width,wind[1]*movie.height*1.f/height};}

double[] getNormXYFromImg(double[] imgp)
{   return new double[]{imgp[0]*1.f/movie.width,imgp[1]*1.f/movie.height};}

