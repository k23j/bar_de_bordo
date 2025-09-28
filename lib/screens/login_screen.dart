import 'package:bar_de_bordo/core/app_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bar_de_bordo/warnings.dart';
import 'package:bar_de_bordo/ui_utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLogin = true;
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  void switchToSignUp() {
    setState(() {
      isLogin = false;
    });
  }

  void returnToLogin() {
    setState(() {
      isLogin = true;
    });
  }

  //TODO: Incorrect password confirm not showing validate msg
  bool isFormValid() {
    if (isLogin) {
      return _formKey.currentState!.validate();
    } else {
      return _formKey.currentState!.validate() &&
          _passwordController.text == _passwordConfirmController.text;
    }
  }

  void showErrorMsg(String errorCode) {
    if (!context.mounted) return;

    late final String errorMsg;

    //Set error msg based on input code
    switch (errorCode) {
      case 'invalid-credential':
      case 'wrong-password':
      case 'user-not-found':
        errorMsg = "Email ou senha inválidos. Por favor, tente novamente.";
        break;

      case 'network-request-failed':
        errorMsg =
            'Sem conexão com servidor, Por favor, verifique sua conexão e tente novamente.';
        break;

      case 'email-already-in-use':
        errorMsg = "Este email já está em uso. Por favor utilize outro email.";
        break;
      case 'invalid-email':
        errorMsg = isLogin
            ? "Email ou senha inválidos. Por favor, tente novamente."
            : "Por favor, insira um email válido.";
        break;

      default:
        errorMsg =
            'Erro desconhecido. Por favor, reinicie o aplicativo e tente novamente.';
    }

    showSnackWarning(context, errorMsg);
  }

  void signIn() async {
    dismissKeyboard();

    if (!isFormValid()) return;

    setState(() {
      isLoading = true;
    });

    //Logging in
    if (isLogin) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
      } on FirebaseAuthException catch (e) {
        showErrorMsg(e.code);
      }
    }
    //Creating new account
    else {
      try {
        final UserCredential credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: _emailController.text,
              password: _passwordController.text,
            );

        await credential.user?.updateDisplayName(_nameController.text);

        await FirebaseFirestore.instance
            .collection('usr')
            .doc(credential.user!.uid)
            .set({
              'name': _nameController.text,
              'creation_date': DateTime.now(),
              'last_login': DateTime.now(),
              // 'roles': ['user'],
              'expiration_date': DateTime.now(),
            });

        AppState.instance.updateAppUser(credential.user);
      } on FirebaseAuthException catch (e) {
        showErrorMsg(e.code);
      }
    }

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  String? emailValidator(String? value) {
    const pattern =
        r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isEmpty || !regex.hasMatch(value) ? 'Email inválido' : null;
  }

  String? passwordValidator(String? value) {
    const pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';

    // r'[A-Z]'    //One uppercase letter
    // //r'[!@#\\$%^&*(),.?":{}|<>]' //One special character
    // r'\\d'                      //One number
    // r'^.{8,32}$';               //8-32 characters

    final regex = RegExp(pattern);

    return value!.isEmpty || !regex.hasMatch(value)
        //TODO: Change message accordingly
        ? 'Senha inválida'
        : null;
  }

  String? nameValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Nome não pode estar vazio';
    }

    final regex = RegExp(r'^[a-zA-Z ]{3,}$');
    return !regex.hasMatch(value)
        ? 'Nome inválido. Use apenas letras e espaços'
        : null;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final textFieldDecoration = InputDecoration(label: Text('Email',style: const TextStyle().copyWith(color: Colors.white.withOpacity(.8), fontSize: 14)));
    InputDecoration defaultDecoration(String label) {
      return InputDecoration(
        label: Text(
          label,
          style: const TextStyle().copyWith(
            // color: Colors.white.withOpacity(.8),
            fontSize: 14,
          ),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          if (!isLogin)
            Positioned(
              left: 16,
              top: 48,
              child: IconButton(
                onPressed: returnToLogin,
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isLogin ? 'Login' : 'Nova Conta',
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          if (!isLogin)
                            TextFormField(
                              decoration: defaultDecoration('Nome'),
                              controller: _nameController,
                              validator: nameValidator,
                              onFieldSubmitted: (value) => signIn(),
                            ),
                          TextFormField(
                            decoration: defaultDecoration('Email'),
                            controller: _emailController,
                            validator: emailValidator,
                            keyboardType: TextInputType.emailAddress,
                            onFieldSubmitted: (value) => signIn(),
                          ),
                          TextFormField(
                            decoration: defaultDecoration('Senha'),
                            controller: _passwordController,
                            obscureText: true,
                            validator: passwordValidator,
                            onFieldSubmitted: (value) => signIn(),
                          ),
                          if (!isLogin)
                            TextFormField(
                              decoration: defaultDecoration('Confirmar Senha'),
                              controller: _passwordConfirmController,
                              obscureText: true,
                              validator: passwordValidator,
                              onFieldSubmitted: (value) => signIn(),
                            ),
                          //const SizedBox(height: 32,),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  //Sing-in/Sign-up Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: signIn,
                      child: isLoading
                          ? const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              isLogin ? 'Entrar' : 'Criar nova conta',
                              style: const TextStyle().copyWith(fontSize: 16),
                            ),
                    ),
                  ),
                  const SizedBox(height: 100),
                  if (isLogin)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Não tem uma conta?'),
                        TextButton(
                          onPressed: switchToSignUp,
                          child: Text(
                            'Cadastre-se',
                            style: const TextStyle().copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
