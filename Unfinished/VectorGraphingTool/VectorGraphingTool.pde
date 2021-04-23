float stepSize = 0.1;


//General settings
float scrollSpeedMult = 15;


int frame = 0;

//Colors
boolean darkMode = true;
color darkBackgroundColor = color(44, 47, 51);
color darkTextColor = color(255);
color darkGraphColor = color(44, 47, 51);
color darkGraphLineColor = color(255);
color darkErrorColor = color(168, 77, 90);
color darkSelectedColor = color(64, 68, 74);

color lightBackgroundColor = color(240);
color lightTextColor = color(44, 47, 51);
color lightGraphColor = color(255);
color lightGraphLineColor = color(0);
color lightErrorColor = color(168, 77, 90);
color lightSelectedColor = color(64, 68, 74);

//Graph
Graph graph = new Graph();
PVector graphPos = new PVector(500, 25);
PVector graphSize = new PVector(1400-500-25, 850);


//Function Boxes
PVector functionBoxSize = new PVector(350, 160);
float functionBoxSmallSize = 40;
float functionBoxSpace = 10;
PVector functionBoxPos = new PVector(25, 25);
float functionBoxWindow = 850;

float inputOffsetFromSide = 4;
float inputTopSpace = 4;
float inputTopOffset = 40;
float scrollOffset;
float inputBoxHeight = (functionBoxSize.y-4*inputTopSpace-inputTopOffset)/4;
float inputBoxLength = functionBoxSize.x-inputOffsetFromSide*2;
float textInputBoxOffset = 5;





//Javascript automatic string to code math stuff
import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;
import javax.script.ScriptException;
final ScriptEngine js = new ScriptEngineManager().getEngineByName("javascript");


int framesBetweenTypingChar = 40;
boolean showTypingChar = false;


Function[] functions = new Function[20];
boolean selected = false;
int selectedFunctionIndex = 0;
int selectedFieldIndex = 0;

String availableChars = "+-*/^%.()0123456789cosin";
char powerChar = '^';

String evaluation;
boolean bool;

PVector lastMousePos = new PVector(0, 0);

void setup() {
  size(1400, 900);
  for (int i = 0; i < functions.length; i++) {
    functions[i] = new Function(i);
  }
}

//Substring
// str = "abcdef"
// str.substring(2) = cdef
// str.substring(0, 2) = ab
// str.substring(2, 4) = cd

void draw() {
  background(darkMode ? darkBackgroundColor : lightBackgroundColor);
  if (mousePressed && mouseButton == LEFT && mouseOn(graphPos.x, graphPos.y, graphSize.x, graphSize.y)) {
    graph.pan.add(new PVector(mouseX-lastMousePos.x, mouseY-lastMousePos.y));
  }
  drawFunctionBoxes();
  graph.drawGraph();
  lastMousePos = new PVector(mouseX, mouseY);
  
  if (frame % framesBetweenTypingChar == 0) {
    showTypingChar = !showTypingChar;
  }
  
  frame++;
  
  drawFunctions();
}

void drawFunctionBoxes() {
  for (int i = 0; i < functions.length; i++) {
    functions[i].show();
  }
  
  fill(darkMode ? darkBackgroundColor : lightBackgroundColor);
  noStroke();
  rect(functionBoxPos.x-5, 0, functionBoxSize.x+10, functionBoxPos.y);
  rect(functionBoxPos.x-5, functionBoxPos.y + functionBoxWindow, functionBoxSize.x+10, functionBoxPos.y);
}

void keyPressed() {
  if (selected) {
    if (key == BACKSPACE && functions[selectedFunctionIndex].inputfield[selectedFieldIndex].value.length() > 0) {
      functions[selectedFunctionIndex].inputfield[selectedFieldIndex].value = functions[selectedFunctionIndex].inputfield[selectedFieldIndex].value.substring(0, functions[selectedFunctionIndex].inputfield[selectedFieldIndex].value.length()-1);
    }
    if (selectedFieldIndex < 2) {
      if (availableChars.indexOf(key) >= 0 || key == 't') functions[selectedFunctionIndex].inputfield[selectedFieldIndex].value += key;
      print(calculate(functions[selectedFunctionIndex].inputfield[selectedFieldIndex].value) + ", error: " + functions[selectedFunctionIndex].error[selectedFieldIndex] + ", empty: " + functions[selectedFunctionIndex].empty[selectedFieldIndex] + "\n");
      functions[selectedFunctionIndex].inputfield[selectedFieldIndex].valueChanged();
    }
    else if (selectedFieldIndex >= 2) {
      if (availableChars.indexOf(key) >= 0) {
        functions[selectedFunctionIndex].inputfield[selectedFieldIndex].value += key;
        print(calculate(functions[selectedFunctionIndex].inputfield[selectedFieldIndex].value) + ", error: " + functions[selectedFunctionIndex].error[selectedFieldIndex] + ", empty: " + functions[selectedFunctionIndex].empty[selectedFieldIndex] + "\n");
        functions[selectedFunctionIndex].inputfield[selectedFieldIndex].valueChanged();
      }
    }
  }
  
  print(functions[selectedFunctionIndex].inputfield[selectedFieldIndex].value + "\n");
}

boolean mouseOn(float sx, float sy, float x, float y) {
  return (mouseX >= sx && mouseX <= sx+x && mouseY >= sy && mouseY <= sy+y);
}

void checkError(String input) {
  String actualFunction = replacePower(replaceCos(replaceSin(replaceT(input, 1))));
  evaluation = eval(actualFunction, js);
  bool = boolean(evaluation);
}

