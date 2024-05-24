import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Auth(),
    );
  }
}

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  late LoginBloc _loginBlocs;

  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loginBlocs = LoginBloc();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _loginBlocs.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: BlocProvider(
        create: (_) => _loginBlocs,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocBuilder<LoginBloc, LoginState>(
                      buildWhen: (current, previous) =>
                          current.email != previous.email,
                      builder: (context, state) {
                        return TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          focusNode: emailFocusNode,
                          decoration: const InputDecoration(
                              hintText: 'Email', border: OutlineInputBorder()),
                          onChanged: (value) {
                            context
                                .read<LoginBloc>()
                                .add(EmailChanged(email: value));
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter email';
                            }
                            return null;
                          },
                          onFieldSubmitted: (value) {},
                        );
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<LoginBloc, LoginState>(
                      buildWhen: (current, previous) =>
                          current.password != previous.password,
                      builder: (context, state) {
                        return TextFormField(
                          keyboardType: TextInputType.text,
                          focusNode: passwordFocusNode,
                          decoration: const InputDecoration(
                              hintText: 'Password',
                              border: OutlineInputBorder()),
                          onChanged: (value) {
                            context
                                .read<LoginBloc>()
                                .add(PasswordChanged(password: value));
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter password';
                            }
                            return null;
                          },
                          onFieldSubmitted: (value) {},
                        );
                      }),
                  const SizedBox(
                    height: 50,
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}