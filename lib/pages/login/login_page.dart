import 'package:consumindo_api_com_flutter/data/http/http_client.dart';
import 'package:consumindo_api_com_flutter/data/repositories/user_repository.dart';
import 'package:consumindo_api_com_flutter/pages/login/store/user_store.dart';
import 'package:consumindo_api_com_flutter/widget/custom_edit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  bool clicou = false;

  @override
  Widget build(BuildContext context) {
    final dioClient = Provider.of<DioClient>(context);

    UserStore store = UserStore(repository: UserRepository(client: dioClient));

    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Login', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 30, left: 20, right: 20),
        child: Form(
          key: _formkey,
          child: ListView(
            children: [
              CustomEdit(
                label: 'Digite seu email',
                icone: Icon(Icons.email),
                isObscure: false,
                controller: controllerEmail,
                validator: (email) {
                  if (email == null || email.isEmpty) {
                    return 'Digite seu email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              CustomEdit(
                label: 'Digite sua senha',
                icone: Icon(Icons.lock),
                isObscure: true,
                controller: controllerPassword,
                validator: (password) {
                  if (password == null || password.isEmpty) {
                    return 'Digite sua senha';
                  }
                  if (password.length < 4) {
                    return 'Sua senha deve ter pelo menos 4 caracteres';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              InkWell(
                onTap: () async {
                  if (_formkey.currentState!.validate()) {
                    setState(() {
                      clicou = !clicou;
                    });
                  }

                  await store.login(
                    email: controllerEmail.text,
                    password: controllerPassword.text,
                  );

                  setState(() {
                    clicou = !clicou;
                  });

                  if (store.error.value.isNotEmpty) {
                    if (!mounted) return;

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Login ou senha inválidos',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  } else {
                    if (!mounted) return;
                    Navigator.pushReplacementNamed(context, '/home');
                  }
                },
                child: Center(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 400),
                    width: clicou == true ? 40 : width,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Center(
                      child:
                          clicou == true
                              ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                              : Text(
                                'Logar',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
