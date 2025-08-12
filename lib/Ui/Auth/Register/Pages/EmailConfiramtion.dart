import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../Providers/Auth/SendOtpProvider.dart';
import '../../ForgetPassword/Pages/emailVerification.dart';
import '../Compoenets/text.dart';
import 'SendCode.dart';

class Emailconfiramtion extends StatefulWidget {
  const Emailconfiramtion({super.key});

  @override
  State<Emailconfiramtion> createState() => _EmailconfiramtionState();
}

class _EmailconfiramtionState extends State<Emailconfiramtion> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SendOTPProvider>(
      create: (_) => SendOTPProvider(),
      child: Consumer<SendOTPProvider>(
        builder: (context, sendOtpProvider, _) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (sendOtpProvider.isSuccess) {
              sendOtpProvider.reset();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: text(
                    label: "OTP sent successfully! Check your email.",
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                ),
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => SendCode(email: _emailController.text),
                ),
              );
            } else if (sendOtpProvider.errorMessage != null) {
              // Clear error after showing
              final error = sendOtpProvider.errorMessage!;
              sendOtpProvider.reset();

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: text(
                    label: error,
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                ),
              );
            }
          });

          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.onSurface,
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  Image(image: AssetImage("assets/images/Untitled design (1).png")),
                  Positioned(
                    top: 70,
                    left: 30,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Text(
                            "Email Verification",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurface,
                              fontFamily: 'NotoSerifGeorgian',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 250.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 200.0),
                          child: text(
                            label: "Step 1 out of 3",
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.surface.withOpacity(0.4),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: Text(
                            "Email Verification",
                            style: TextStyle(
                              fontSize: 24,
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'NotoSerifGeorgian',
                            ),
                          ),
                        ),
                        Text(
                          "In order to implement the registration ",
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.surface.withOpacity(0.4),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'NotoSerifGeorgian',
                          ),
                        ),
                        Text(
                          "process, we need to verify your email",
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.surface.withOpacity(0.4),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'NotoSerifGeorgian',
                          ),
                        ),
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            controller: _emailController,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.surface.withOpacity(0.4),
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Theme.of(context).colorScheme.surface.withOpacity(0.05),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 2.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 2.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 2.0,
                                ),
                              ),
                              hintText: "Enter your email",
                              hintStyle: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 18,
                                fontFamily: 'NotoSerifGeorgian',
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 320,
                          child: sendOtpProvider.isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              if (_emailController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Please enter your email")),
                                );
                                return;
                              }
                              sendOtpProvider.sendOTP(_emailController.text);
                            },
                            child: const Text(
                              "Send Code",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'NotoSerifGeorgian',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
