import 'package:flutter/material.dart';
import 'api.dart';

class LoginPage extends StatefulWidget {
  final ApiClient api;
  const LoginPage({super.key, required this.api});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailCtrl = TextEditingController(text: 'admin@in8.com.br');
  final _passwordCtrl = TextEditingController(text: 'admin123');
  bool _loading = false;
  String? _error;

  Future<void> _doLogin() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      await widget.api.login(_emailCtrl.text.trim(), _passwordCtrl.text);
      if (mounted) Navigator.of(context).pushReplacementNamed('/products');
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _emailCtrl,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _passwordCtrl,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Senha'),
            ),
            const SizedBox(height: 16),
            if (_error != null)
              Text(_error!, style: const TextStyle(color: Colors.red)),
            ElevatedButton(
              onPressed: _loading ? null : _doLogin,
              child: _loading ? const CircularProgressIndicator() : const Text('Entrar'),
            ),
          ],
        ),
      ),
    );
  }
}
