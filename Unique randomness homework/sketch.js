//Donglin Yu
let nameData = {};
let waves = [];
let time = 0;

function preload() {
  table = loadTable('ontario_top_baby_names_male_top2000.csv', 'csv', 'header');
}

function setup() {
  createCanvas(windowWidth, windowHeight);
  colorMode(HSB, 360, 100, 100, 1);
  background(0);
  
  // 数据处理
  for (let i = 0; i < table.getRowCount(); i++) {
    let year = parseInt(table.getString(i, 'Year/Année'));
    let name = table.getString(i, 'Name/Nom');
    let freq = table.getNum(i, 'Frequency/Fréquence');
    
    waves.push(new Wave(year, name, freq));
  }
  
  // 按频率排序
  waves.sort((a, b) => b.freq - a.freq);
}

function draw() {
  background(0, 0.1);
  translate(width/2, height/2);
  
  // 更新和显示所有波形
  for (let wave of waves) {
    wave.update();
    wave.display();
  }
  
  time += 0.01;
}

class Wave {
  constructor(year, name, freq) {
    this.year = year;
    this.name = name;
    this.freq = freq;
    this.angle = map(year, 1917, 2023, 0, TWO_PI);
    this.radius = map(freq, 0, 4000, 10, 300);
    
    // 修改颜色设置，将年份映射到亮度
    let brightness = map(year, 1917, 2023, 10, 200); // 老年份亮度20，新年份亮度100
    this.color = color(
      map(year, 1917, 2023, 0, 360), // 色相
      80,                            // 饱和度保持不变
      brightness                     // 亮度随年份变化
    );
    
    this.offset = random(TWO_PI);
    this.speed = map(freq, 0, 4000, 0.0001, 1);
    this.noiseOffset = random(1000);
  }
  
  update() {
    this.currentRadius = this.radius + sin(time * this.speed + this.offset) * 20;
  }
  
  display() {
    let points = 36;
    let angleStep = TWO_PI / points;
    
    push();
    rotate(this.angle);
    
    // 绘制波纹
    noFill();
    strokeWeight(map(this.freq, 0, 4000, 0.5, 2));
    
    for (let i = 0; i < 3; i++) {
      let alpha = map(i, 0, 3, 0.8, 0.2);
      // 使用修改后的颜色
      stroke(hue(this.color), saturation(this.color), brightness(this.color), alpha);
      
      beginShape();
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
    
    // 绘制中心点，同样使用修改后的颜色
    fill(this.color);
    noStroke();
    circle(this.currentRadius, 0, map(this.freq, 0, 4000, 2, 8));
    
    pop();
  }
}
