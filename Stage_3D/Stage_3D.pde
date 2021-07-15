// A 3D stage / view that can be controlled by mouse & key strokes

final float X_HEIGHT = 60;

// ------ mouse interaction ------
int offsetX = 0, offsetY = 0, clickX = 0, clickY = 0, zoom = -100;
float rotationX = 0, rotationY = 0, targetRotationX = 0, targetRotationY = 0, clickRotationX, clickRotationY; 

float spaceSizeX = X_HEIGHT * 8, spaceSizeY = X_HEIGHT * 6, spaceSizeZ = X_HEIGHT * 8;
float distance = 200;

float initialAlpha = 128;

void setup() {
  size (1080, 1080, P3D);
  smooth(8);
}

void draw() {
  ortho();
  background(0);
  noLights();
  
  pushMatrix(); 
  
  // ------ set view ------
  translate(width/2, height/2, -2000); 

  if (mousePressed && mouseButton==RIGHT) {
    offsetX = mouseX-clickX;
    offsetY = mouseY-clickY;
    targetRotationX = min(max(clickRotationX + offsetY/float(width) * TWO_PI, -HALF_PI), HALF_PI);
    targetRotationY = clickRotationY + offsetX/float(height) * TWO_PI;
  }

  // Easing the rotation: 
  rotationX += (targetRotationX-rotationX)*0.08; 
  rotationY += (targetRotationY-rotationY)*0.08;  
  rotateX(-rotationX);
  rotateY(rotationY); 

  // Draw something:
  for (float i = 16; i > 0; i--) {
    pushMatrix();
    // translate (0,0,-i*distance);
    
    stroke (255, initialAlpha - i*initialAlpha/16);
    noFill();
    box (X_HEIGHT * i, X_HEIGHT * i, X_HEIGHT * i);

    popMatrix();
  }
  
  popMatrix();

}

// ------ interactions ------
void keyPressed() {
  if (keyCode == UP) zoom += 1;
  if (keyCode == DOWN) zoom -= 1;
  if (keyCode == LEFT) zoom += 20;
  if (keyCode == RIGHT) zoom -= 20;
  
  if (key =='r') {
    targetRotationX = PI/6;
    targetRotationY = -PI/6;
  }
  if (key =='c') {
    targetRotationX = PI/36;
    targetRotationY = -PI/16;
  }
  if (key =='d') {
    targetRotationX = PI/6;
    targetRotationY = PI/6;
  }
  if (key =='b') {
    targetRotationX = 0;
    targetRotationY = 0;
  }
}

void mousePressed(){
  clickX = mouseX;
  clickY = mouseY;
  clickRotationX = rotationX;
  clickRotationY = rotationY;
}
