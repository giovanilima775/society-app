import 'package:flutter/material.dart';
import 'package:society_app/home_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 180,
                  height: 180,
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
                    labelText: 'Senha',
                    border: OutlineInputBorder()
                  ),
                ),
                Container(                  
                  height: 10,
                ),
                TextField(
                  onChanged: (text) {
                    email = text;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    border: OutlineInputBorder()
                  ),
                ),
                Container(                  
                  height: 10,
                ),               
                RaisedButton(
                  child: Text('Enviar'),
                  onPressed: () {
                    //faz alguma coisa
                  },
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}