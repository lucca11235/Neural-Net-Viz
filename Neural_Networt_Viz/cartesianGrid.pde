class Grid{
  float xPos,yPos,xSize,ySize,x1,y1,x2,y2;
  
  Grid(float x, float y, float xs, float ys){
    xPos = x;
    yPos = y;
    xSize = xs;
    ySize = ys;
    x1 = xPos-xSize/2;
    y1 = yPos-ySize/2;
    x2 = xPos+xSize/2;
    y2 = yPos+ySize/2;
  }
  
  // Given an x, find where in the canvas the point should be drawn based on the Grid' parameters
  PVector ajustPoint(PVector v){
    float xi = x1 + ((v.x+1)/2)*(xSize);
    float yi = y1 + ((-v.y+1)/2)*(ySize);
    
    return new PVector(xi,yi);
  }
  // PLot points
  void scatter(PVector[] points, color c){
    for(int i = 0; i< points.length;i++){
      PVector p = ajustPoint(points[i]);
      stroke(c);
      circle(p.x,p.y,5);
      
    }
  }
  
  // Plot lines
  void plot(PVector[] points){
    for(int i = 0; i< points.length - 1;i++){
      PVector p1 = ajustPoint(points[i]);
      PVector p2 = ajustPoint(points[i+1]);
      stroke(255,255,0);
      strokeWeight(1);
      line(p1.x,p1.y,p2.x,p2.y);
    }
  }
  
  // Plot the Grid
  void show(){
    drawGrid(xPos,yPos,xSize,ySize);
  }
  
}
