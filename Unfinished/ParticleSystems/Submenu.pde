class Submenu {
  boolean open;
  int index;
  
  int[][] dataUsed;
  String name;
  
  boolean firstFrameOpen;
  
  Setting[] settings = new Setting[0];
  
  Submenu(String name_, int index_, int[][] dataUsed_) {
    index = index_;
    name = name_;
    dataUsed = dataUsed_;
  }
  
  void render(boolean onlyRenderIfOpen) {
    if (open) {
      if (firstFrameOpen) {
        openNewSettings();
        firstFrameOpen = false;
      }
      //print(settings.length);
      for (Setting sett : settings) {
        //print(sett.settingIndex);
        sett.render();
      }
      fill(menuColor(submenuSpace, submenuSpace, 50, 100));
      rect(submenuSpace, submenuSpace, 100, 50);
    }
    else if (!onlyRenderIfOpen) {
      fill(menuColor(submenuSpace, (submenuHeight + submenuSpace)*index + submenuSpace, menuWidth-submenuSpace*2, submenuHeight));
      rect(submenuSpace, (submenuHeight + submenuSpace)*index + submenuSpace, menuWidth-submenuSpace*2, submenuHeight);
      textSize(submenuHeight-10);
      fill(0, 0, 90);
      text(name, submenuSpace + 5, (submenuHeight + submenuSpace)*index + submenuSpace + 23);
    }
  }
  
  void openNewSettings() {
    settings = new Setting[dataUsed[0].length + dataUsed[1].length + dataUsed[2].length + dataUsed[3].length];
    int b = 0;
    for (int t = 0; t < 4; t++) { //Cycling through data types
      for (int i = 0; i < dataUsed[t].length; i++) { //Cycling through the data
        print(b + "\n");
        settings[b] = new Setting(t, dataUsed[t][i], b);
        b++;
      }
    }
  }  
  
  void mouseUp() {
    for (int i = 0; i < settings.length; i++) {
      settings[i].mouseUp();
    }
  }
  
  void mouseDown() {
    for (int i = 0; i < settings.length; i++) {
      settings[i].mouseDown();
    }
  }
}
