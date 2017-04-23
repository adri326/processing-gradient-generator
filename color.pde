class Color {
  float r, g, b;
  Color(float r, float g, float b) {
    this.r = r;
    this.g = g;
    this.b = b;
  }
  void fill_color() {
    fill(r*255, g*255, b*255);
  }
}
Color gradient(Color a, Color b, float v) {
  return new Color(
    a.r*v+b.r*(1-v),
    a.g*v+b.g*(1-v),
    a.b*v+b.b*(1-v));
}