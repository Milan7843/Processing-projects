class MenuHandler {
  Submenu[] submenu = new Submenu[5];
  
  //0: int
  //1: float
  //2: dual float
  //3: 
  int[][][] menuDataUsed = {
    {{}, {1}, {}, {}},
    {{0, 1}, {}, {0, 1}, {}}, 
    {{2}, {0, 2}, {2, 3, 4, 5}, {0}}, 
    {{}, {}, {}, {1}}, 
    {{}, {}, {}, {}}, 
  };
  
  boolean anythingOpen = false;
  
  MenuHandler() {
    submenu[0] = new Submenu("General", 0, menuDataUsed[0]);
    submenu[1] = new Submenu("Emission", 1, menuDataUsed[1]);
    submenu[2] = new Submenu("Particle", 2, menuDataUsed[2]);
    submenu[3] = new Submenu("Collision", 3, menuDataUsed[3]);
    submenu[4] = new Submenu("General", 4, menuDataUsed[4]);
  }
  
  void render() {
    noStroke();
    fill(menuBackgroundColor);
    rect(0, 0, menuWidth, height);
    
    for (int i = 0; i < submenu.length; i++) {
      submenu[i].render(anythingOpen);
    }
    // back button
    if (anythingOpen) {
      fill(menuColor(submenuSpace, submenuSpace, 100, 50));
      rect(submenuSpace, submenuSpace, 100, 50);
      textSize(submenuHeight-10);
      fill(0, 0, 90);
      text("Back", settingSpace + 5, settingSpace*2 + 23);
    }
  }
  
  void mouseUp() {
    //Opens a submenu, but also closes all others
    if (anythingOpen && mouseOn(submenuSpace, submenuSpace, 100, 50)) {
      for (int b = 0; b < submenu.length; b++) {
        submenu[b].open = false;
      }
      anythingOpen = false;
    }
    else {
      for (int i = 0; i < submenu.length; i++) {
        submenu[i].mouseUp();
        if (!anythingOpen) {
          if (mouseOn(submenuSpace, (submenuHeight + submenuSpace)*i + submenuSpace, menuWidth-submenuSpace*2, submenuHeight)) {
            submenu[i].firstFrameOpen = true;
            submenu[i].open = true;
            anythingOpen = true;
            for (int b = 0; b < submenu.length; b++) {
              if (b != i) {
                submenu[b].open = false;
              }
            }
            break;
          }
        }
      }
    }
  }
  void mouseDown() {
    for (int i = 0; i < submenu.length; i++) {
      submenu[i].mouseDown();
    }
  }
}
