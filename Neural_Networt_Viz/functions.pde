void drawGrid(float xPos, float yPos, float xSize, float ySize){
    float x1 = xPos-xSize/2;
    float x2 = xPos+xSize/2;
    
    float y1 = yPos-ySize/2;
    float y2 = yPos+ySize/2;
    
    float dx = xSize/20;
    float dy = ySize/20;
    //Horizontal and vertical lines
    strokeWeight(1);
    for(int i = 1; i < 20; i++){
      if (i%5 == 0){
        stroke(79,117,139);
      } else {
        stroke(29,41,44);
      }
      line(x1, y1+dy*i,x2,y1+dy*i);
      line(x1+dx*i,y1,x1+dx*i,y2);
    }
    
    stroke(255);
    strokeWeight(2);
    line(xPos-xSize/2,yPos,xPos+xSize/2,yPos);
    line(xPos,yPos-ySize/2,xPos,yPos+ySize/2);
    
    // Arrows
    triangle(x2,yPos - 4, x2 + 6, yPos, x2, yPos + 4);
    triangle(x1,yPos - 4, x1 - 6, yPos, x1, yPos + 4);
    triangle(xPos-4, y1, xPos, y1 - 6, xPos + 4, y1);
    triangle(xPos-4, y2, xPos, y2 + 6, xPos + 4, y2);
    
}

PVector[] randomCos(int n, float f){
  PVector[] points = new PVector[n];
  float x,y;
  for(int i = 0;i<n;i++){
    x = random(-1,1);
    y = cos(2*PI*f*x)+ random(-0.2,0.2);
    points[i] = new PVector(x,y);
  }
  
  return points;
}

PVector[] randomSin(int n, float f, float v){
  PVector[] points = new PVector[n];
  float x,y;
  for(int i = 0;i<n;i++){
    x = random(-1,1);
    y = sin(2*PI*f*x) + random(-v,v);
    points[i] = new PVector(x,y);
  }
  
  return points;
}

PVector[] randomStep(int n){
  PVector[] points = new PVector[n];
  float x,y;
  for(int i = 0;i<n;i++){
    x = random(-1,1);
    if (x <= 0){
      y = 0.7 + random(-0.05,0.05);
    } else {
      y = -0.7 + random(-0.05,0.05);
    }
    points[i] = new PVector(x,y);
  }
  
  return points;
}


// Sigmoid Function
float sig(float x){
  return 1/(1+exp(-x));
}

float sigPrime(float x){
  return sig(x)*(1-sig(x));
}

// Relu
float relu(float x){
  if (x >= 0){
    return x;
  } else {
    return 0;
  }
  
}

float reluPrime(float x){
  if (x > 0){
    return 1;
  } else {
  return 0;
  }
}

// My function test
float cStep(float x){
  if(x < 0){
    return 0;
  } else if (x>1){
    return 1;
  }
  else{
    return x;
  }
 
}

float cStepPrime(float x){
  if(x < 0 || x > 1){
    return 0;
  } else {
    return 1;
  }  
}

// Bell curve
float bell(float x){
  return exp(-x*x);
}

float bellPrime(float x){
  return bell(x)*(-2*x);
}
