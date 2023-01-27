void setup(){
  size(1000,800);
}

// Grid 
Grid g = new Grid(750,550,400,400);

// Line points
int N = 5000;
PVector[] points = new PVector[N];

// Neural Net, neural net animation
Net net = new Net(10);
NetAnimation netAnimation = new NetAnimation(net,50,200,350,550);

// Samples
PVector[] train_samples = randomSin(150,1,0.1);
PVector[] test_samples = randomSin(20,1,0.5);


// Slider
AlphaSlider slider = new AlphaSlider(50,100,20,4);

// Errors for plotting
ArrayList<Float> train_errors = new ArrayList<Float>();
ArrayList<Float> test_errors = new ArrayList<Float>();
ErrorGraph errorGraph = new ErrorGraph(650,50,300,200);


void draw(){
   background(0);
   
   // Update Net
   points = net.returnPoints(N);
   net.update(train_samples,slider.getVal());
   netAnimation.showNet();
   fill(255);

 
   // Update Errors list and plot
   errorGraph.setPlot(); // Create the arrows 
  
   train_errors.add(net.error(train_samples)); // Get train errors
   test_errors.add(net.error(test_samples)); // Get test errors
   
   errorGraph.plot(test_errors,color(139, 140, 143),false); // plot test errors line
   errorGraph.plot(train_errors,color(245, 117, 32),true); // plot train errors line
  
   // Update Grid
   g.show(); // Show grid
   
   g.plot(points); // Plot the line of the Net
   g.scatter(train_samples,color(0,255,0)); // Scatter the train_sample points
   fill(255,0,0);
   g.scatter(test_samples,color(255,0,0)); // Scatter the test_sample points
 
   //Update Slider
   fill(255);
   slider.slide(50.0,100.0,300.0,"α");
}

void keyPressed(){
  if(keyPressed){
    if(key == 'c'){
      net.changeActivFunc();
    }
  }
  net.resetNet(10);
  train_errors = new ArrayList<Float>();
  test_errors = new ArrayList<Float>();
  
}
