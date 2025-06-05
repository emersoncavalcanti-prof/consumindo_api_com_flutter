import 'package:consumindo_api_com_flutter/data/http/http_client.dart';
import 'package:consumindo_api_com_flutter/data/repositories/user_repository.dart';
import 'package:consumindo_api_com_flutter/pages/login/store/user_store.dart';
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
        child: Form(key: _formkey, child: ListView(children: [
            
          ],
        )),
      ),
    );
  }
}
