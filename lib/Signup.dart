import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Login.dart';

class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User SignUp'),
        backgroundColor: Colors.blue,
      ),
      body: SignUpForm(),
    );
  }
}

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _PhnoController = TextEditingController();

  Future<void> _saveData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('name', _nameController.text);
    await pref.setString('password', _passwordController.text);
    await pref.setString('email', _emailController.text);
    await pref.setString('phonenum', _PhnoController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(40.0),
      child: Center(
        child: Container(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Please enter the name';
                    return null;
                  },
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Password'),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Password should not be empty';
                    return null;
                  },
                ),
                hi
                const SizedBox(height: 5),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Email is empty';
                    return null;
                  },
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: _PhnoController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(labelText: 'Phone number'),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Phone number cannot be empty';
                    return null;
                  },
                ),
                const SizedBox(height: 5),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await _saveData();
                      Navigator.pop(context);  // Navigate back to login page
                    }
                  },
                  child: Text('Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
