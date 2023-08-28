import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vibe_app/base.dart';
import 'package:vibe_app/components/constants.dart';
import 'package:vibe_app/local_auth.dart';
import 'package:vibe_app/screens/api_services/authentication.dart';
import 'package:vibe_app/screens/authentication/signup.dart';
import 'package:vibe_app/screens/models/user.dart';
import 'package:vibe_app/screens/providers/auth_provider.dart';
import 'package:vibe_app/widget/custom_button.dart';
import 'package:vibe_app/widget/custom_textfield.dart';
import 'package:vibe_app/widget/error_dialogue.dart';
import 'package:vibe_app/widget/loading_dialogue.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool keepMeLoggedIn = false;
  bool passwordObsecure = true;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  toggleIsLoading() {
    setState(
      () {
        isLoading = !isLoading;
        isLoading
            ? showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => WillPopScope(
                  onWillPop: () async {
                    setState(() {
                      isLoading = !isLoading;
                    });
                    return true;
                  },
                  child: const LoadingDialog(),
                ),
              )
            : Navigator.of(context).pop();
      },
    );
  }

  validateForm() {
    if (usernameController.text.isEmpty) {
      if (!mounted) return;
      ErrorDialogue.show(
          context, "Username, Email or Phone number is required");
      return false;
    } else if (passwordController.text.isEmpty) {
      ErrorDialogue.show(context, "Password is required.");
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    // final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: CustomColors().bgColor,
      body: ListView(
        children: [
          // SizedBox(
          //   height: MediaQuery.of(context).size.height * 0.090,
          // ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 200,
                    // height: 150.6,
                    child: Image.asset("assets/images/vibe_logo.png"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Login",
                    style: TextStyle(
                      color: CustomColors().textColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  /* Studnet Numberr Text Field */
                  CustomTextField(
                    decoration: InputDecoration(
                      isDense: true,
                      // hintText: "username, phone or email",
                      hintStyle: TextStyle(
                        color: CustomColors().textColor,
                        fontWeight: FontWeight.w300,
                      ),
                      label: const Text("Username, Email or Phone"),
                      border: InputBorder.none,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(
                          right: 13,
                          left: 5,
                        ),
                        child: Icon(
                          Icons.person,
                          size: 20,
                          color: CustomColors().textColor,
                        ),
                      ),
                      prefixIconConstraints: const BoxConstraints(
                        minWidth: 0,
                        minHeight: 0,
                      ),
                    ),
                    controller: usernameController,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  /* Password Text Feild */
                  CustomTextField(
                    decoration: InputDecoration(
                      isDense: true,
                      label: const Text("Password"),
                      hintStyle: TextStyle(
                        color: CustomColors().textColor,
                        fontWeight: FontWeight.w300,
                      ),
                      border: InputBorder.none,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(
                          right: 10,
                          left: 5,
                        ),
                        child: Icon(
                          Icons.lock,
                          size: 20,
                          color: CustomColors().textColor,
                        ),
                      ),
                      prefixIconConstraints: const BoxConstraints(
                        minWidth: 0,
                        minHeight: 0,
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(
                          right: 10,
                          left: 5,
                        ),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              passwordObsecure = !passwordObsecure;
                            });
                          },
                          radius: 0,
                          child: Icon(
                            passwordObsecure
                                ? Icons.visibility
                                : Icons.visibility_off,
                            size: 20,
                            color: CustomColors().primaryColor,
                          ),
                        ),
                      ),
                      suffixIconConstraints: const BoxConstraints(
                        minWidth: 0,
                        minHeight: 0,
                      ),
                    ),
                    obscureText: passwordObsecure,
                    controller: passwordController,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: Checkbox(
                            value: keepMeLoggedIn,
                            onChanged: (value) {
                              setState(() {
                                keepMeLoggedIn = value!;
                              });
                              print("=== keepmelogin: $keepMeLoggedIn");
                            },
                            splashRadius: 0,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Keep me signed in.",
                          style: TextStyle(
                            color: CustomColors().textColor,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    text: "LOGIN",
                    onTap: () async {
                      if (!validateForm()) return;

                      toggleIsLoading();
                      final data = await AuthenticationService.login(
                        password: passwordController.text,
                        username: usernameController.text,
                      );
                      toggleIsLoading();
                      if (data.containsKey("detail")) {
                        if (!mounted) return;
                        ErrorDialogue.show(context, data['detail'].toString());

                        return;
                      }

                      if (!mounted) return;
                      Provider.of<AuthProvider>(context, listen: false).logIn(
                        token: data['access'],
                        isLoggedIn: true,
                        user: User.fromMap(
                          (data).cast<String, dynamic>(),
                        ),
                      );

                      LocalCache.setAuthData(data);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeBase(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Column(
              children: [
                GestureDetector(
                  child: Text(
                    "Forgot Password",
                    style: TextStyle(
                      color: CustomColors().secondaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Don't have an account?",
                  style: TextStyle(
                    color: CustomColors().textColor,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpPage(),
                      ),
                    );
                  },
                  child: Text(
                    "Sign up",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: CustomColors().primaryColor,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
