import 'package:flutter_crud/principal.dart';
import 'package:flutter/material.dart';

String login_example = 'Lulu';
String pass_example = '12345';

class FirstRoute extends StatefulWidget {
  @override
  State<FirstRoute> createState() => _FirstRouteState();
}

class _FirstRouteState extends State<FirstRoute> {
  @override
  Widget build(BuildContext context) {
    TextEditingController loginValue = new TextEditingController();
    TextEditingController passwordValue = new TextEditingController();
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
            width: 300,
            height: 80,
            child: TextField(
              controller: loginValue,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "User"),
            ),
          ),
          SizedBox(
            width: 300,
            height: 100,
            child: TextField(
              controller: passwordValue,
              obscureText: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "Password"),
            ),
          ),
          ElevatedButton(
              child: const Text('Logar'),
              onPressed: () {
                passwordValue.text == pass_example &&
                        loginValue.text == login_example
                    ? Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => MainScreen()))
                    : showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const AlertDialog(
                            title: Text("Ops!"),
                            content: Text("Senha ou Login Invalidos"),
                          );
                        },
                      );
              }),
          const ElevatedButton(onPressed: (null), child: Text("Cadastro"))
        ]),
      ),
    );
  }
}
