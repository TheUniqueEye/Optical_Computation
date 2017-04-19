// Reference: the VerletBall&VerletStick class is based on Ira Greenberg's VerletStick example
// (https://github.com/irajgreenberg/workshopExamples/blob/master/apression/VerletStick.pde)
// -------------------------------------------------------------------------------

class VerletStick {
  VerletBall b1, b2;
  float stiffness;
  boolean isVisible=true;
  PVector vecOrig;
  float len;

  VerletStick(VerletBall b1, VerletBall b2, float stiffness) {
    this.b1 = b1;
    this.b2 = b2;
    this.stiffness = stiffness;
    vecOrig  = new PVector(b2.pos.x-b1.pos.x, b2.pos.y-b1.pos.y, b2.pos.z-b1.pos.z);
    len = PVector.dist(b1.pos, b2.pos);
  }

  void render(float stroke) {
    if (isVisible) { 
      line(b1.pos.x, b1.pos.y, b1.pos.z, b2.pos.x, b2.pos.y, b2.pos.z);
      strokeWeight(stroke);
      //stroke((224-0.01*(b2.pos.y*b2.pos.y)), (82-0.01*(b2.pos.y*b2.pos.y)), (141+b2.pos.y), 255); // pink-blue
      stroke((220-b1.pos.y*b2.pos.y/100)/2-b2.pos.y/9, (220-b1.pos.y*b2.pos.y/100-b2.pos.y)-b2.pos.y/7, 
        (250-b1.pos.y*b2.pos.y/100-b2.pos.y)-b2.pos.y/4, transP*transP/100);
    }
  }

  void constrainLen() {
    PVector delta = new PVector(b2.pos.x-b1.pos.x, b2.pos.y-b1.pos.y, b2.pos.z-b1.pos.z);
    float deltaLength = delta.mag();
    float difference = ((deltaLength - len) / deltaLength); 
    b1.pos.x += delta.x * (0.5f * stiffness * difference); 
    b1.pos.y += delta.y * (0.5f * stiffness * difference);
    b1.pos.z += delta.z * (0.5f * stiffness * difference);

    b2.pos.x -= delta.x * (0.5f * stiffness * difference);
    b2.pos.y -= delta.y * (0.5f * stiffness * difference);
    b2.pos.z -= delta.z * (0.5f * stiffness * difference);
  }
}