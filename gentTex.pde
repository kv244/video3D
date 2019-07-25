// TODO
// add navigation in space
//   camera look?
// add a good shader
// refactor makeImage to be consistent

import java.util.ArrayList;
import java.util.List;

///////////////////
// board properties
///////////////////

float boardAngle; 
// angular distance between each board

float groupRadius = 250;
// should be larger than centerSize!

float angleInc = PI/100;
// angular rotation speed 

int xSz = 100; int ySz = 80;
// board sizes

PShader blur;

//////////////////////////
// center shape properties
//////////////////////////
PShape centerShape;
PImage centerTex;
int centerSize = 80;

//////////////////////
// ensemble properties
//////////////////////
int noBoards = 6;
int howFar = -10;
// zPos
float tilt = -PI/4;
float tiltShift = PI/20;
float currRotAngle = 0;
List<board> b; 

/////////
// setup
/////////
void setup () {
  size (800, 600, P3D);
  
  if(centerSize > groupRadius)
    println("Change centerSize or groupRadius, currently center occludes boards!!");
  
  boardAngle = 2*PI/noBoards;
   
  String http = "http://";
  centerTex = loadImage( http + "previewcf.turbosquid.com/Preview/2014/08/01__15_41_30/Earth.JPG5a55ca7f-1d7c-41d7-b161-80501e00d095Larger.jpg");
  
  noStroke(); // for the sphere
  centerShape = createShape(SPHERE, centerSize); 
  centerShape.setTexture(centerTex);

  b = makeBoards(noBoards, xSz, ySz);
  //blur = loadShader("blur.glsl"); // needs a better shader, use KodeLife? 
  //b.setShader(blur);
}

//////////////
// make boards
//////////////
List<board> makeBoards(int n, int sizeX, int sizeY){
  List<board> ret = new ArrayList();
  board b;
  for(int i = 0; i < n; i++){
    if(Math.random() * 5 > 2)
      b = new billboard(sizeX, sizeY, this);
    else
      b = new videoboard(sizeX, sizeY, this);
    
    ret.add(b);
  }
  
  return ret;
}

////////
// draw
////////
void draw () {
  
  background(0);
  int i = 0;
  
  translate(width/2, height/2, howFar); 
  rotateX(tilt);
  rotateY(currRotAngle);
  
  shape(centerShape); 
  
  for(board pb:b){
    pushMatrix();
    translate(sin(i * boardAngle) * groupRadius, 
      0, 
      cos(i * boardAngle) * groupRadius);
    rotateY(PI/(i+1));
    pb.renderBoard(); 
    popMatrix();
    
    i++;
  }
    
  currRotAngle += angleInc;
}

//////////////
// key pressed
// change tilt
//////////////
void keyPressed() {
  switch(key){
    case 'a':
      tilt += tiltShift;
      break;
    case 'z':
      tilt -= tiltShift;
      break;
    case 'w':
      howFar += 1;
      break;
    case 's':
      howFar -= 1;
      
    default:
      println(howFar);
      break;
      
  }
}
