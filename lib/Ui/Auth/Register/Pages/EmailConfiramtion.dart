import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../Providers/Auth/SendOtpProvider.dart';
import '../../../../generated/l10n.dart';
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
                    label: S.of(context).OTPSuccess,
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
              final error = S.of(context).OTPFailed;
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
                  Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(math.pi),child: Image.asset("assets/images/Untitled design (1).png")),                  Positioned(
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
                            S.of(context).emailVerification,
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
                    padding: EdgeInsets.only(top: 250.0),
                    child: Column(
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(left: isArabic()? 0: 200.0,right:  isArabic()?200:0),
                          child: text(
                            label: S.of(context).step1,
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.surface.withOpacity(0.4),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: Text(
                            S.of(context).emailVerification,
                            style: TextStyle(
                              fontSize: 24,
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'NotoSerifGeorgian',
                            ),
                          ),
                        ),
                        Text(
                          S.of(context).confirmEmailReg1,
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.surface.withOpacity(0.4),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'NotoSerifGeorgian',
                          ),
                        ),
                        Text(
                          S.of(context).confirmEmailReg2,
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
                              hintText: S.of(context).emailHint,
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
                                  SnackBar(
                                    content: text(
                                      label:S.of(context).emailHint,
                                      fontSize: 14,
                                      color: Theme.of(context).colorScheme.onSurface,
                                    ),
                                    backgroundColor: Theme.of(context).colorScheme.secondary,
                                  ),
                                );
                                return;
                              }
                              sendOtpProvider.sendOTP(_emailController.text);
                            },
                            child: Text(
                              S.of(context).sendCode,
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
  bool isArabic () {
    return Intl.getCurrentLocale() == 'ar';
  }
}
