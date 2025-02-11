PVector p[];
int num = 16;//Number of Waves
float[] amp = new float[num];//Amplitude

void setup() {
  size(800, 200);
  smooth();
  p = new PVector[num];
  for (int k = 0; k < num; k++) {
    p[k] = new PVector(0,0);
    amp[k] = random(20,100);
  }
}
float period = 2.5;
float wavelength = 200;
int frameRate = 60;
int samp = 100; //sampling rate
float time;//interval time
float point;

void draw(){
  background(255);
  stroke(255,0,0);
  fill(255);
  time += PI/frameRate/period;
  for (int j = 0; j < num; j++) {
  for (int i = 0; i < samp; i ++) {
    point = i * (wavelength/width * samp)+0.1*j;
    p[j].x = (i+0.1)/ samp * width;
    //Each point deviates by a interval time
    p[j].y = amp[j] * sin(time + point) + height/2;//Relocate the waves to the center
    ellipse(p[j].x, p[j].y ,width/100,width/100);
  }
}}
