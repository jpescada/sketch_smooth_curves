int SIZE=1000;
int W = 750;
int H = 1000;
int SEED = floor(random(999999999));
String FILE = "smooth_curves_"+ SEED;

// 0, 8, 9, 18, 23, 27, 32
// 49143, 55674, 65548, 127764, 327426, 734939, 1687411

void setup() {
  size(750, 1000);
  //pixelDensity(max(displayDensity(),2));
  seededRender();
}

void draw() {
}

void seededRender() {
  randomSeed(SEED);
  noiseSeed(SEED);
  println("SEED: "+ SEED);
  render();
}

void render() {
  background(255);
  //background(0);
  
  noFill();

  // background texture
  //stroke(255, 100, 0, 20);
  stroke(0, 10);
  for (float y=-H*.01; y<H*1.2; y+=H*.005) {

    beginShape();

    for (float x=-W*.001; x<W*1.3; x+=W*.001) {
      float o=noise(x*.01, y*.015) * H*.01 - H*.005;
      vertex(x, y+o);
    }

    endShape();
  }
  // end
  
  
  // add frame
  //stroke(0);
  //strokeWeight(SIZE*.002);
  //rect(SIZE*.04, SIZE*.04, SIZE*.92, SIZE*.92);
  // end frame


  //stroke(0, 20);
  //for (float i=0; i<1; i+=.0125) {
  //  beginShape();
  //  vertex(0, 0);
  //  bezierVertex(0, lerp(SIZE, SIZE*2, i), SIZE, lerp(-SIZE, 0, i), width, height);
  //  endShape();
  //}

  stroke(0, 20);
  //stroke(255, 20);
  strokeWeight(random(1) > .5 ? 3 : 1);

  for (float x=-W*.01; x<W*1.01; x+=.25) {
    
    float v=0, w=x;
    for (float y=H*1.01; y>-H*.01; y--) {

      // Red-orange to pink
      stroke(225, map(x, 0, SIZE, 0, 150), map(x, 0, SIZE, 0, 255), 20);
      
      //stroke(map(x, 0, SIZE, 50, 150), 100, map(x, 0, SIZE, 0, 255), 20);

      //stroke(map(x, 0, SIZE, 200, 225), map(x, 0, SIZE, 25, 50), map(x, 0, SIZE, 100, 125), 20);

      w+=v;
      point(w, y);
      v+=map(noise(w*.001, y*.002), 0, 1, -.005, .005);      
      
      v=constrain(v, -2, 2);

      if (w<0) {
        w+=W*1.01;
      }

      if (w>W*1.01) {
        w-=W*0.01;
      }
    }
  }
}

void saveHighRes(int scaleFactor) {
  PGraphics hires = createGraphics(
    width * scaleFactor,
    height * scaleFactor,
    JAVA2D);

  println("Generating high-resolution image...");

  beginRecord(hires);
  hires.scale(scaleFactor);

  seededRender();

  endRecord();

  hires.save(FILE +"-HD-"+ scaleFactor +".png");
  println("Finished");
}

void keyPressed() {
  println("Key pressed: "+ key);

  if (key == 's') {
    saveFrame(FILE +".png");
  } else if (key == 'h') {
    saveHighRes(14);
  } else {
    SEED = floor(random(999999999));
    seededRender();
  }
}
