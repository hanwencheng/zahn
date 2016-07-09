import processing.video.*;
import processing.serial.*;

Serial myPort;  // Create object from Serial class

Movie mov;
PImage background;
PImage iphone;
int mode = 0; //init state is pause

void setup()
{
  //edit : if still use the port as and name as before
  String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600);
  
  size(1680, 1050);
  mov = new Movie(this, "MORGENS.mp4");
  background = loadImage("metro-tiles.jpg");
  iphone = loadImage("iphone5-317x667.png");
}

void draw()
{
  String val = "";
  if ( myPort.available() > 0) // check if connected to arduino and data is available
  {
    val = myPort.readStringUntil('\n'); // read it and store it in val
  } 
  println(val);
  
  if (val != null && val.contains("button pressed"))
  {
    mode ++;
    switch(mode){
      case 0 :
        mov.pause();
        break;
      case 1 : 
        mov.play();
        break;
    }
    mode = mode % 2;
  }

  background(0);
  image(background, 0, 0, width, height);
  image(iphone, 903.5, 40);
  image(mov, 930, 139, mov.width/2.4, mov.height/2.4);
}

void movieEvent(Movie m) {
  m.read();
}