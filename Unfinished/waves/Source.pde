class Source {
  ArrayList<Ripple> ripple = new ArrayList<Ripple>();
  PVector pos = new PVector();
  
  Source() {}
  
  void update() {
    ripple.add(new Ripple(pos));
    for (Ripple r : ripple) {
      r.update();
    }
  }
}
