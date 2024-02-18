import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  final String number;
 final Function click;
  const Buttons({super.key,required this.number,required this.click});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(onPressed:(){click(number);}, child:Text(number!),style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.green),
      textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 25))
    ),),);
  }
}
