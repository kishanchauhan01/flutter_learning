import 'package:calculatork/buttons.dart';

class Functionality {
  static String myInput = "";
  static bool isDotUse = false;
  static bool isOperatorUse = false;

  static void appendInput(String s, Function setState) {
    setState(() {
      switch (s) {
        case String digit when Buttons.digitButtons.contains(s):
          myInput += digit;
          isOperatorUse = false;
          break;

        case "AC":
          myInput = "";
          break;

        case "⌫":
          if (myInput.isNotEmpty) {
            myInput = myInput.substring(0, myInput.length - 1);
          }
          break;

        case ".":
          if (isDotUse) {
            return;
          }
          if (myInput.isEmpty) {
            myInput = "0.";
            isDotUse = true;
          } else {
            myInput += ".";
            isDotUse = true;
          }
          break;

        case String op when Buttons.operatorButtons.contains(s):
          if (op == "=" && myInput.isNotEmpty) {
            myInput = calculate(myInput);
          } else if (!isOperatorUse) {
            myInput += op;
            isOperatorUse = true;
            isDotUse = false;
          }
      }
    });
  }

  static List<String> tokenize(String expression) {
    List<String> tokens = [];
    String numberBuffer = "";

    for (int i = 0; i < expression.length; i++) {
      String ch = expression[i];
      if (RegExp(r'[0-9.]').hasMatch(ch)) {
        numberBuffer += ch;
      } else if (Buttons.operatorButtons.contains(ch)) {
        if (numberBuffer.isNotEmpty) {
          tokens.add(numberBuffer);
          numberBuffer = "";
        }
        tokens.add(ch);
      }
    }

    if (numberBuffer.isNotEmpty) {
      tokens.add(numberBuffer);
    }

    return tokens;
  }

  static int precedence(String op) {
    if (op == "+" || op == "-") return 1;
    if (op == "*" || op == "÷") return 2;
    return 0; // Default precedence for unknown operators
  }

  static String calculate(String expression) {
    List<String> tokens = tokenize(expression);
    List<String> ansQueue = [];
    List<String> operators = [];
    List<String> operands = [];
    double ans = 0;
    print(tokens);

    for (int i = 0; i < tokens.length; i++) {
      //Infix  to postfix
      String ch = tokens[i];
      if (!Buttons.operatorButtons.contains(ch)) {
        ansQueue.add(ch);
      } else if (Buttons.operatorButtons.contains(ch)) {
        if (operators.isEmpty) {
          operators.add(ch);
        } else if (precedence(ch) > precedence(operators.last)) {
          operators.add(ch);
        } else {
          while (operators.isNotEmpty &&
              precedence(operators.last) >= precedence(ch)) {
            String temp = operators.removeLast();
            ansQueue.add(temp);
          }
          if (operators.isEmpty) {
            operators.add(ch);
          }
        }
      }
    }

    while (operators.isNotEmpty) {
      ansQueue.add(operators.removeLast());
    }

    //evaluate postfix
    for (int i = 0; i < ansQueue.length; i++) {
      String ch = ansQueue[i];
      if (!Buttons.operatorButtons.contains(ch)) {
        operands.add(ch);
      } else if (Buttons.operatorButtons.contains(ch)) {
        double num1 = double.parse(operands.removeLast());
        double num2 = double.parse(operands.removeLast());

        switch (ch) {
          case "+":
            ans = num2 + num1;
            operands.add(ans.toString());
            break;

          case "-":
            ans = num2 - num1;
            operands.add(ans.toString());
            break;

          case "*":
            ans = num2 * num1;
            operands.add(ans.toString()); 
            break;

          case "/":
            ans = num2 / num1;
            operands.add(ans.toString());
            break;
        }
      }
    }
    print(ansQueue);
    print(operands);

    ans = double.parse(operands.last);

    if (ans % 1 == 0) {
      return ans.toInt().toString();
    } else {
      return ans.toString();
    }
  }
}
