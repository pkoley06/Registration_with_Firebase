import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/screens/register_screen.dart';
import 'package:firebase_project/services/auth_service.dart';
import 'package:flutter/material.dart';

class LogInScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login '),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      onPressed: () async {
                        if (emailController.text == "" ||
                            passwordController.text == "") {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("All Fields are required !"),
                            backgroundColor: Colors.red,
                          ));
                        } else {
                          User? result = await AuthService().logInUser(
                              emailController.text,
                              passwordController.text,
                              context);
                          if (result != null) {
                            print("success");
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Login successfully !"),
                              backgroundColor: Colors.green,
                            ));
                          }
                        }
                      },
                      child: const Text("LOGIN")),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => RegisterScreen())));
                    },
                    child: const Text("Don't have an Account? Register here!"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
