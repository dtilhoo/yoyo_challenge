import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/route_constants.dart';
import '../../core/validators/validator_mixin.dart';
import '../widgets/form_label.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

final _formkey = GlobalKey<FormState>();
TextEditingController? _userNameController;
TextEditingController? _passwordController;
bool _passwordVisible = false;

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 200.0,
                width: 200.0,
                child: SvgPicture.asset(
                  'assets/login.svg',
                ),
              ),
              const Text(
                'LOGIN',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Seperator(),
              const Align(
                alignment: Alignment.centerLeft,
                child: FormLabel(
                  label: 'Username',
                  isRequired: true,
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.name,
                controller: _userNameController,
                validator: (value) => ValidatorMixin().textValidation(
                  value,
                  'Username required',
                ),
                decoration: const InputDecoration(
                  counterText: "",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2,
                    ),
                  ),
                ),
              ),
              const Seperator(),
              const Align(
                alignment: Alignment.centerLeft,
                child: FormLabel(
                  label: 'Password',
                  isRequired: true,
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.name,
                controller: _passwordController,
                obscureText: !_passwordVisible,
                validator: (value) => ValidatorMixin().textValidation(
                  value,
                  'Password required',
                ),
                decoration: InputDecoration(
                  counterText: "",
                  suffixIcon: IconButton(
                    icon: Icon(_passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2,
                    ),
                  ),
                ),
              ),
              const Seperator(),
              TextButton(
                onPressed: () async {
                  if (_formkey.currentState!.validate()) {
                    _formkey.currentState!.save();
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setBool("isLoggedIn", true);
                    Navigator.pushReplacementNamed(context, homeScreenRoute);
                  }
                },
                child: const Text(
                  'Submit',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Seperator extends StatelessWidget {
  const Seperator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 15,
    );
  }
}
