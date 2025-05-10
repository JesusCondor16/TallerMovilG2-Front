import 'package:flutter/material.dart';
import 'register_page.dart';
import 'dart:math';

void main() {
  runApp(const CooperApp());
}

class CooperApp extends StatelessWidget {
  const CooperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CooperApp',
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _passwordFocusNode = FocusNode();
  List<String> _shuffledNumbers = [];

  @override
  void initState() {
    super.initState();
    _shuffleNumbers();

    _passwordFocusNode.addListener(() {
      if (_passwordFocusNode.hasFocus) {
        _shuffleNumbers();
      }
    });
  }

  void _shuffleNumbers() {
    List<String> numbers = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    numbers.shuffle(Random());
    setState(() {
      _shuffledNumbers = numbers;
    });
  }

  void _onNumberPressed(String number) {
    setState(() {
      _passwordController.text += number;
    });
  }

  void _onDeletePressed() {
    setState(() {
      if (_passwordController.text.isNotEmpty) {
        _passwordController.text = _passwordController.text.substring(
          0,
          _passwordController.text.length - 1,
        );
      }
    });
  }

  void _login() {
    final user = _userController.text.trim();
    final pass = _passwordController.text;

    if (user == 'admin' && pass == '1234') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => HomePage(username: user)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuario o clave incorrectos')),
      );
    }
  }

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFCF5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Logo
              Image.asset(
                'assets/ardillas.jpg',
                height: 250,
              ),
              const SizedBox(height: 10),
              const Text(
                'Ahorra fácil, ahorra juntos',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.brown,
                ),
              ),
              const SizedBox(height: 30),
              // Campos de texto
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    TextField(
                      controller: _userController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Usuario',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _passwordController,
                      focusNode: _passwordFocusNode,
                      obscureText: true,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Clave',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: SizedBox(
                  width: 250,
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: [
                      ..._shuffledNumbers.map((number) => ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade100,
                        ),
                        onPressed: () => _onNumberPressed(number),
                        child: Text(
                          number,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      )),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade100,
                        ),
                        onPressed: _onDeletePressed,
                        child: const Icon(
                          Icons.backspace,
                          color: Colors.black,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Ingresar',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RegisterPage()),
                  );
                },
                child: const Text(
                  '¿Aún no tienes cuenta? Únete',
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final String username;

  const HomePage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido, $username'),
        backgroundColor: Colors.green,
      ),
      body: const Center(
        child: Text(
          'Has ingresado correctamente 🎉',
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}