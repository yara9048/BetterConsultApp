import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../Providers/Auth/SendOtpProvider.dart';
import '../../../../generated/l10n.dart';
import '../../Register/Compoenets/text.dart';
import 'emailVerification.dart';

class ForgetPass extends StatefulWidget {
  const ForgetPass({super.key});

  @override
  State<ForgetPass> createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {
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
        builder: (context, provider, _) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (provider.isSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: text(
                    label:S.of(context).sendOTPSnackBar,
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                ),
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => EmailVeri(email: _emailController.text),
                ),
              );
              provider.reset();
            } else if (provider.errorMessage != null && !provider.isLoading) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: text(
                    label:S.of(context).sendOTPFailed,
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                ),
              );
              provider.reset();
            }
          });
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.onSurface,
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(math.pi),child: Image.asset("assets/images/Untitled design (1).png")),
                  Padding(
                    padding: EdgeInsets.only(top: 80.0, left: isArabic() ? 0 :20, right: isArabic() ? 20:0),
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back_ios,color: Theme.of(context).colorScheme.onSurface,size: 25,
                        ),
                        SizedBox(width: 20,),
                        Text(
                          S.of(context).forgetPassword,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'NotoSerifGeorgian',
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 320.0, left: 20),
                        child: Text(
                          S.of(context).emailVerification1,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'NotoSerifGeorgian',
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      Text(
                        S.of(context).emailVerification2,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'NotoSerifGeorgian',
                          color: Theme.of(context).colorScheme.surface.withOpacity(0.4),
                        ),
                      ),
                      Text(
                        S.of(context).emailVerification3,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'NotoSerifGeorgian',
                          color: Theme.of(context).colorScheme.surface.withOpacity(0.4),
                        ),
                      ),
                      SizedBox(height: 15,),
                      Consumer<SendOTPProvider>(
                        builder: (context, provider, _) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (provider.isSuccess) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: text(
                                    label: S.of(context).sendOTPSnackBar,
                                    fontSize: 14,
                                    color: Theme.of(context).colorScheme.onSurface,
                                  ),
                                  backgroundColor: Theme.of(context).colorScheme.secondary,
                                ),
                              );
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EmailVeri(email: _emailController.text),
                                ),
                              );
                              provider.reset(); // reset after success
                            }

                            if (provider.errorMessage != null && !provider.isLoading) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: text(
                                    label: provider.errorMessage!,
                                    fontSize: 14,
                                    color: Theme.of(context).colorScheme.onSurface,
                                  ),
                                  backgroundColor: Theme.of(context).colorScheme.secondary,
                                ),
                              );
                              provider.reset(); // reset error after showing
                            }
                          });

                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: TextFormField(
                                  controller: _emailController,
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.surface.withOpacity(0.4),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Theme.of(context).colorScheme.surface.withOpacity(0.05),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Theme.of(context).colorScheme.primary,
                                        width: 2,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Theme.of(context).colorScheme.primary,
                                        width: 2,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Theme.of(context).colorScheme.primary,
                                        width: 2,
                                      ),
                                    ),
                                    hintText: S.of(context).emailHint,
                                    hintStyle: TextStyle(
                                      color: Theme.of(context).colorScheme.primary,
                                      fontSize: 18,
                                      fontFamily: 'NotoSerifGeorgian',
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height:15),
                              SizedBox(
                                width: 320,
                                child: provider.isLoading
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
                                            label:S.of(context).emailValidation1,
                                            fontSize: 14,
                                            color: Theme.of(context).colorScheme.onSurface,
                                          ),
                                          backgroundColor: Theme.of(context).colorScheme.secondary,
                                        ),
                                                                          );
                                      return;
                                    }
                                    provider.sendOTP(_emailController.text.trim());
                                  },
                                  child: Text(
                                    S.of(context).send,
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
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      )
    );
  }
  bool isArabic() {
    return Intl.getCurrentLocale() == 'ar';
  }

}
