import 'package:flutter/material.dart';
import 'package:society_app/home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 232,
                  height: 232,
                  child: Image.network(
                    'https://cdn4.iconfinder.com/data/icons/sports-outline-24-px/24/Ball_court_game_sport_tennis_game-512.png'
                  ),
                ),
                Container(
                  child: Text('Login', style: 
                    TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 32.0,
                    ),
                  ),
                ),
                TextField(
                  onChanged: (text) {
                    email = text;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    border: OutlineInputBorder()
                  ),
                ),
                Container(                  
                  height: 10,
                ),
                TextField(
                  onChanged: (text) {
                    password = text;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder()
                  ),
                ),
                RaisedButton(
                  child: Text('Entrar'),
                  onPressed: () {
                    //Chamar o a api passando os dados digitados
                    if(email == 'teste' && password == '123') {
                      Navigator.of(context).pushReplacementNamed('/home');
                    }else {
                      print('errado');
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: FlatButton(
                    onPressed: () {
                      //Chamar o a api passando os dados digitados
                      Navigator.of(context).pushNamed('/register');
                    },
                    child: Text('+ Novo Usuário'),
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}