import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../Providers/Auth/VerifyEmailProvider.dart';
import '../../Register/Compoenets/OtpField.dart';
import '../../Register/Compoenets/text.dart';
import 'ResetPassword.dart';

class EmailVeri extends StatefulWidget {
  final String email;

  const EmailVeri({Key? key, required this.email}) : super(key: key);

  @override
  State<EmailVeri> createState() => _EmailVeriState();
}

class _EmailVeriState extends State<EmailVeri> {
  final _otpControllers = List.generate(6, (_) => TextEditingController());
  final _focusNodes = List.generate(6, (_) => FocusNode());
  String get _otpCode => _otpControllers.map((c) => c.text).join();

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSurface,
      body: ChangeNotifierProvider(
        create: (_) => VerifyEmailProvider(),
        child: Consumer<VerifyEmailProvider>(
          builder: (context, provider, _) {
            if (provider.errorMessage != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: text(
                        label: "Wrong OTP",
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                    ),
                );
                provider.reset();
              });
            }

            if (provider.isVerified) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: text(
                      label: 'Email Verified Successfully',
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                  ),
                );

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ResetPassword(email: widget.email),
                  ),
                );
                provider.reset();
              });
            }

            return SingleChildScrollView(
              child: Stack(
                children: [
                  Image.asset("assets/images/Untitled design (1).png"),
                  Positioned(
                    top: 70,
                    left: 30,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () => Navigator.of(context).pop(),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Theme.of(context).colorScheme.onSurface,
                            size: 25,
                          ),
                        ),
                        const SizedBox(width: 18),
                        Text(
                          "Email Verification",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface,
                            fontFamily: 'NotoSerifGeorgian',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 350.0),
                    child: Column(
                      children: [
                        Text(
                          "Get your Code",
                          style: TextStyle(
                            fontSize: 24,
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'NotoSerifGeorgian',
                          ),
                        ),
                        Text(
                          "Please enter your 6 digit code that",
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context)
                                .colorScheme
                                .surface
                                .withOpacity(0.4),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'NotoSerifGeorgian',
                          ),
                        ),
                        Text(
                          "was sent to your email address",
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context)
                                .colorScheme
                                .surface
                                .withOpacity(0.4),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'NotoSerifGeorgian',
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(6, (index) => OtpField(
                            controller: _otpControllers[index],
                            focusNode: _focusNodes[index],
                            nextFocusNode: index < 5 ? _focusNodes[index + 1] : null,
                            prevFocusNode: index > 0 ? _focusNodes[index - 1] : null,
                            primaryColor: Theme.of(context).colorScheme.primary,
                            fillColor: Theme.of(context).colorScheme.surface.withOpacity(0.05),
                          )),
                        ),

                        const SizedBox(height: 30),
                        SizedBox(
                          width: 320,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: provider.isLoading
                                ? null
                                : () {
            if (_otpCode.length < 6) {
            ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(
              content: text(
                label: "Please enter all 6 digits of the OTP",
                fontSize: 14,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              backgroundColor: Theme.of(context).colorScheme.secondary,
            ));
            return; }
                              print(_otpCode);
                              provider.verifyEmail(widget.email, _otpCode);
                            },
                            child: provider.isLoading
                                ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                                : const Text(
                              "Verify and Proceed",
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
            );
          },
        ),
      ),
    );
  }
}
