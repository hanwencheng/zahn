import processing.video.*;
import processing.serial.*;

Serial myPort;  // Create object from Serial class
//String val="";     // Data received from the serial port

CountDown countDown;
private static final int countdownTime = 12;
private static final int countdown = countdownTime;
boolean bursteAn = false;

Movie mov;
PImage background;
PImage iphone;
PImage pause;
PImage schwarz;
int mode = 0;

void setup() {
  size(1680, 1050);

  String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600);

  schwarz = loadImage("background.jpg");
  background = loadImage("metro-tiles.jpg");
  mov = new Movie(this, "Sequence 01.mp4");
  iphone = loadImage("iphone5-317x667.png");
  pause = loadImage("pause.jpg");

  fill(0);
  textSize(50);
}

void draw()
{    
  String val = "";
  if ( myPort.available() > 0) // check if connected to arduino and data is available
  {
    val = myPort.readStringUntil('\n'); // read it and store it in val
  } 
  println(val);

  //----------------------------------------------------------------------
  if (val != null && val.contains("button pressed")) // check if button pressed
  {
    mode = mode+1;
    if (mode > 2)
      mode = 1;
    println("Mode: "+mode);


    if (countDown == null) { // if no coundown running
      countDown = new CountDown(); // start new countdown
      countDown.start(countdown);
    } else if (countDown.running()) { // if countdown is running
      countDown.togglePause(); // pause/unpause it
    }
  }
  //----------------------------------------------------------------------
  if (countDown != null) { // Check if countdown has been started
    if (countDown.running()) { // Check if there is still time left
      countDown.tick(); // Tell countdown to update itself
      if (countDown.isPaused()) { // Check if countdown has been paused
        text("Paused - " + (countdownTime-countDown.timeLeft()), 80, 80);
      } else {
        text("Running - " + (countdownTime-countDown.timeLeft()), 80, 80);
        if ((countdownTime-countDown.timeLeft()) > 5)
        {
          ellipse(width/2, height/2, 50, 50);
        }
      }
    } else {
      text("Finished", 80, 80);
      myPort.write("s");
      //println("stop");
    }
  } else {
    text("Not Running", 80, 80);
  }

  //=========== DRAWING ON SCREEN ====================
  background(0);
  image(background, 0, 0, width, height);
  image(schwarz, 930, 139, 640/2.4, 1134/2.4);
  image(mov, 930, 139, mov.width/2.4, mov.height/2.4);
  image(iphone, 903.5, 40);

  if (mode == 2) 
  {
    mov.pause();
    image(pause, 930, 139, pause.width/2.4, pause.height/2.4);
  } else if (mode == 1) 
  {
    mov.play();
  }
}

void movieEvent(Movie m) {
  m.read();
}