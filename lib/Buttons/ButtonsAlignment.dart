import 'package:flutter/cupertino.dart';

import 'buttons.dart';

class ButtonsAlignment extends StatelessWidget {
 final String b1,b2,b3,b4;
final Function? click;
  const ButtonsAlignment({super.key,required this.b1,required this.b2,required this.b3,this.b4=".",required this.click});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Padding(
      padding: EdgeInsets.all(5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Buttons(number: b1 ,click: click! ),
          const SizedBox(width: 10,),
          Buttons(number: b2,click: click!),
          const SizedBox(width: 10,),
          Buttons(number: b3,click :click!),
          const SizedBox(width: 10,),
          Buttons(number: b4,click:click!),
        ],
      ),
    ));
  }
}
