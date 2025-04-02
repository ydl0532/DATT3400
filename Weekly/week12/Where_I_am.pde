import processing.video.*;
Capture video;

void setup(){
size(320,240);
video = new Capture(this,320,240); 
video.start();
}
void draw()
{
  background(0);
    if (video.available())
       {
       video.read();
        }
       loadPixels();
        video.loadPixels();
        for(int x=0; x<video.width; x++)
       {
         for(int y=0;y<video.height;y++)
             {
                int loc =video.width * y +x;
  
                      float r,g,b;
                    r =red(video.pixels[loc]);
                        g =green(video.pixels[loc]);
                           b =blue(video.pixels[loc]);
   
                   r*= (100 - dist(x,y,mouseX,mouseY))/100;
                   g*= (100 - dist(x,y,mouseX,mouseY))/100;
                   b*= (100 - dist(x,y,mouseX,mouseY))/100;
   
                 r = constrain(r,0,255);
                 g = constrain(r,0,255);
                 b = constrain(r,0,255);
                 
                 color c = color(r,g,b);
                  pixels[loc]=c;
}
 }
 updatePixels();
}
