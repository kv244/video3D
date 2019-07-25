import processing.video.*;

class videoboard extends board{
    
  private Capture cam;
  
  ///////
  // ctor
  ///////
  public videoboard(int xSz, int ySz, PApplet p){   
    super(xSz, ySz, p);
    this.sh = null;
    String[] cameras = Capture.list();
    
    try{
      this.cam = new Capture(this.parent, cameras[0]);
      cam.start();
    }catch(Exception x){
      println("Error " + x.getMessage());
    }
    //makeImage(null); // seems not to work at this stage?
  }
  
  //////////////////////////////////////////////
  // make image
  // for this subclass, it is a camera capture
  // parameter is ignored, can be null
  //////////////////////////////////////////////
  public PImage makeImage(PImage tx){
    
    if(this.cam != null && this.cam.available() == true){
      this.cam.read();
      this.tex = this.cam;
      //this.tex.resize(this.xSz, this.ySz); crashes? added in board render to use proper size
    }
    
    return this.tex;
  }
  
  ////////////////////
  // render subclass
  // updates image
  // TODO apply shader
  ////////////////////
  public void renderBoard(){
    /*
    if(this.sh != null){
      filter(this.sh);
    }
    */
    
    super.renderBoard();
    
    if(Math.random() * 10 > 9)
      makeImage(null);
   
      /*
    else
    if(Math.random() * 12 > 9)
      shiftImage();
      // TODO this is slow, use shader instead
      // default is, keep old image
      */
  }
  
  private void shiftImage(){
      PImage tx = this.tex;
      if(tx == null)
        return;
      
      tx.loadPixels();
      
      for (int i = 0; i < tx.pixels.length; i++) {
        if(Math.random() * 5 > 2)
          tx.pixels[i] = color((int)Math.random() * 255);
      }
      tx.updatePixels();
      this.tex = tx; //TODO check if needed
    return;
  }
}
