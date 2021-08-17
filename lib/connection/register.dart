import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'login.dart';



class Register extends StatefulWidget {
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController name = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  TextEditingController num = new TextEditingController();
  TextEditingController mail = new TextEditingController();
  String msg = "";

  Future regist() async {
    var url = Uri.parse("http://xnova-ci.com/TestApi/register.php");
    final response = await http.post(url, body: {
      "nom": name.text,
      "password": pass.text,
      "email": mail.text,
      "numero": num.text,
    });

    var data = json.decode(
      response.body,
    );
    if (data == "Error") {
      Fluttertoast.showToast(
          msg: "Echec d'inscription",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      if (data == "Success") {
        Fluttertoast.showToast(
            msg: "Inscription effectuer",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('                 Compte'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: name,
                  decoration: InputDecoration(hintText: 'Nom'),
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Nom Required';
                    }
                  },
                ),
                TextFormField(
                  controller: mail,
                  decoration: InputDecoration(hintText: 'Email'),
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Email Required';
                    }
                  },
                ),
                TextFormField(
                  controller: num,
                  decoration: InputDecoration(hintText: 'Numero'),
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Numero Required';
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
                      regist();
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
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Text("Connectez-vous",
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
