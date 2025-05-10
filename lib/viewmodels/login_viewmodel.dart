import 'dart:math';
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

class LoginViewModel extends ChangeNotifier {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode passwordFocusNode = FocusNode();

  List<String> shuffledNumbers = [];

  LoginViewModel() {
    _shuffleNumbers();

    passwordFocusNode.addListener(() {
      if (passwordFocusNode.hasFocus) {
        _shuffleNumbers();
      }
    });
  }

  void _shuffleNumbers() {
    List<String> numbers = List.generate(10, (i) => i.toString());
    numbers.shuffle(Random());
    shuffledNumbers = numbers;
    notifyListeners();
  }

  void onNumberPressed(String number) {
    passwordController.text += number;
    notifyListeners();
  }

  void onDeletePressed() {
    if (passwordController.text.isNotEmpty) {
      passwordController.text = passwordController.text.substring(
        0,
        passwordController.text.length - 1,
      );
      notifyListeners();
    }
  }

  bool login(BuildContext context) {
    final user = User(
      username: userController.text.trim(),
      password: passwordController.text,
    );

    final isValid = AuthService.login(user);

    if (!isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuario o clave incorrectos')),
      );
    }

    return isValid;
  }

  void disposeResources() {
    userController.dispose();
    passwordController.dispose();
    passwordFocusNode.dispose();
  }
}
