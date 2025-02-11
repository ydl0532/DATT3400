 void setup() {
      size(900, 450);
    }
    void draw() {
      background(255);
      translate(width/2, height);
      recursion(300, 300);
    }

    void recursion(float r, int num) {
      if (r > 10) {
        if (r > 10) {
          noFill();
          stroke(0);
        } else {
          fill(0);
        }
        float mouse = mouseX/(float)width;
        if (mouse > 0.6 ) {
          mouse = 0.6;
        }
        r = r * mouse;
        num ++;

        rectMode(CENTER);
        rect(0, 0, r * 2, r * 2);
        translate(-r, -r);
        recursion(r, num);
        translate(r, r);
        recursion(r, num);
        translate(r, -r);
        recursion(r, num);
         translate(-r, r);
        recursion(r, num);
      }
    }
