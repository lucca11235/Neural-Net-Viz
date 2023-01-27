class ErrorGraph{
  
  float xPos,yPos,xSize,ySize;
  
  ErrorGraph(float x, float y, float xs, float ys){
    xPos = x;
    yPos = y;
    xSize = xs;
    ySize = ys;
  }
  
  void setPlot(){
    // Create graph
    stroke(255);
    strokeWeight(2);
    line(xPos,yPos + ySize,xPos + xSize,yPos + ySize); //horizontal line
    line(xPos,yPos + ySize,xPos,yPos); // vertical line
    
    // Arrows
    float xA = xPos + xSize, yA = yPos + ySize;
    triangle(xA,yA-4,xA + 6,yA, xA,yA+4);
    triangle(xPos-4,yPos,xPos,yPos - 6,xPos + 4,yPos);
  }
 
  void plot(ArrayList<Float> errors,color c, boolean writeError){
    
    // For reasons of laziness I decided that this coordinate system
    // will be identical to the rect() parameters
    
    float d = this.xSize/errors.size();
    
    //Plot each point
    float x1,y1;
    float maxY = errors.get(0);
    
    float lastx = this.xPos;
    float lasty = this.yPos;
     
    for(int i = 1;i < errors.size();i++){
      x1 = this.xPos + (i)*d; //Already ajusted for the new position
     
      y1 = errors.get(i);
     
      y1 = maxY*pow(y1/maxY,0.3); // Function to ajust height 
      
      y1 = this.yPos + this.ySize*(1 - y1/maxY); //Already ajusted for the new position
      
      // Draw line
      stroke(c);
      strokeWeight(2);
      line(lastx,lasty,x1,y1);
          
      lastx = x1;
      lasty = y1;
    }
    
    if(writeError){
      float lastVal = errors.get(errors.size() - 1);
      String text = str(lastVal);
      
      y1 = maxY*pow(lastVal/maxY,0.3);
      y1 = this.yPos + this.ySize*(1 - y1/maxY);
      
      textSize(15);
      text(text,this.xPos + this.xSize + 10,y1);
    }
  }
  
}
