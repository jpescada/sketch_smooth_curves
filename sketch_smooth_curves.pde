int SIZE=1080;
int SEED = 1687411;
String FILE = "smooth_curves_"+ SEED;

// 0, 8, 9, 18, 23, 27, 32
// 49143, 55674, 65548, 127764, 327426, 734939, 1687411

void setup() {
  size(1080, 1080);
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
  noFill();

  // background texture
  //stroke(255, 100, 0, 20);
  stroke(0, 10);
  for (float y=-SIZE*.01; y<SIZE*1.2; y+=SIZE*.005) {

    beginShape();

    for (float x=-SIZE*.001; x<SIZE*1.3; x+=SIZE*.001) {
      float o=noise(x*.01, y*.015) * SIZE*.01 - SIZE*.005;
      vertex(x, y+o);
    }

    endShape();
  }
  // end

  //stroke(0, 20);
  //for (float i=0; i<1; i+=.0125) {
  //  beginShape();
  //  vertex(0, 0);
  //  bezierVertex(0, lerp(SIZE, SIZE*2, i), SIZE, lerp(-SIZE, 0, i), width, height);
  //  endShape();
  //}

  stroke(0, 20);
  strokeWeight(random(1) > .5 ? 3 : 1);

  for (float x=-SIZE*.01; x<SIZE*1.01; x+=.25) {
    
    float v=0, w=x;
    for (float y=SIZE*1.01; y>-SIZE*.01; y--) {

      // Red-orange to pink
      stroke(225, map(x, 0, SIZE, 0, 150), map(x, 0, SIZE, 0, 255), 20);

      //stroke(map(x, 0, SIZE, 200, 255), map(x, 0, SIZE, 200, 255), 127, 20);

      w+=v;
      point(w, y);
      v+=map(noise(w*.001, y*.002), 0, 1, -.05, .05);      
      
      v=constrain(v, -2, 2);

      if (w<0) {
        w+=SIZE*1.01;
      }

      if (w>SIZE*1.01) {
        w-=SIZE*0.01;
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

  hires.save(FILE +"-HD-"+ scaleFactor +"_"+ millis() +".png");
  println("Finished");
}

void keyPressed() {
  println("Key pressed: "+ key);

  if (key == 's') {
    saveFrame(FILE +"_"+ millis() +".png");
  } else if (key == 'h') {
    saveHighRes(16);
  } else {
    SEED = millis();
    seededRender();
  }
}
