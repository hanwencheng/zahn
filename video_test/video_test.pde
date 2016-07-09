import processing.video.*;

Movie mov;
PImage background;
PImage iphone;

void setup()
{
  size(1680, 1050);
  mov = new Movie(this, "MORGENS.mp4");
  background = loadImage("metro-tiles.jpg");
  iphone = loadImage("iphone5-317x667.png");
}

void draw()
{
  //if (mousePressed)
  mov.play();
  //else
  //  mov.pause();

  background(0);
  image(background, 0, 0, width, height);
  image(iphone, 903.5, 40);
  image(mov, 930, 139, mov.width/2.4, mov.height/2.4);
}

void movieEvent(Movie m) {
  m.read();
}