import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vibe_app/components/constants.dart';
import 'package:vibe_app/screens/api_services/authentication.dart';
import 'package:vibe_app/screens/authentication/account_verification.dart';
import 'package:vibe_app/screens/authentication/login.dart';
import 'package:vibe_app/screens/models/user.dart';
import 'package:vibe_app/screens/providers/auth_provider.dart';
import 'package:vibe_app/widget/custom_button.dart';
import 'package:vibe_app/widget/custom_textfield.dart';
import 'package:vibe_app/widget/error_dialogue.dart';
import 'package:vibe_app/widget/error_processor.dart';
import 'package:vibe_app/widget/loading_dialogue.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool keepMeLoggedIn = false;
  bool passwordObsecure = true;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();

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
    if (phoneNumberController.text.isEmpty) {
      if (!mounted) return;
      ErrorDialogue.show(context, "Phone Number is required");
      return false;
    } else if (firstNameController.text.isEmpty) {
      if (!mounted) return;
      ErrorDialogue.show(context, "Enter your first name");
      return false;
    } else if (usernameController.text.isEmpty) {
      if (!mounted) return;
      ErrorDialogue.show(context, "username is required.");
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
                    "Sign up",
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
                      label: Text("Phone Number"),
                      border: InputBorder.none,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(
                          right: 13,
                          left: 5,
                        ),
                        child: Icon(
                          Icons.phone,
                          size: 20,
                          color: CustomColors().textColor,
                        ),
                      ),
                      prefixIconConstraints: const BoxConstraints(
                        minWidth: 0,
                        minHeight: 0,
                      ),
                    ),
                    controller: phoneNumberController,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    decoration: InputDecoration(
                      isDense: true,
                      // hintText: "username, phone or email",
                      hintStyle: TextStyle(
                        color: CustomColors().textColor,
                        fontWeight: FontWeight.w300,
                      ),
                      label: Text("First Name"),
                      border: InputBorder.none,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(
                          right: 13,
                          left: 5,
                        ),
                        child: Icon(
                          Icons.badge,
                          size: 20,
                          color: CustomColors().textColor,
                        ),
                      ),
                      prefixIconConstraints: const BoxConstraints(
                        minWidth: 0,
                        minHeight: 0,
                      ),
                    ),
                    controller: firstNameController,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    decoration: InputDecoration(
                      isDense: true,
                      // hintText: "username, phone or email",
                      hintStyle: TextStyle(
                        color: CustomColors().textColor,
                        fontWeight: FontWeight.w300,
                      ),
                      label: Text("Username"),
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
                      label: Text("Password"),
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
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    text: "Sign up",
                    onTap: () async {
                      if (!validateForm()) return;
                      toggleIsLoading();
                      final Map<String, dynamic> response =
                          await AuthenticationService.register(
                        phoneNumber: phoneNumberController.text,
                        password: passwordController.text,
                        firstName: firstNameController.text,
                        username: usernameController.text,
                      );
                      toggleIsLoading();

                      if (!(response.containsKey('id') &&
                              response.containsKey('phone_number')) |
                          response.containsKey('errors')) {
                        if (!mounted) return;
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   const SnackBar(
                        //     content: Text(
                        //       "SignUp failed with errors",
                        //       style: TextStyle(color: Colors.red),
                        //     ),
                        //   ),
                        // );
                        processErrors(response, context);
                        return;
                      } else {
                        if (!mounted) return;
                        Provider.of<AuthProvider>(context, listen: false).logIn(
                          token: response['access'],
                          isLoggedIn: false,
                          user: User.fromMap(
                            (response).cast<String, dynamic>(),
                          ),
                        );
                      }

                      if (!mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Please Activate your account.",
                            style: TextStyle(color: Colors.greenAccent),
                          ),
                        ),
                      );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AccountActivationOTP(
                            phoneNumber: phoneNumberController.text,
                          ),
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
                Text(
                  "Already have an account? ",
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
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                  child: Text(
                    "Login",
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
