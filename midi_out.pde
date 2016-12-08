import processing.opengl.*;
import promidi.*;

MidiIO midiIO;
MidiOut midiOut;

int sw = 0;//オンオフスイッチ

void setup() {
  size(300, 300);
  background(0);
  smooth();

  //get an instance of MidiIO
  midiIO = MidiIO.getInstance(this);
  //print a list with all available devices
  midiIO.printDevices();

  //getMidiOut(midiChannel, outDeviceNumber);
  midiOut = midiIO.getMidiOut(0, "Traktor Virtual Input"); //ch1
}

void draw() {
  background(0);
  if (sw==1)fill(100, 190, 255);
  else fill(255);
  ellipse(width/2, height/2, 100, 100);
}

//ここでMIDIを送信！！！！！
void sendMIDI(int value) {
  Controller c = new Controller(0, value);//000, 127(スイッチON)
  //↑トラクタ側でも000にマッピングしておくこと！！！
  midiOut.sendController(c);
}

void mousePressed() {
  if (dist(mouseX, mouseY, width/2, height/2)<50) {
    sw = 1-sw;//押す度にオンオフ切り替え
    println("sw="+sw);
    sendMIDI(0<sw ? 127 : 0);//←if(0<sw) { //true } else { //false }
  }
}
