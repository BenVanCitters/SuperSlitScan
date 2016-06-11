static final int LOG_TYPE_FILE = 1;
static final int LOG_TYPE_CONSOLE = 2;
static final int LOG_TYPE_SCREEN = 4;

class LogWrap
{
  
  String fileName;
  String appName;
  PrintWriter output;
  ArrayList<String> logScrBuffer = new ArrayList<String>();
  ArrayList<String> logConsoleBuffer = new ArrayList<String>();
  ArrayList<String> logFileBuffer = new ArrayList<String>();
  public LogWrap()
  {
    appName = "unknownApp";
    fileName = "LogSuperSlitScan-"+year()+"-"+month()+"-"+day()+":"+hour()+":"+minute()+":"+second()+":"+millis() +".txt";
    output = createWriter(fileName);
  }
  public LogWrap(String appname)
  {
    appName = appname;
    //open new 'run' file
    fileName = "LogSuperSlitScan-"+year()+"-"+month()+"-"+day()+":"+hour()+":"+minute()+":"+second()+":"+millis() +".txt"; 
    output = createWriter(fileName);
  }
  
  
  //print log console, file, clear current screen buffer
  public void flushLogs()
  {
    //print console
    for(String s : logConsoleBuffer)
    { println(appName + " - " + s); }
    logConsoleBuffer.clear();
    
    //print screen
    int texsz = 32;
    int curY = texsz;
    textSize(texsz);
    fill(255,0,0);
    for(String s : logScrBuffer)
    {
      text(s, 12, curY);
      curY += texsz;
    }
    logScrBuffer.clear();
    
    //print file
    for(String s : logFileBuffer)
    { output.println(appName + " - " + s); }
    output.flush();
    logFileBuffer.clear();
  }
  
  void addLog(String l, int logTypeMask)
  {
    if((logTypeMask & LOG_TYPE_SCREEN) == LOG_TYPE_SCREEN)
    { logScrBuffer.add(l); } 
    if((logTypeMask & LOG_TYPE_FILE) == LOG_TYPE_FILE)
    { logFileBuffer.add(l); }
    if((logTypeMask & LOG_TYPE_CONSOLE) == LOG_TYPE_CONSOLE)
    { logConsoleBuffer.add(l); }
  }  
}
