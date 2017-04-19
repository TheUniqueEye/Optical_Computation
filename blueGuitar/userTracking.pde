// Reference: based on Hilda's FloatCube_concise demo, originated from Donghao.
// -------------------------------------------------------------------------------
/*
Class used for storing data of the current user 

int threshold1 = 1000; // threshold for incorrect data test received by kinect.
int threshold2 = 25; // threshold for data display in canvas

public class UserTrackingInfo {
  public ArrayList<PVector> positions;
  public PVector colour;
  private PVector lastP;

  public UserTrackingInfo() {
    positions = new ArrayList<PVector>();
    positions.add(new PVector(0, 0, 0));
    lastP = positions.get(positions.size() - 1);
    colour = new PVector(random(0, 255), random(0, 255), random(0, 255));
  }

  public void update(PVector currentP) {
    lastP = positions.get(positions.size()-1);
    if (currentP.x==0 && currentP.y ==0 && currentP.z ==0 ) {
      return;
    }
    if (positions.size() == 1) {
      positions.add(currentP);
    } else {
      if ((!this.isDumb(currentP)) && this.isFarEnough(currentP) ) {
        positions.add(currentP);
      }
    }
  }

  private boolean isDumb(PVector currentP) {
    if (abs(currentP.x - lastP.x) > threshold1) {
      return true;
    } else if (abs(currentP.y - lastP.y) > threshold1) {
      return true;
    } else if (abs(currentP.z - lastP.z) > threshold1) {
      return true;
    } else return false;
  }

  private boolean isFarEnough(PVector currentP) {
    float displacement = v_dist(currentP, lastP);
    if (displacement >=  threshold2) return true;
    else return false;
  }
};

Update hand positions. 
void updateHandPoses() {
  // Calculate dt (in seconds).
  double current_time = millis();
  float dt = (float)(current_time - previous_update_time) / 1000.0;
  previous_update_time = current_time;

  // Read OpenNI data and update user hand positions and velocities.
  if (kinect != null) {
    // Get forces.
    int[] user_list = kinect.getUsers();
    for (int i = 0; i < user_list.length; i++) {
      if (context.isTrackingSkeleton(user_list[i])) {
        int user_id = user_list[i];
        PVector left_hand_position = new PVector();
        PVector right_hand_position = new PVector();
        float left_hand_confidence = kinect.getJointPositionSkeleton(user_id, SimpleOpenNI.SKEL_LEFT_HAND, left_hand_position);
        float right_hand_confidence = kinect.getJointPositionSkeleton(user_id, SimpleOpenNI.SKEL_RIGHT_HAND, right_hand_position);
        left_hand_position = translateOpenNIPosition(left_hand_position);
        right_hand_position = translateOpenNIPosition(right_hand_position);
        UserTrackingInfo info = user_tracking_info.get(user_id);
      }
    }
  }
}
*/
