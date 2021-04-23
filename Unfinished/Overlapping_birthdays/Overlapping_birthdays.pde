//Overlapping birthdays
//Shows that even when there's just 23 people in a room, there is a 50% chance a birthday overlaps
int subjectAmount = 23;
PVector[] date = new PVector[subjectAmount];
float chance;
float totalOverLappedBirthdays;
float totalCheckedTimes;
float time = 0;
float timeBeforeThisCalculation = 0;

void setup() {
  frameRate(20000);
}

void draw() {
  
  //Setting birthdays to random integers
  resetBirthdays();
  
  //Checking how many people overlap this time
  if (overLappingBirthdays() >= 1) {
    totalOverLappedBirthdays++;
  }
  totalCheckedTimes++;
  
  time += 1/frameRate;
  
  //Printing data
  if (totalCheckedTimes % 100 == 0) {
    print("Currently: " + totalOverLappedBirthdays + "/" + totalCheckedTimes + " times a birthday overlapped, making it " + (100*totalOverLappedBirthdays/totalCheckedTimes) + "%, total calculation time: " + 
    time + "s, this calculation: " + (time-timeBeforeThisCalculation)*1000 + "ms\n");
  }
  timeBeforeThisCalculation = time;
}

void resetBirthdays() {
  for (int i = 0; i < subjectAmount; i++) {
    date[i] = new PVector((int)random(0, 31), (int)random(0, 12));
  }
}

int overLappingBirthdays() {
  int amt = 0;
  for (int i = 0; i < subjectAmount; i++) {
    for (int b = 0; b < subjectAmount; b++) {
      
      //Checks whether one birthday is the same as the other, and making sure it is not the same person
      if (date[i].x == date[b].x && date[i].y == date[b].y && i != b) {
        amt++;
      }
    }
  }
  return amt;
}
