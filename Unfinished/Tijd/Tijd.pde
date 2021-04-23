int activities = 4;

String[] time;

//float beginTime, endTime;
String[] activityNames = {"gamen", "filmpjes", "programmeren", "school"};
color[] colors = {color(255, 149, 0), color(140, 255, 0), color(0, 166, 255), color(255, 0, 43)};
int[] totalTime = {0, 0, 0, 0};
PVector namesPos = new PVector(160, 10);
int totalBeginTime;
int totalEndTime;
PVector piePos = new PVector(510, 100);
float pieRadius = 80;
/*
color gamen = color(255, 149, 0);
color filmpjes = color(140, 255, 0);
color programmeren = color(0, 166, 255);
color school = color(255, 0, 43);
*/
void setup() {
  size(600, 600);
  time = loadStrings("tijd.txt");
  background(214, 255, 251);
  //fill(0);
  rect(65, 9, 50, 501); //Time bar
  textSize(20);
  totalBeginTime = toMinutes(time[0].substring(0, 5));
  totalEndTime = toMinutes(time[time.length-1].substring(6, 11));
  //totalEndTime = 20*60;
  for (int i = 0 ; i < time.length; i++) {
    //print(time[i] + "\n");
    int currAct = 0;
    for (int a = 0 ; a < activities; a++) {
      if ((time[i].substring(12)).equals(activityNames[a])) {
        currAct = a;
      }
    }
    int beginTime = toMinutes(time[i].substring(0, 5));
    int endTime = toMinutes(time[i].substring(6, 11));
    if (i == 0) {
      totalBeginTime = beginTime;
    }
    noStroke();
    fill(colors[currAct]);
    rect(66, map(beginTime, totalBeginTime, totalEndTime, 10, 510), 49, map(endTime, totalBeginTime, totalEndTime, 10, 510) - map(beginTime, totalBeginTime, totalEndTime, 10, 510));
    totalTime[currAct] += endTime-beginTime;
    fill(0);
    int hours = floor((endTime-beginTime)/60);
    int minutes = (endTime-beginTime)%60;
    textSize(13);
    text("0" + hours + ":" + minutes, 72, (map(beginTime, totalBeginTime, totalEndTime, 10, 510)+map(endTime, totalBeginTime, totalEndTime, 10, 510))/2+5);
  }
  fill(0);
  for (int i = 0 ; i < (totalEndTime-totalBeginTime)/15+1; i++) {
    textSize(15);
    int writeTime = totalBeginTime + i*15;
    int hours = floor((writeTime)/60);
    int minutes = (writeTime)%60;
    if (minutes == 0) {
      text(hours + ":00", 10, map(writeTime, totalBeginTime, totalEndTime, 10, 510)+4);
    }
    else {
      text(hours + ":" + minutes, 10, map(writeTime, totalBeginTime, totalEndTime, 10, 510)+4);
    }
    stroke(0);
    line(55, map(writeTime, totalBeginTime, totalEndTime, 10, 510), 62, map(writeTime, totalBeginTime, totalEndTime, 10, 510));
  }
  
  //Names and colors
  for (int i = 0 ; i < activities; i++) {
    fill(0);
    int hours = floor((totalTime[i])/60);
    int minutes = (totalTime[i])%60;
    if (minutes < 10) {
      text(activityNames[i] + ", " + hours + ":0" + minutes, namesPos.x+25, namesPos.y+15+i*30);
    }
    else {
      text(activityNames[i] + ", " + hours + ":" + minutes, namesPos.x+25, namesPos.y+15+i*30);
    }
    fill(colors[i]);
    rect(namesPos.x, namesPos.y+i*30, 20, 20);
  }
  
  //Pie chart
  int totalMinutes = totalEndTime - totalBeginTime;
  float totalAngle = 0;
  for (int i = 0 ; i < activities; i++) {
    fill(255);
    stroke(0);
    //circle(piePos.x, piePos.y, pieRadius*2 + 1);
    //noStroke();
    fill(colors[i]);
    float angle = map(totalTime[i], 0, totalMinutes, 0, 360);
    arc(piePos.x, piePos.y, pieRadius*2, pieRadius*2, radians(totalAngle), radians(totalAngle) + radians(angle), PIE);
    //arc(piePos.x, piePos.y, pieRadius*2, pieRadius*2, 0, PI/3, PIE);
    totalAngle += angle;
    print(totalBeginTime + "  " + totalEndTime + "\n");
  }
  textSize(20);
  int totalTimes = 0;
  for (int i = 0 ; i < activities; i++) {
    totalTimes += totalTime[i];
  }
  fill(0);
  text("Totaal: " + floor((totalTimes)/60) + ":" + ((totalTimes)%60), piePos.x - 60, piePos.y+pieRadius+25);
}

int toMinutes(String input) {
  int hours = int(input.substring(0, 2));
  int minutes = int(input.substring(3, 5));
  return (hours*60 + minutes);
}
