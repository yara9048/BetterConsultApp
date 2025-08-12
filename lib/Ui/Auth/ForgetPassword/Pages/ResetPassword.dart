import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../Providers/Auth/NewPasswordProvider.dart';
import '../../Login/pages/login.dart';
import '../../Register/Compoenets/text.dart';

class ResetPassword extends StatefulWidget {
  final String email;
  const ResetPassword({super.key, required this.email});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {

  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NewPasswordProvider(),
      child: Consumer<NewPasswordProvider>(
        builder: (context, provider, _) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (provider.isVerified == true) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: text(
                    label: "Password reset successfully! Please login.",
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                ),
              );
              provider.reset();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => Login()),
              );
            } else if (provider.errorMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(provider.errorMessage ?? 'Password reset failed'),
                ),
              );
              provider.reset();
            }
          });
          final isLoading = provider.isLoading;
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.onSurface,
            body: SingleChildScrollView(
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
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Text(
                            "Reset Password",
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
                    padding: const EdgeInsets.only(top: 320.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Text(
                            "Enter new password",
                            style: TextStyle(
                              fontSize: 24,
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'NotoSerifGeorgian',
                            ),
                          ),
                          Text(
                            "Your new password should be different",
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.surface.withOpacity(0.4),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'NotoSerifGeorgian',
                            ),
                          ),
                          Text(
                            "from your previously used one",
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
                              controller: _passwordController,
                              obscureText: _obscurePassword,
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
                                hintText: "Enter your new password",
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Theme.of(context).colorScheme.secondary,
                                    width: 2.0,
                                  ),
                                ),
                                errorStyle: TextStyle(
                                  color: Theme.of(context).colorScheme.secondary,
                                ),
                                hintStyle: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 18,
                                  fontFamily: 'NotoSerifGeorgian',
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter new password';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextFormField(
                              controller: _confirmPasswordController,
                              obscureText: _obscureConfirmPassword,
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
                                hintText: "Confirm the password",
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Theme.of(context).colorScheme.secondary,
                                    width: 2.0,
                                  ),
                                ),
                                errorStyle: TextStyle(
                                  color: Theme.of(context).colorScheme.secondary,
                                ),
                                hintStyle: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 18,
                                  fontFamily: 'NotoSerifGeorgian',
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscureConfirmPassword = !_obscureConfirmPassword;
                                    });
                                  },
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please confirm your password';
                                }
                                if (value != _passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: 320,
                            child: isLoading
                                ? const Center(child: CircularProgressIndicator())
                                : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).colorScheme.primary,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed:() async {
                              final provider = context.read<NewPasswordProvider>();

                              if (!_formKey.currentState!.validate()) return;

                              await provider.ResetPassword(widget.email, _passwordController.text);},
                              child: const Text(
                                "Recover Password",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'NotoSerifGeorgian',
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 50),
                        ],
                      ),
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
