import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  IconAlignment _iconAlignment = .start;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
        color: Colors.blue,
        padding: EdgeInsets.all(16),
        child: 
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)

                  ),
                  child: Column(
                    children: [
                      FlutterLogo(size: 76,),
                      SizedBox(height: 16,),
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: 'Email'
                        ),

                      ),
                      SizedBox(height: 16,),
                      TextField(
                        
                        obscureText: true,
                        controller: _senhaController,
                        decoration: InputDecoration(
                          hintText: 'Senha'
                        ),

                      ),
                      SizedBox(height: 16,),
                      ElevatedButton(onPressed: () {}, child: Text('entrar')),
                      SizedBox(height: 16,),
                      
                      Container(
                        child: Column(
                          children: <Widget>[
                            ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.supervised_user_circle_outlined),
                              label: const Text(''),
                              iconAlignment: _iconAlignment,
                            ),
                          ],
                        ),
                      ),
                                  
                      SizedBox(height: 16,),
                      TextButton(onPressed: ((){}), child: Text('Criar Conta'))

                    ],
                  ),
                )

              ],
            ),
          )

        ,


      ),
   

    );
  }
}