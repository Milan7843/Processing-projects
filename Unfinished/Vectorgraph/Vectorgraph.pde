String function = "(3.76/26)*2*(4-2)";
ArrayList<String> parts = new ArrayList<String>();
char[] functionChars = {'*', '/', '+', '-'};
String temporaryFunction = function;


void setup() {
  String str = "abcdef";
  //print(str.substring(2, 3));
  for (String st : parts) {
    //print(st);
  }
  //print(stringContainsThing(str));
  splitFunctionIntoParts();
}


void draw() {
  
}

//Substring
// str = "abcdef"
// str.substring(2) = cdef
// str.substring(0, 2) = ab
// str.substring(2, 4) = cd


void splitFunctionIntoParts() {
  //while (stringContainsThing(temporaryFunction)) {
    for (int i = 0; i < temporaryFunction.length(); i++) {
      if (temporaryFunction.charAt(i) == '(') {
        int openBracketIndex = i;
        int closeBracketIndex = i+1;
        for (int b = i+1; b < temporaryFunction.length(); b++) {
          if (temporaryFunction.charAt(b) == '(') {
            openBracketIndex = b;
          }
          else if (temporaryFunction.charAt(b) == ')') {
            closeBracketIndex = b;
            break;
          }
        }
        
        int functionCharIndex = getNextFunctionCharacter(openBracketIndex, temporaryFunction);
        char functionChar = temporaryFunction.charAt(functionCharIndex);
        
        print(temporaryFunction.substring(openBracketIndex+1, functionCharIndex));
        print("\n");
        print(temporaryFunction.substring(functionCharIndex+1, closeBracketIndex));
        
        break;
      }
    }
  //}
  temporaryFunction = function;
}

void calculate(char functionChar) {
  
}

int getNextFunctionCharacter(int startIndex, String str) {
  for (int i = startIndex+1; i < str.length(); i++) {
    boolean isFunctionChar = false;
    for (int b = 0; b < functionChars.length; b++) {
      if (str.charAt(i) == functionChars[b]) {
        isFunctionChar = true;
        break;
      }
    }
    if (isFunctionChar) {
      return i;
    }
  }
  print("Error: no fucntion character was found");
  return 0; //Closing bracket was not found, error should be displayed
}

int getNextClosingBracket(int startIndex, String str) {
  for (int i = startIndex+1; i < str.length(); i++) {
    if (str.charAt(i) == ')') {
      return i;
    }
  }
  print("Error: Closing bracket not found, check if all opening brackets have corresponding closing brackets");
  return 0; //Closing bracket was not found, error should be displayed
}

boolean stringContainsThing(String str) {
  boolean contains = false;
  for (int i = 0; i < str.length(); i++) {
    char c = str.charAt(i);
    for (int b = 0; b < functionChars.length; b++) {
      if (functionChars[b] == c) {
        contains = true;
        break;
      }
    }
  }
  return contains;
}

String stringUntil(String in, char c) {
  String temp = "";
  for (int i = 0; i < in.length(); i++) {
    if (in.charAt(i) == c) {
      return temp;
    }
    temp += in.charAt(i);
    print();
  }
  return in;
}
