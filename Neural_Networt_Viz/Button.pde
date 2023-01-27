class Button{
  float xPos,yPos,r;
  
  Button(float x, float y, float radius){
    xPos = x;
    yPos = y;
    r = radius;
  }
  
  void draw(){
    circle(this.xPos,this.yPos,this.r);
  }
  
  void setter(float x, float y, float radius){
    this.xPos = x;
    this.yPos = y;
    this.r = radius;
  }
}

class Slider extends Button{
  float val;
  
  Slider(float x,float y,float r){
    super(x,y,r);
  }
  
  void setVal(float val){
    this.val = val;
  }
  float getVal(){
    return this.val;
  }
  
  void slide(float x1,float y1,float s,String text){
    // Draw line
    stroke(255);
    line(x1,y1,x1+s,this.yPos);
    
    // Draw circle
    super.draw();
    textSize(25);
    fill(255);
    text(text,this.xPos-7,this.yPos - 20);
   
   if (dist(mouseX, mouseY, this.xPos, this.yPos) <= 50 &&
   mouseX >= x1 && mouseX <= x1 + s) {
      if (mousePressed) {
        super.setter(mouseX,this.yPos,this.r);
      }
    }
    //Change this.val according the the circles xPos
  }
}

class AlphaSlider extends Slider{
  int k;
  AlphaSlider(float x,float y,float r,int kprime){
    super(x,y,r);
    k = kprime;
  }
  
  float function(float x){
    if (x == 0){
      return 0;
    } else {
      return pow(10,this.k*(x-1)); // function to ajust 'k' as the slider grows
    }
  }
  
  void slide(float x1,float y1,float s,String text){
    super.slide(x1,y1,s,text);
    float p = (this.xPos - x1)/s;
    float val = this.function(p);
    
    String text_num = str(val);
    
    this.val = this.function(p);
    textSize(20);
    text(text_num,x1 + s + 10,y1);
  }
  
  
  
  
}
//class ResetButton extends Button{
//  float val;
//  ResetBotton(float xPos, float yPos, float r,float val){
//    super(xPos,yPos,r);
//    val = val;
//  }
//}
