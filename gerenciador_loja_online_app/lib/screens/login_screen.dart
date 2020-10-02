import 'package:flutter/material.dart';
import 'package:gerenciador_loja_online/widgets/input_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.store_mall_directory,
                color: Colors.greenAccent,
                size: 160,
              ),
              InputField(
                icon: Icons.person_outline,
                hint: "Usuário",
                obscure: false,
              ),
              InputField(
                icon: Icons.lock_outline,
                hint: "Senha",
                obscure: true,
              ),
              SizedBox(height: 32,),
              SizedBox(
                child: RaisedButton(
                  color: Colors.greenAccent,
                  child: Text("Entrar"),
                  onPressed: () {},
                  textColor: Colors.white,
                ),
              )
            ],
          ),
        )
      )
    );
  }
}
