class billboard extends board{
    
  ///////
  // ctor
  ///////
  public billboard(int xSz, int ySz, PApplet p){   
    super(xSz, ySz, p);
    this.tex = makeImage(this.tex);
    this.sh = null;
  }
  
  //////////////////////////////////////////////
  // make image
  // for this subclass, it is a random line draw
  //////////////////////////////////////////////
  public PImage makeImage(PImage tx){
      color c = color(random(255), random(255), random(255));
      int minLine = 0;
      tx.loadPixels();
      
      for (int i = 0; i < tx.pixels.length; i++, minLine++) {
        tx.pixels[i] = c;
        
        if(minLine > 25 && random(50) > 25){
          c = color(random(255), random(255), random(255));
          minLine = 0;
        }
      }
      tx.updatePixels();
    return tx;
  }
  
  //////////////////
  // render subclass
  // updates image
  // TODO apply shader
  //////////////////
  public void renderBoard(){
    /*
    if(this.sh != null){
      filter(this.sh);
    }
    */
    
    super.renderBoard();
    this.tex = makeImage(this.tex);
  }
}
