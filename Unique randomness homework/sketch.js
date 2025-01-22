//Donglin Yu
let nameData = {};
let waves = [];
//Animation time
let time = 0;

// Load the CSV file by prof w2 github repo
function preload() {
  table = loadTable('ontario_top_baby_names_male_top2000.csv', 'csv', 'header');
}

function setup() {
  createCanvas(windowWidth, windowHeight);
  colorMode(HSB, 360, 100, 100, 1);
  background(0);
  
  for (let i = 0; i < table.getRowCount(); i++) {
    let year = parseInt(table.getString(i, 'Year/Année'));
    let name = table.getString(i, 'Name/Nom');
    let freq = table.getNum(i, 'Frequency/Fréquence');
    waves.push(new Wave(year, name, freq));
  }
  
  // sort name by frequency
  waves.sort((a, b) => b.freq - a.freq);
}

function draw() {
  background(0, 0.1);
  translate(width/2, height/2);
  
  // show waves
  for (let wave of waves) {
    wave.update();
    wave.display();
  }
  
  time += 0.01;
}
//js
class Wave {
  constructor(year, name, freq) {
    this.year = year;
    this.name = name;
    this.freq = freq;
    //Year to Angle
    this.angle = map(year, 1917, 2023, 0, TWO_PI);
    //frequency to radius
    this.radius = map(freq, 0, 4000, 10, 300);
    //The old name has low brightness, and the new name has high brightness
    let brightness = map(year, 1917, 2023, 10, 200); // old brightness20，new brightness100
    this.color = color(
      map(year, 1917, 2023, 0, 360), // color by year
      80,                            
      brightness                     
    );
    //Staggered effect
    this.offset = random(TWO_PI);
    //speed
    this.speed = map(freq, 0, 4000, 0.0001, 1);
    //random offset
    this.noiseOffset = random(1000);
  }
  //update waves pos
  update() {
    this.currentRadius = this.radius + sin(time * this.speed + this.offset) * 20;
  }
  //draw the waves
  display() {
    let points = 36;
    let angleStep = TWO_PI / points;
    push();
    rotate(this.angle);
    // draw wave
    noFill();
    strokeWeight(map(this.freq, 0, 4000, 0.5, 2));
    
    for (let i = 0; i < 3; i++) {
      let alpha = map(i, 0, 3, 0.8, 0.2);
      stroke(hue(this.color), saturation(this.color), brightness(this.color), alpha); 
      beginShape();
      
      //some errors in the noise() function. I used AI to modify it.
      for (let a = 0; a < TWO_PI; a += angleStep) {
        let r = this.currentRadius + i * 10;
        let x = cos(a) * r;
        let y = sin(a) * r;
        let noiseVal = noise(
          (x * 0.01 + time) + this.noiseOffset,
          (y * 0.01 + time) + this.noiseOffset,
          time * 0.1
        );
        let displacement = map(noiseVal, 0, 1, -5, 5);
        vertex(x + displacement, y + displacement);
      }
      endShape(CLOSE);
    }
    
    // center piont
    fill(this.color);
    noStroke();
    circle(this.currentRadius, 0, map(this.freq, 0, 4000, 2, 8));
    pop();
  }
}
