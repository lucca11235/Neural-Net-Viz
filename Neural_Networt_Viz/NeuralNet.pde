class Net{
  int n;
  float[] w;  
  float[] a;
  float[] b;
  String activFunc = "sigmoid";
  
  Net(int N){
    n = N;
    
    this.resetNet(n);
  }
  
  void resetNet(int n){
    this.n = n;
    this.w = new float[n];
    this.a = new float[n];
    this.b = new float[n];
    
    if(this.activFunc == "sigmoid"){
      for(int i = 0; i < n; i++){
        w[i] = random(-10,10);
        a[i] = random(-10,10);
        b[i] = random(-6,6);
      }  
    } else if (this.activFunc == "relu"){
      
      for(int i = 0; i < n; i++){
      w[i] = random(-2,2);
      a[i] = random(-2,2);
      b[i] = random(-0.5,0.5);
    }  
    }
    
  }
  
  // These are the activation functions of the net, this function allows me to chance them
  float activationFunction(float x){
    if(this.activFunc == "sigmoid"){
    return sig(x);
    
    } else if (this.activFunc == "relu"){
     return relu(x);
    }
    
    return 0;
  }
  
  float activationFunctionPrime(float x){
    if(this.activFunc == "sigmoid"){
    return sigPrime(x);
    
    } else if (this.activFunc == "relu"){
     return reluPrime(x);
    }
    
    return 0;
  }
  
  
  // Given an input, this function return the output of the net
  float function(float x){
    float output = 0;
    
    for(int i = 0; i < this.n; i++){
      output += this.w[i]*this.activationFunction(this.a[i]*x+this.b[i]);
    }
    
    return output;
  }
   
  // Train the net
  void update(PVector[] points,float alpha){
    float[] w_new = new float[this.n];
    float[] a_new = new float[this.n];
    float[] b_new = new float[this.n];
    
    
    PVector di;
   
    int L = points.length;
    float sum_w,sum_a,sum_b;
    for(int i = 0; i < this.n; i++){
      sum_w = 0;
      sum_a = 0;
      sum_b = 0;
      
      for( int j = 0; j < L ; j++){
        di = points[j];
        sum_w += 2*(this.function(di.x) - di.y)*this.activationFunction(a[i]*di.x + b[i]);
        sum_a += 2*(this.function(di.x) - di.y)*w[i]*this.activationFunctionPrime(a[i]*di.x + b[i])*di.x;
        sum_b += 2*(this.function(di.x) - di.y)*w[i]*this.activationFunctionPrime(a[i]*di.x + b[i]);
      }
      
      w_new[i] = w[i] - alpha*sum_w*2/L;
      a_new[i] = a[i] - alpha*sum_a*2/L;
      b_new[i] = b[i] - alpha*sum_b*2/L;
    }
    
    this.w = w_new;
    this.a = a_new;
    this.b = b_new;
 
  }
  
  // This function returns the points the net create so I can plot them
  PVector[] returnPoints(int N){
 
    PVector[] points = new PVector[N];
    
    float x,y;
    for(int i = 0; i < N; i++){
      x = -1 + 2*float(i)/N;

      y = function(x);
      points[i] = new PVector(x,y);
    }
    return points;
  }
  
  //Error function
  float error(PVector[] points){
    float output = 0;
    PVector p;
    for(int i = 0; i < points.length; i++){
      p = points[i];
      output += pow(this.function(p.x) - p.y,2);
    }

    return output;
  }
  
  // Getters 
  int getN(){
    return this.n;
  }
  
  float[] getA(){
    return this.a;
  }
  
  float[] getW(){
    return this.w;
  }
  float[] getB(){
    return this.b;
  }
  
  void changeActivFunc(){
    if(this.activFunc == "sigmoid"){
          this.activFunc = "relu";
        } else if(this.activFunc == "relu"){
          this.activFunc = "sigmoid";
        }
     this.resetNet(10);
  }
}  

class NetAnimation{
  Net net;
  float xPos,yPos,xSize,ySize;
  
   NetAnimation(Net n, float x, float y, float xs,float ys){
    net = n;
    xPos = x;
    yPos = y;
    xSize = xs;
    ySize = ys;
  }
  void defStroke(float x){
     if (x <= 0){
        stroke(247, 52, 65);
      } else {
        stroke(76, 99, 252);
      }
      
      strokeWeight(2*(2*sig(3*abs(x))-1));
  }
  
  void showNet(){
    int n = net.getN();
    float y,sep = ySize/(n+1);
    
    float[] a_list = net.getA();
    float[] w_list = net.getW();
    float[] b_list = net.getB();
    
    // Print lines
    float w,a;
    for(int i = 1; i<=n;i++){
      y = i*sep + yPos;
      
      w = w_list[i-1];
      a = a_list[i-1];
      
      // Print A
      defStroke(a);
      line(xPos+ 10,yPos + ySize/2,xPos + xSize/2,y);
      
      defStroke(w);
      line(xPos + xSize/2,y,xPos + xSize - 10,yPos + ySize/2);
    }
    
    // Input,output circle
    fill(0);
    stroke(255);
    strokeWeight(1);
    circle(xPos+ 10,yPos + ySize/2,10);
    circle(xPos + xSize - 10,yPos + ySize/2,10);
    
    // Print middle neurons
    float b;
    for(int i = 1; i<=n;i++){
      b = b_list[i-1];
      y = i*sep + yPos;
      defStroke(b);
      circle(xPos + xSize/2,y,10);
    }

  }
  
  
}
