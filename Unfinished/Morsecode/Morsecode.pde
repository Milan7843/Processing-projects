//String input = ".- / -... / -.-. / -.. / . / ..-. / --. / .... / .. / .--- / -.- / .-.. / -- / -. / --- / .--. / --.- / .-. / ... / - / ..- / ...- / .-- / -..- / -.-- / --.. / ----- / .---- / ..--- / ...-- / ....- / ..... / -.... / --... / ---.. / ----. / -.-.-. / ---... / .----. / -..-. / .-... / -...- / .-.-. / -....- / ..--.- / -.--. / .-.-. / ...-. / ........ / ...-.- / --..-- / -.-.- / .-.-.- / --..-- / ..--..";
String input = "Hallo ik heet milan '[]56";
String[] morseLetters = {"/", ".-", "-...", "-.-.", "-..", ".", "..-.", "--.", "....", "..", ".---", "-.-", ".-..", "--", "-.", "---", ".--.", "--.-", ".-.", "...", "-", "..-", "...-", ".--", "-..-", "-.--", "--..", "-----", ".----", "..---", "...--", "....-", ".....", "-....", "--...", "---..", "----.", "-.-.-.", "---...", ".----.", "-..-.", "-...-", ".-.-.", "-....-", "..--.-", "-.--.", ".-.-.", "...-.", "........", "...-.-", "--..--", "-.-.-", ".-.-.-", "--..--", "..--.."};
//String input = "Hallo";
String[] letters = {" ", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", ";", ":", "'", "/", "=", "+", "-", "_", ")", "(", "^", "%", "$", "#", "@", "!", "~", ".", ",", "?",};
String[] morse = split(input, " ");
String[] ascii = split(input, "");
String output = "";
int frames = 0;
boolean morseToLetters = false;

void setup() {
  size(600, 600);

}

void draw() {
  frames++;
  if (frames == 2 && morseToLetters) {
    for(int i = 0; i < morse.length; i++) {
      for (int x = 0; x < morseLetters.length; x++) {
        if (morse[i].equals(morseLetters[x])) {
          output += letters[x];
        }
      } 
    }
  }
  else if (frames == 2 && !morseToLetters) {
    for(int i = 0; i < ascii.length; i++) {
      for (int x = 0; x < letters.length; x++) {
        if (letters[i].equals(ascii[x])) {
          output += morseLetters[x];
        }
      } 
    }
  }
  background(240);
  fill(0);
  text(output, 10, 50);
}
