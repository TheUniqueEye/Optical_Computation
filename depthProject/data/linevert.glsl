

#define PROCESSING_LINE_SHADER

uniform mat4 transform;
uniform vec4 viewport;

// could add a time to make the transformation according to the frame
//uniform float time;

attribute vec4 vertex;
attribute vec4 color;
attribute vec4 direction;

varying vec4 vertColor;

vec3 clipToWindow(vec4 clip, vec4 viewport) {
  vec3 dclip = clip.xyz / clip.w;
  vec2 xypos = (dclip.xy + vec2(1.0, 1.0)) * 0.5 * viewport.zw;
  return vec3(xypos, dclip.z * 0.5 + 0.5);
}

void main() {

  vec4 new_vertex = vertex; // add a new_vertex
  // transform the vertex with sin/cos/tan to create a wave form effect.
  //new_vertex.x += tan(new_vertex.y / 100.0) * 10.0;
  new_vertex.z += sin(new_vertex.y / 10.0) * 10.0;
  //new_vertex.y += cos(new_vertex.x / 10.0) * 10.0;
  //new_vertex.y += tan(new_vertex.x / 100.0) * 10.0;
  //new_vertex.z += sin(new_vertex.z / 10.0) * 10.0;

  vec4 clip0 = transform * new_vertex; // replace vertex with new_vertex
  // vec4 new_clip = clip0; // add a new_clip
  // the difference between the clip and vertex is in transform vertex the effect depends on the perspective of camera
  // however when doing the clip, the effect is fixed at certain range on the scree.

  // doing tan to the new_clip, the changing frequency corresponding to the parameter in sin()
  // and the range of changing corresponding to the sin()*
  // new_clip.x += tan(new_clip.y / 100.0 + sin(new_clip.y / 30.0) * 0.5) * 10.0;
  // new_clip.y += tan(new_clip.x / 100.0 + sin(new_clip.x / 30.0) * 0.5) * 10.0;
  // replace all the clip0 with the new_clip
  // clip0 = new_clip;

  vec4 clip1 = clip0 + transform * vec4(direction.xyz, 0);
  float thickness = direction.w;

  vec3 win0 = clipToWindow(clip0, viewport);
  vec3 win1 = clipToWindow(clip1, viewport);
  vec2 tangent = win1.xy - win0.xy;

  vec2 normal = normalize(vec2(-tangent.y, tangent.x));
  vec2 offset = normal * thickness;
  gl_Position.xy = clip0.xy + offset.xy;
  gl_Position.zw = clip0.zw;
  vertColor = color;
}
