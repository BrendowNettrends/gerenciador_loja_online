import 'package:flutter/material.dart';
import 'package:gerenciador_loja_online/blocs/login_bloc.dart';
import 'package:gerenciador_loja_online/widgets/input_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _loginBloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(),
          SingleChildScrollView(
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
                    stream: _loginBloc.outEmail,
                    onChanged: _loginBloc.changeEmail,
                  ),
                  InputField(
                    icon: Icons.lock_outline,
                    hint: "Senha",
                    obscure: true,
                    stream: _loginBloc.outPassword,
                    onChanged: _loginBloc.changePassword,
                  ),
                  SizedBox(height: 32,),
                  StreamBuilder<bool>(
                    stream: _loginBloc.outSubmitValid,
                    builder: (context, snapshot) {
                      return SizedBox(
                        child: RaisedButton(
                          color: Colors.greenAccent,
                          child: Text("Entrar"),
                          onPressed: snapshot.hasData ? _loginBloc.submit : null,
                          textColor: Colors.white,
                          disabledColor: Colors.greenAccent.withAlpha(140),
                        ),
                      );
                    }
                  )
                ],
              ),
            )
          ),
        ],
      )
    );
  }
}
