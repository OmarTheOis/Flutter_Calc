import 'package:calculator/Buttons/ButtonsAlignment.dart';
import 'package:calculator/Buttons/buttons.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Calc());
}

class Calc extends StatefulWidget {

  const Calc({super.key});

  @override
  State<Calc> createState() => _CalcState();
}

class _CalcState extends State<Calc> {
  String b = "";
  String A = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Container(
          color: Colors.black,
          child: Column(
            children: [
              const SizedBox(height: 30,),

              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.centerLeft,
                  child:
                  SelectableText(
                    b,
                    showCursor: true,
                    style: const TextStyle(fontSize: 35, color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(A,
                    style: const TextStyle(fontSize: 35, color: Colors.white60),
                  ),
                ),
              ),
              const Divider(thickness: 2, color: Colors.white,),
              ButtonsAlignment(b1: "7",
                b2: "8",
                b3: "9",
                b4: "×",
                click: onClick,),
              ButtonsAlignment(b1: "4",
                b2: "5",
                b3: "6",
                b4: "-",
                click: onClick,),
              ButtonsAlignment(b1: "1",
                b2: "2",
                b3: "3",
                b4: "+",
                click: onClick,),
              ButtonsAlignment(b1: ".",
                b2: "0",
                b3: "%",
                b4: "÷",
                click: onClick,),

              Container(
                  height: 100,
                  padding: const EdgeInsets.all(5),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              b = "";
                              A="";
                              setState(() {});
                            },
                            style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                backgroundColor: Colors.red
                            ),
                            child: const Text("AC", style: TextStyle(fontSize: 30),),
                          ),
                        ),

                        const SizedBox(width: 10,),

                        Expanded(
                          child: ElevatedButton(onPressed: () {
                            b =b.substring(0, b.length - 1);
                            A="";
                            setState(() {
                            });
                            A=calculateuntill(b);
                            setState(() {
                            });
                          },
                            style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                backgroundColor: const Color(0xFF282C34)
                            ),
                            child: const Text("⌫", style: TextStyle(fontSize: 30,
                                fontWeight: FontWeight.w400),),
                          ),

                        ), const SizedBox(width: 10,),

                        Expanded(
                          flex: 2,
                          child: ElevatedButton(onPressed: () {
                            calculate(b);
                          },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(200),
                                ),

                                backgroundColor: Colors.green
                            ),
                            child: const Text("=", style: TextStyle(fontSize: 30),),
                          ),
                        ),
                        const SizedBox(width: 10,),
                      ])
              )
            ],
          ),
        )

      ),

    );
  }
  List<String> inputList = [];
  onClick(String text) {
    // print(text);
    b += text;
    setState(() {});
    if (b.contains("+")||b.contains("-")||b.contains("÷")||b.contains("×")) {
      calculateuntill(b);
    }
  }

  calculate(String input) {
    List<String> inputList = [];
    int index = 0;
    input = input.replaceAll('×', '#*#');
    input = input.replaceAll('+', '#+#');
    input = input.replaceAll('÷', '#/#');
    input = input.replaceAll('-', '#-#');
    input = input.replaceAll('%', '#%');
    print(input);
    for (int i = 0; i < input.length; i++) {
      inputList = input.split("#");
    }
    print(inputList);
    while (index < inputList.length) {
      if (inputList.contains("%")) {
        if (inputList[index] == "%") {
          double result = int.parse(inputList[index - 1]) / 100;
          inputList.replaceRange(index - 1, index + 1, [result.toString()]);
          index++;
        }
        else {
          index++;
        }
      }
      else {
        break;
      }
    }
    index = 0;
    while (index < inputList.length) {
      if (inputList.contains("*") || inputList.contains("/")) {
        if (inputList[index] == "/") {
          double result = (double.parse(inputList[index - 1])) /
              (double.parse(inputList[index + 1])) + 0.0;
          inputList.replaceRange(index - 1, index + 2, [result.toString()]);
          index = 0;
        }
        else if (inputList[index] == "*") {
          double result = (double.parse(inputList[index - 1])) *
              (double.parse(inputList[index + 1])) + 0.0;
          inputList.replaceRange(index - 1, index + 2, [result.toString()]);
          index = 0;
        }
        else {
          index++;
        }
      } else {
        break;
      }
    }
    index = 0;
    while (index < inputList.length) {
      if (inputList.contains("+") || inputList.contains("-")) {
        if (inputList[index] == "-") {
          double result = (double.parse(inputList[index - 1])) -
              (double.parse(inputList[index + 1])) + 0.0;
          inputList.replaceRange(index - 1, index + 2, [result.toString()]);
          index = 0;
        }
        else if (inputList[index] == "+") {
          double result = (double.parse(inputList[index - 1])) +
              (double.parse(inputList[index + 1])) + 0.0;
          inputList.replaceRange(index - 1, index + 2, [result.toString()]);
          index = 0;
        }
        else {
          index++;
        }
      } else {
        break;
      }
    }
    List<String> x = [];
    x = inputList[0].split(".");
    if (int.parse(x[1]) == 0) {
      inputList[0] = x[0];
    }
    b = inputList[0];
    A = "";
    setState(() {});
  }

  calculateuntill(String input) {
    if (input[0] == "-") input = "0" + input;

    int index = 0;
    input = input.replaceAll('×', '#*#');
    input = input.replaceAll('+', '#+#');
    input = input.replaceAll('÷', '#/#');
    input = input.replaceAll('-', '#-#');
    input = input.replaceAll('%', '#%');
    print(input);
    for (int i = 0; i < input.length; i++) {
      inputList = input.split("#");
    }
    print(inputList);
    while (index < inputList.length) {
      if (inputList.contains("%")) {
        if (inputList[index] == "%") {
          double result = double.parse(inputList[index - 1]) / 100;
          inputList.replaceRange(index - 1, index + 1, [result.toString()]);
          index++;
        }
        else {
          index++;
        }
      }
      else {
        break;
      }
    }
    index = 0;
    while (index < inputList.length) {
      if (inputList.contains("*") || inputList.contains("/")) {
        if (inputList[index] == "/") {
          double result = (double.parse(inputList[index - 1])) /
              (double.parse(inputList[index + 1])) + 0.0;
          inputList.replaceRange(index - 1, index + 2, [result.toString()]);
          index = 0;
        }
        else if (inputList[index] == "*") {
          double result = (double.parse(inputList[index - 1])) *
              (double.parse(inputList[index + 1])) + 0.0;
          inputList.replaceRange(index - 1, index + 2, [result.toString()]);
          index = 0;
        }
        else {
          index++;
        }
      } else {
        break;
      }
    }
    index = 0;
    while (index < inputList.length) {
      if (inputList.contains("+") || inputList.contains("-")) {
        if (inputList[index] == "-") {
          double result = (double.parse(inputList[index - 1])) -
              (double.parse(inputList[index + 1])) + 0.0;
          inputList.replaceRange(index - 1, index + 2, [result.toString()]);
          index = 0;
        }
        else if (inputList[index] == "+") {
          double result = (double.parse(inputList[index - 1])) +
              (double.parse(inputList[index + 1])) + 0.0;
          inputList.replaceRange(index - 1, index + 2, [result.toString()]);
          index = 0;
        }
        else {
          index++;
        }
      } else {
        break;
      }
    }
    List<String> x = [];
    x = inputList[0].split(".");
    if (int.parse(x[1]) == 0) {
      inputList[0] = x[0];
    }
    //if(inputList[0].length>=3) inputList[0]= inputList[0].replaceFirst(inputList[0][0], inputList[0][0]+",");
    A = inputList[0];
    setState(() {});
  }
}

