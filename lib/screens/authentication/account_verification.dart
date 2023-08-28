import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:vibe_app/base.dart';
import 'package:vibe_app/components/constants.dart';
import 'package:vibe_app/screens/api_services/authentication.dart';
import 'package:vibe_app/widget/custom_button.dart';
import 'package:vibe_app/widget/error_dialogue.dart';
import 'package:vibe_app/widget/loading_dialogue.dart';

class AccountActivationOTP extends StatefulWidget {
  final String phoneNumber;
  const AccountActivationOTP({super.key, required this.phoneNumber});

  @override
  State<AccountActivationOTP> createState() => _AccountActivationOTPState();
}

bool activate = false;

class _AccountActivationOTPState extends State<AccountActivationOTP> {
  late double height, width;

  bool isLoading = false;
  toggleIsLoading() {
    setState(
      () {
        isLoading = !isLoading;
        isLoading
            ? showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => const LoadingDialog(),
              )
            : Navigator.of(context).pop();
      },
    );
  }

  String otpCode = "";
  bool canResendOtop = false;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    final focusedBorderColor = CustomColors().primaryColor;
    final borderColor = CustomColors().secondaryColor;
    // final fillColor = white;

    final defaultPinTheme = PinTheme(
      width: 48,
      height: 48,
      textStyle: const TextStyle(
        //fontFamily: '',
        fontSize: 24,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor, width: 1),
      ),
    );

    return Scaffold(
      backgroundColor: CustomColors().bgColor,
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              "OTP Verification",
              style: TextStyle(
                color: CustomColors().textColor,
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                "Enter the 4 digit code sent to your phone number ${widget.phoneNumber}",
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0, bottom: 30),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Pinput(
                  length: 4,
                  defaultPinTheme: defaultPinTheme,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  focusedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      border: Border.all(
                        color: focusedBorderColor,
                      ),
                    ),
                  ),
                  androidSmsAutofillMethod:
                      AndroidSmsAutofillMethod.smsRetrieverApi,
                  autofocus: true,
                  closeKeyboardWhenCompleted: false,
                  onCompleted: (otpCode) async {
                    toggleIsLoading();
                    final data = await AuthenticationService().activateAccount(
                      phoneNumber: widget.phoneNumber,
                      otp: otpCode,
                    );

                    toggleIsLoading();

                    if (data == 200) {
                      if (!mounted) return;
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeBase(),
                        ),
                      );

                      return;
                    }
                    return;
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              text: "Verify",
              onTap: () async {
                toggleIsLoading();
                final data = await AuthenticationService().activateAccount(
                  phoneNumber: widget.phoneNumber,
                  otp: otpCode,
                );

                toggleIsLoading();

                if (data == 200) {
                  if (!mounted) return;
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeBase(),
                    ),
                  );

                  return;
                }
                return;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: SizedBox(
                height: height * 0.1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "I didn't receive a code",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: CustomColors().primaryColor,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    canResendOtop
                        ? TextButton(
                            onPressed: () async {
                              toggleIsLoading();
                              final data =
                                  await AuthenticationService().resendOtp(
                                phoneNumber: widget.phoneNumber,
                              );
                              toggleIsLoading();
                              if (data.containsKey('detail')) {
                                if (!mounted) return;
                                setState(() {
                                  canResendOtop = false;
                                });

                                ErrorDialogue.show(
                                  context,
                                  data['detail'] as String,
                                );

                                return;
                              }
                              return;
                            },
                            child: const Text("Resend Otp"),
                          )
                        : Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Resend in: ",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: CustomColors().primaryColor,
                                ),
                              ),
                              TweenAnimationBuilder<Duration>(
                                duration:
                                    const Duration(minutes: 1, seconds: 30),
                                tween: Tween(
                                  begin: const Duration(
                                    minutes: 1,
                                    seconds: 30,
                                  ),
                                  end: Duration.zero,
                                ),
                                onEnd: () {
                                  setState(() {
                                    canResendOtop = true;
                                  });
                                },
                                builder: (
                                  BuildContext context,
                                  Duration value,
                                  Widget? child,
                                ) {
                                  final minutes = value.inMinutes;
                                  final seconds = value.inSeconds % 60;
                                  return Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Text(
                                      '$minutes:$seconds',
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
