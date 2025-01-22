PVector[] l; //Location
PVector[] acc; //Acceleration 
PVector[] c; //Colors are not vectors, but this does not prevent the program from running

int num = 300;
void setup() {

  size(1080, 1080);//The window size can be adjusted
    l = new PVector[num];
    acc = new PVector[num];
    c = new PVector[num];
  
  for (int i = 0; i < num; i++) {
 l[i] = new PVector(random(width*0.99), random(height*0.99));
 acc[i] =  new PVector(random(-5,10),random(-5,5)); 
 c[i] = new PVector(random(255), random(255), random(255));
}
 noFill();
 stroke(255);
}
void draw() {

  background(0);
  
for (int j = 0; j < num; j++) {
   if (l[j].x > width) {
      l[j].x = 0; 
    } else if (l[j].x < 0) {
      l[j].x = width * random(1) ;
      l[j].y = height * random(1); 
      c[j].x = random(255);
      c[j].y = random(255);
      c[j].z = random(255);
    }
    if (l[j].y > height) {
      l[j].y = 0;
    }  else if (l[j].y < 0) {
      l[j].x = width * random(1); l[j].y = height * random(1);
    }
    //Detect edge collisions and reset the elements
    int rect_width = width/40;
    int rect_height = width/40;
  l[j].rotate(0.005*PI);
  l[j].add(acc[j]);
  rect(l[j].x,l[j].y,rect_width,rect_height);
  stroke(c[j].x, c[j].y, c[j].z);
  strokeWeight(1);
  line( 0,0,l[j].x,l[j].y);
  point(l[j].x + rect_width/2, l[j].y + rect_height/2);
}
  
}
void mousePressed(){//Press the mouse to get a quadrant
  for (int k = 0; k < num; k++) {
     if (acc[k].x == 0) {
    acc[k] =  new PVector(random(-5,10),random(-5,5));
  } else {
    acc[k] =  new PVector(0,0);
  }
}}
