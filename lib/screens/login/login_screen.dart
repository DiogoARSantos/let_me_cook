import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _nameFieldTouched = false;
  bool _passFieldTouched = false;

  bool _nameIsValid = true;
  bool _passIsValid = true;

  void validateName() {
    var value = _nameController.text;
    if (value.isEmpty) {
      setState(() {
        _nameIsValid = false;
      });
    } else {
      setState(() {
        _nameIsValid = true;
      });
    }
  }

  void validatePass() {
    var value = _passController.text;
    if (value.isEmpty || value.length < 3) {
      setState(() {
        _passIsValid = false;
      });
    } else {
      setState(() {
        _passIsValid = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      backgroundColor: Color(0xFFBF7979),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.always,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 100.0),
              Center(
                child: Container(
                  width: 300,
                  height: 400,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/images/logo.png",
                      ),
                      // Your image asset path
                      fit: BoxFit.contain,
                    ),
                    border: Border.all(
                      color: Colors.white, // Border color
                      width: 7.5, // Border width
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  textDirection: TextDirection.ltr,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Log In',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: _nameController,
                      cursorColor: Colors.white,
                      style: TextStyle(
                        color: (_nameFieldTouched && !_nameIsValid)
                            ? Color(0xFFA30000)
                            : Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Nome',
                        labelStyle: TextStyle(
                          color: (_nameFieldTouched && !_nameIsValid)
                              ? Color(0xFFA30000)
                              : Colors.white, // Default label color,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.white,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.white,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            width: 1,
                            color: Color(0xFFA30000),
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            width: 1,
                            color: Color(0xFFA30000),
                          ),
                        ),
                        errorStyle: TextStyle(
                          color: Color(0xFFA30000),
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      onEditingComplete: () {
                        setState(() {
                          _nameFieldTouched = true;
                        });
                        validateName();
                      },
                      onChanged: (_) {
                        validateName();
                      },
                      validator: (_) {
                        if (_nameFieldTouched && _nameController.text.isEmpty) {
                          return "Nome obrigatório";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: _passController,
                      cursorColor: Colors.white,
                      style: TextStyle(
                        color: (_passFieldTouched && !_passIsValid)
                            ? Color(0xFFA30000)
                            : Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Palavra-passe',
                        labelStyle: TextStyle(
                          color: (_passFieldTouched && !_passIsValid)
                              ? Color(0xFFA30000)
                              : Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.white,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.white,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            width: 1,
                            color: Color(0xFFA30000),
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            width: 1,
                            color: Color(0xFFA30000),
                          ),
                        ),
                        errorStyle: TextStyle(
                          color: Color(0xFFA30000),
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      onEditingComplete: () {
                        setState(() {
                          _passFieldTouched = true;
                        });
                        validatePass();
                      },
                      onChanged: (_) {
                        validatePass();
                      },
                      validator: (_) {
                        if (_passFieldTouched) {
                          if (_passController.text.isEmpty) {
                            return 'Palavra-passe é obrigatória';
                          }
                          if (_passController.text.length < 3) {
                            return 'Palavra-passe deve ter no mínimo 3 caracteres.';
                          }
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: SizedBox(
                        width: 329,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _nameFieldTouched = true;
                              _passFieldTouched = true;
                            });
                            validateName();
                            validatePass();
                            if (_formKey.currentState!.validate()) {
                              // Both fields are valid
                              appState.changeName(_nameController.text);
                              Navigator.pushReplacementNamed(context, '/main');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF522828),
                          ),
                          child: const Text(
                            'Entrar',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
