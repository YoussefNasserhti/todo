import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_4pm/modules/auth/manager/auth_provider.dart';

class SignUpScreen extends StatelessWidget {
  static const String routeName = "SignUpScreen";

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: Consumer<AuthProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Create Account",
                      style: theme.textTheme.headline4,
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: provider.nameController,
                      decoration: InputDecoration(labelText: "Name"),
                    ),
                    TextField(
                      controller: provider.phoneController,
                      decoration: InputDecoration(labelText: "Phone"),
                    ),
                    TextField(
                      controller: provider.emailController,
                      decoration: InputDecoration(labelText: "Email"),
                    ),
                    TextField(
                      controller: provider.passwordController,
                      obscureText: provider.isSecure,
                      decoration: InputDecoration(
                        labelText: "Password",
                        suffixIcon: IconButton(
                          icon: Icon(provider.isSecure
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            provider.changeSecure();
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        provider.signUp(context);
                      },
                      child: Text("Sign Up"),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
