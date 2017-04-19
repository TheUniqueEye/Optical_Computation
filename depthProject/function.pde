float randomness(int x, int y, float len) {
  if (random(0, 10)<0.5) {
    float yScale = (1000.0*1.0/y);
    float translateX = int(randomGaussian()*(yScale/2.0));
    float translateY = int(randomGaussian()*(yScale)*2);
    float translateZ = int(randomGaussian()*(yScale));
    translate(translateX, translateY, translateZ);
    len = len/3;
  }
  return len;
}