float calculate(String input) {
  String actualFunction = replacePower(replaceCos(replaceSin(input)));
  evaluation = eval(actualFunction, js);
  bool = boolean(evaluation);
  return (functions[selectedFunctionIndex].error[selectedFieldIndex] ? 0 : float(evaluation));
}

String replaceT(String initial, float t) {
  String result = initial;
  for (int i = 0; i < result.length(); i++) {
    if (result.charAt(i) == 't') {
      String part1 = result.substring(0, i);
      String part2 = result.substring(i+1, result.length());
      result = ("" + part1 + "" + str(t) + part2);
    }
  }
  return result;
}

String replacePower(String initial) {
  String result = initial;
  
  while (result.indexOf(powerChar) >= 0) {
    for (int i = 0; i < result.length(); i++) {
      if (result.charAt(i) == powerChar) {
        
        int startIndex = 0;
        int endIndex = i;
        
        int fullStartIndex;
        int fullEndIndex;
        
        //Thing to apply power to is in brackets, checking for brackets
        if (i > 0) {
          if (result.charAt(i-1) == ')') {
            int additionalBrackets = 0;
            
            for (int b = i-2; b > 0; b--) {
              if (result.charAt(b) == '(') {
                if (additionalBrackets == 0) startIndex = b;
                else additionalBrackets--;
              }
              else if (result.charAt(b) == ')') additionalBrackets++;
            }
          }
          //Thing to apply power to is simply a number
          else {
            for (int b = i-1; b > 0; b--) {
              if (!("0123456789.".indexOf(result.charAt(b)) >= 0)) break;
              startIndex = b;
            }
          }
        }
        fullStartIndex = startIndex;
        String number1 = result.substring(startIndex, endIndex);
        
        startIndex = i+1;
        
        if (i+1 < result.length()) {
          //Power is in brackets, checking for brackets
          if (result.charAt(i+1) == '(') {
            int additionalBrackets = 0;
            
            for (int b = i+2; b < result.length(); b++) {
              if (result.charAt(b) == ')') {
                if (additionalBrackets == 0) endIndex = b;
                else additionalBrackets--;
              }
              else if (result.charAt(b) == '(') additionalBrackets++;
            }
          }
          //Thing to apply power to is simply a number
          else {
            for (int b = i+1; b < result.length(); b++) {
              if (!("0123456789.".indexOf(result.charAt(b)) >= 0)) break;
              endIndex = b;
            }
          }
        }
        endIndex++;
        fullEndIndex = endIndex;
        
        String number2 = result.substring(startIndex, endIndex);
        String part1 = result.substring(0, fullStartIndex);
        String part2 = result.substring(fullEndIndex, result.length());
        result = (part1 + "Math.pow(" + number1 + ", " + number2 + ")" + part2);
        break;
      }
    }
  }
  return result;
}

String replaceCos(String initial) {
  String result = initial;
  result = result.replace("cos", "Math.cos");
  return result;
}

String replaceSin(String initial) {
  String result = initial;
  result = result.replace("sin", "Math.sin");
  return result;
}


boolean contains(String input, char c) {
  return input.indexOf(c) >= 0;
}

void drawFunctions() {
  for (int f = 0; f < functions.length; f++) {
    if (!functions[f].hasError() && !functions[f].hasEmpty()) {
      graph.drawFunction(functions[f]);
    }
  }
}

void mousePressed() {
  if (mouseButton == LEFT) {
    selected = false;
    if (mouseOn(functionBoxPos.x, functionBoxPos.y, functionBoxSize.x, functionBoxWindow)) {
      for (int f = 0; f < functions.length; f++) {
        if (mouseOn(functionBoxPos.x, functionBoxPos.y + f*(functionBoxSize.y+functionBoxSpace) + scrollOffset, functionBoxSize.x, functionBoxSize.y)) {
          for (Inputfield field : functions[f].inputfield) {
            selected = field.mouseDown();
            print(field.index + " " + selected);
            if (selected) {
              selectedFieldIndex = field.index;
              selectedFunctionIndex = f;
              break;
            }
          }
          break;
        }
        /*
        for (int i = 0; i < 3; i++) {
          if (mouseOn(functionBoxPos.x+inputOffsetFromSide, functionBoxPos.y + f*(functionBoxSize.y+functionBoxSpace) + i*(inputBoxHeight+inputTopSpace) + inputTopOffset+scrollOffset, functionBoxSize.x-inputOffsetFromSide*2, inputBoxHeight)) {
            selectedFunctionIndex = f;
            functionSelected = true;
            selectedFieldIndex = i;
          }
        }
        */
      }
    }
    else selected = false;
  }
}

void mouseWheel(MouseEvent event) {
  if (mouseOn(functionBoxPos.x, functionBoxPos.y, functionBoxSize.x, functionBoxWindow)) {
    scrollOffset -= event.getCount()*scrollSpeedMult;
    scrollOffset = constrain(scrollOffset, -(functions.length*(functionBoxSize.y+functionBoxSpace)-functionBoxSpace-functionBoxWindow), 0);
  }
  else if (mouseOn(graphPos.x, graphPos.y, graphSize.x, graphSize.y)) {
    graph.scale -= event.getCount()*0.1*graph.scale;
    graph.scale = constrain(graph.scale, 20, 100000);
  }
}


String eval(String expression, ScriptEngine engine) {
  try {
    functions[selectedFunctionIndex].error[selectedFieldIndex] = false;
    functions[selectedFunctionIndex].empty[selectedFieldIndex] = false;
    return engine.eval(expression).toString();
  }
  catch (ScriptException ex) {
    functions[selectedFunctionIndex].error[selectedFieldIndex] = true;
    return null;
  }
  catch (NullPointerException npe) {
    functions[selectedFunctionIndex].empty[selectedFieldIndex] = true;
    return "0";
  }
}
