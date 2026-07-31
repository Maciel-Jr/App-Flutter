import 'package:flutter/material.dart';

void teste (){
  print("Botão clicado");
}

class MyPageApp extends StatelessWidget {
  const MyPageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: 
          Center(
            child:  FilledButtonteste(),
          ) ,     

        
       
      );
  }
}



class FilledButtonteste extends StatelessWidget{
  const FilledButtonteste({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Padding(
      padding: .all(4.0),
      child: Row(
        children: <Widget>[
          Spacer(),
          FilledButtonteste2(enabled: true, valorTexto: 'teste teste teste'),
          Spacer(),

        ],

      ),
      
      );
  }

}

class FilledButtonteste2 extends StatelessWidget{
  const FilledButtonteste2 ({super.key, required this.enabled, required this.valorTexto});

  final bool enabled;
  final String valorTexto;

  @override
  Widget build(BuildContext context) {
    final VoidCallback? onPressed = enabled ? () {} : null;
    // TODO: implement build
    return Padding(
      padding: const .all(4.0),
      child: Column(
        mainAxisAlignment: .spaceEvenly,
        children: <Widget>[
          FilledButton(onPressed: onPressed, child:  Text(valorTexto))


        ],


      ),
      
      );
  }


}