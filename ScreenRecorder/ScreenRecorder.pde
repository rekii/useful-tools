// A screen recorder that 
// starts recording on the first frame and 
// stops when "q" is pressed

// import the library for video export
import com.hamoid.*; 

// create a new VideoExport-object
VideoExport videoExport;

void setup() {
  size (1080, 1080, P3D);
  // smooth(8);
  
  // Some settings
  videoExport = new VideoExport(this, "Recording.mp4");
  videoExport.setFrameRate(60);  
  videoExport.startMovie();
}

void draw() {
  // Draw something:
  background(#EFEFEF);

  float progress = sin(frameCount * PI / 256.0);
  float r = width * 0.01 + width * 1.28 * 0.5 * (1 + progress);
  
  noStroke();
  fill (#1E4C9C, 256 * 0.5 * (1 - progress));
  ellipse (width/2, height/2, r, r);
  
  // Save a frame!
  videoExport.saveFrame();
}

// ------ interactions ------
void keyPressed() {
  if (key == 'q') {
    videoExport.endMovie();
    exit();
  }
}
