import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Signup.dart';
import 'movielist.dart';
//hi
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isUserRegistered = false;
  bool _invalidCredentials = false;

  @override
  void initState() {
    super.initState();
    _checkUserRegistered();
  }

  Future<void> _checkUserRegistered() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? storedName = pref.getString('name');
    String? storedPassword = pref.getString('password');

    setState(() {
      _isUserRegistered = storedName != null && storedPassword != null;
    });
  }

  Future<void> _login() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? storedName = pref.getString('name');
    String? storedPassword = pref.getString('password');

    if (_nameController.text == storedName && _passwordController.text == storedPassword) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MovieListScreen()),
      );
    } else {
      setState(() {
        _invalidCredentials = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Please enter your name';
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Password'),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Please enter your password';
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _login();
                    }
                  },
                  child: Text('Login'),
                ),
                if (_invalidCredentials)
                  Column(
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        'Invalid credentials. Please try again.',
                        style: TextStyle(color: Colors.red),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignupPage()),
                          ).then((value) {
                            _checkUserRegistered();
                            setState(() {
                              _invalidCredentials = false;
                            });
                          });
                        },
                        child: Text(
                          'If User not registered? Please Sign up here.',
                          style: TextStyle(
                            color: _isUserRegistered ? Colors.blue : Colors.black,
                            decoration: _isUserRegistered ? TextDecoration.underline : TextDecoration.none,
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
