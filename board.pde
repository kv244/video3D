class board{
  
  protected int xSz, ySz;
  protected PImage tex;
  protected PShader sh;
  protected PApplet parent;
  
  ////////////////////////////////////////////////////
  // ctor
  // leaves image empty, duty of subclass to create it
  ////////////////////////////////////////////////////
  public board(int sX, int sY, PApplet p){
    this.xSz = sX;
    this.ySz = sY;
    this.tex = createImage(xSz, ySz, RGB);
    this.parent = p;
  }
  
  //////////////
  // sets shader
  //////////////
  public void setShader(PShader sh){
    this.sh = sh;
  }
  
  ////////////////////////////////////////
  // super class rendering
  // places frame + texture on screen
  // any additional processing styling etc 
  // done by the children
  ////////////////////////////////////////
  public void renderBoard(){
    
    pushStyle();
   
    stroke(255, 0, 0);
    rectMode(CENTER);
    rect(0, 0, this.xSz, this.ySz);
    imageMode(CENTER);
    if(this.tex != null){
      if(this.tex.width != this.xSz || this.tex.height != this.ySz)
        image(this.tex, 0, 0, this.xSz, this.ySz); // prevents cam image from being large
      else
        image(this.tex, 0, 0);
    }
    
    popStyle();
   
  }
  
  // TODO refactor
  // currently, it does not get called
  public PImage makeImage(PImage tx){
    println("makeimage board called"); 
    return tx;
  }
  
}
