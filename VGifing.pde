import gifAnimation.*;
import netP5.*;
import oscP5.*;

OscP5 oscP5;

ArrayList<Gif> ohYeah;
PVector pos;

int idGif, nbrGif;
// Todo : pre load up before usage if too much RAM consumption

public void setup() {
  size(1200, 800);
  oscP5 = new OscP5(this,7000);
  
  nbrGif = 11;
  idGif = floor( random(nbrGif) );
    
  ohYeah = new ArrayList<Gif>();
  for(int i = 1; i < nbrGif + 1; ++i)
     ohYeah.add( new Gif(this, "./data/gif_"+i+".gif") );  
  
  pos = new PVector(width/2 - ohYeah.get(idGif).width/2, height/2 - ohYeah.get(idGif).height/2);
  ohYeah.get(idGif).loop();
  
  background(0);
}

void draw() {
//  image(ohYeah.get(idGif), width/2 - ohYeah.get(idGif).width/2, height / 2 - ohYeah.get(idGif).height / 2);
  image(ohYeah.get(idGif), pos.x, pos.y);
}


void keyPressed() {
  if (key == ' ') {
    ohYeah.get(idGif).stop();
    int prevId = idGif;
    while(nbrGif > 1 && prevId == idGif)
      idGif = floor( random(nbrGif) );    
    pos.set( random(max(width-ohYeah.get(idGif).width, 0)), random(max(height-ohYeah.get(idGif).height, 0)));
    ohYeah.get(idGif).loop();
  }
}

  
void oscEvent(OscMessage theOscMessage) {
  //println("### received an osc message. with address pattern "+theOscMessage.addrPattern());
  
  for(int i = 1; i < nbrGif - 1 && i < 16; ++i)
    if(theOscMessage.checkAddrPattern("/2/push"+i)==true)
      if(theOscMessage.get(0).floatValue() == 1) {
        idGif = i;    
        pos.set( random(max(width-ohYeah.get(idGif).width, 0)), random(max(height-ohYeah.get(idGif).height, 0)));
        ohYeah.get(idGif).loop();
        return;
      }

}