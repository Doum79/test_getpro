import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:test_getpro/connection/register.dart';

import '../home.dart';

class Login extends StatefulWidget {
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController name = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  String msg = "";

  Future getData() async {
    var url = Uri.parse("http://xnova-ci.com/TestApi/login.php");
    final response = await http.post(url, body: {
      "email": name.text,
      "password": pass.text,
    });

    var data = json.decode(
      response.body,
    );
    if (data == "Success") {
      Fluttertoast.showToast(
          msg: "Connexion effectuer!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);

      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    } else {
      if (data == "Error") {
        Fluttertoast.showToast(
            msg: "Echec de connection !",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('                 Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: name,
                  decoration: InputDecoration(hintText: 'Email'),
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Email Required';
                    }
                  },
                ),
                TextFormField(
                  controller: pass,
                  obscureText: true,
                  decoration: InputDecoration(hintText: 'Password'),
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Password Required';
                    }
                    if (value.length < 8) {
                      return 'Password needs to  be at leas 8 Caractere';
                    }
                  },
                ),
                RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      getData();
                      //print('the form is valid');
                      //_formKey.currentState!.save();
                    }
                  },
                  child: Text('Connecter'),
                ),
                Text(
                  msg,
                  style: TextStyle(fontSize: 20.0, color: Colors.red),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Register()));
                      },
                      child: Text("Créer un compte",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          )))
                ])
              ],
            )),
      ),
    );
  }
}
