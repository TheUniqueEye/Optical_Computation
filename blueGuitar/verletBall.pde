// Reference: the VerletBall&VerletStick class is based on Ira Greenberg's VerletStick example
// (https://github.com/irajgreenberg/workshopExamples/blob/master/apression/VerletStick.pde)
// -------------------------------------------------------------------------------

class VerletBall {

  PVector pos, posOld;
  PVector push;
  float radius;

  VerletBall(PVector pos, PVector push, float radius) { 
    this.pos = pos;
    this.push = push;
    this.radius = radius;
    this.posOld  = new PVector(pos.x, pos.y, pos.z);

    // start motion
    pos.add(push); 
  }

  void verlet() { 
    PVector posTemp = new PVector(pos.x, pos.y, pos.z);
    pos.x += (pos.x-posOld.x);
    pos.y += (pos.y-posOld.y);
    pos.z += (pos.z-posOld.z);
    posOld.set(posTemp);
  }

  void render() {
    //ellipse(pos.x, pos.y, radius*2, radius*2);
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    point(0, 0, 0);
    strokeWeight(3);
    stroke(127, 110);
    popMatrix();
  }

  void boundsCollision() {
    if (pos.x>width/2-radius) {
      pos.x = width/2-radius;
      posOld.x = pos.x;
      pos.x -= push.x;
    } else if (pos.x< -width/2+radius) {
      pos.x = -width/2+radius;
      posOld.x = pos.x;
      pos.x += push.x;
    }

    if (pos.y>height/2-radius) {
      pos.y = height/2-radius;
      posOld.y = pos.y;
      pos.y -= push.y;
    } else if (pos.y<-height+radius) {
      pos.y = -height+radius;
      posOld.y = pos.y;
      pos.y += push.y;
    }
  }

  void update(float x, float y) {
    pos.x = x;
    pos.y = y;
    //pos.x = mouseX-width/2;
    //pos.y = mouseY-height/2;
  }
}