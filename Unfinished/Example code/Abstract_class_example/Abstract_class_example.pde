Car[] cars = new Car[2];

void setup() {
  cars[0] = new Ford();
  cars[1] = new Audi();
  for(Car c : cars) {
    print(c.returnName() + "\n");
    c.honk();
  }
}
