import 'package:consumindo_api_com_flutter/http/data/http_client.dart';
import 'package:consumindo_api_com_flutter/pages/login/login_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final dio = Dio();

    return MultiProvider(
      providers: [
        Provider<Dio>.value(value: dio),
        ProxyProvider<Dio, DioClient>(
          update: (context, dio, dioClient) {
            return DioClient(dio);
          },
        ),
      ],
      child: MaterialApp(
        title: 'Consumindo API',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {'/': (context) => LoginPage()},
      ),
    );
  }
}
