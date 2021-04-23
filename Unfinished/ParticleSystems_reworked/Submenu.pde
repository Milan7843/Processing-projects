class Submenu {
  boolean open;
  int index;
  
  String[] dataUsed;
  String name;
  
  boolean firstFrameOpen;
  
  Setting[] settings = new Setting[0];
  
  Submenu(String name_, int index_, String[] dataUsed_) {
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
      int i = 0;
      for (Setting sett : settings) {
        scroll = constrain(scroll, -height+settingSpace*(settings.length+2)+settingHeight*(settings.length+1), 0);
        sett.render(i);
        i++;
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
    for (Setting s : setting) {
      s.open = false;
    }
    settings = new Setting[dataUsed.length];
    for (int i = 0; i < dataUsed.length; i++) {
      settings[i] = findSetting(dataUsed[i]);
      settings[i].open = true;
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
