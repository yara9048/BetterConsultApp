import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../Providers/Auth/RegisterProvider.dart';
import '../../../Home/Pages/NavBar.dart';
import '../Compoenets/text.dart';

class Register extends StatefulWidget {
  final String email;
  const Register({super.key, required this.email});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isConsultant = false;

  final List<bool> _selectedGender = [true, false];
  final List<String> _genderOptions = ['Male', 'Female'];
  final _scrollController = ScrollController();

  String getSelectedGender() {
    for (int i = 0; i < _selectedGender.length; i++) {
      if (_selectedGender[i]) {
        return _genderOptions[i].toLowerCase();
      }
    }
    return '';
  }

  InputDecoration _buildInputDecoration(
      {required String hintText, required ColorScheme colorScheme}) {
    return InputDecoration(
      filled: true,
      fillColor: colorScheme.surface.withOpacity(0.05),
      hintText: hintText,
      hintStyle: TextStyle(
        color: colorScheme.primary,
        fontSize: 15,
        fontFamily: 'NotoSerifGeorgian',
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: colorScheme.primary,
          width: 2.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: colorScheme.primary,
          width: 2.0,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: colorScheme.secondary,
          width: 2.0,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: colorScheme.secondary,
          width: 2.0,
        ),
      ),
      errorStyle: TextStyle(
        color: colorScheme.secondary,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ChangeNotifierProvider(
      create: (_) => RegisterProvider(),
      child: Consumer<RegisterProvider>(
        builder: (context, provider, _) {
          // react to success state to navigate
          if (provider.isSuccess) {
            // Reset provider state before navigating
            WidgetsBinding.instance.addPostFrameCallback((_) {
              provider.reset();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => Navbar()),
              );
            });
          }

          return Scaffold(
            backgroundColor: const Color(0xfff5f7fa),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  controller: _scrollController,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Icon(Icons.arrow_back_ios,
                                    color: colorScheme.primary, size: 28),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 180.0),
                                child: text(
                                  label: "Step 3 out of 3",
                                  fontSize: 14,
                                  color: colorScheme.surface.withOpacity(0.4),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          text(
                            label: "Welcome!",
                            fontSize: 28,
                            color: colorScheme.surface.withOpacity(0.6),
                          ),
                          const SizedBox(height: 5),
                          text(
                            label: "Your email has verified successfully",
                            fontSize: 16,
                            color: colorScheme.surface.withOpacity(0.4),
                          ),
                          text(
                            label: "Please enter your personal information",
                            fontSize: 16,
                            color: colorScheme.surface.withOpacity(0.4),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),

                    // First Name & Last Name
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              text(
                                label: "First name",
                                fontSize: 16,
                                color: colorScheme.surface.withOpacity(0.4),
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: _firstNameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your first name';
                                  }
                                  return null;
                                },
                                style: TextStyle(
                                  color: colorScheme.surface.withOpacity(0.4),
                                ),
                                decoration: _buildInputDecoration(
                                    hintText: "First name",
                                    colorScheme: colorScheme),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              text(
                                label: "Last name",
                                fontSize: 16,
                                color: colorScheme.surface.withOpacity(0.4),
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: _lastNameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your last name';
                                  }
                                  return null;
                                },
                                style: TextStyle(
                                  color: colorScheme.surface.withOpacity(0.4),
                                ),
                                decoration: _buildInputDecoration(
                                    hintText: "Last name",
                                    colorScheme: colorScheme),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Phone Number
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        text(
                          label: "Phone Number",
                          fontSize: 16,
                          color: colorScheme.surface.withOpacity(0.4),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            if (value.length != 10 ||
                                !RegExp(r'^\d{10}$').hasMatch(value)) {
                              return 'Phone number must be exactly 10 digits';
                            }
                            return null;
                          },
                          style: TextStyle(
                            color: colorScheme.surface.withOpacity(0.4),
                          ),
                          decoration: _buildInputDecoration(
                              hintText: "Enter your phone number",
                              colorScheme: colorScheme),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Gender selection
                    text(
                      label: "Gender",
                      fontSize: 16,
                      color: colorScheme.surface.withOpacity(0.4),
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: ToggleButtons(
                        isSelected: _selectedGender,
                        onPressed: (int index) {
                          setState(() {
                            for (int i = 0; i < _selectedGender.length; i++) {
                              _selectedGender[i] = i == index;
                            }
                          });
                        },
                        borderRadius: BorderRadius.circular(10),

                        borderColor: colorScheme.primary,

                        selectedBorderColor: colorScheme.primary,
                        borderWidth: 2,
                        selectedColor: Colors.white,
                        fillColor: colorScheme.primary,
                        color: colorScheme.primary,
                        constraints: const BoxConstraints(
                          minWidth: 120,
                          minHeight: 50,
                        ),
                        children: _genderOptions
                            .map((gender) => Text(
                          gender,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'NotoSerifGeorgian',
                          ),
                        ))
                            .toList(),
                      )
                      ,
                    ),

                    const SizedBox(height: 20),

                    // Password
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        text(
                          label: "Password",
                          fontSize: 16,
                          color: colorScheme.surface.withOpacity(0.4),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                          style: TextStyle(
                            color: colorScheme.surface.withOpacity(0.4),
                          ),
                          decoration: _buildInputDecoration(
                              hintText: "Enter your password",
                              colorScheme: colorScheme)
                              .copyWith(
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: colorScheme.primary,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Confirm Password
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        text(
                          label: "Confirm Password",
                          fontSize: 16,
                          color: colorScheme.surface.withOpacity(0.4),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: _obscureConfirmPassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            }
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                          style: TextStyle(
                            color: colorScheme.surface.withOpacity(0.4),
                          ),
                          decoration: _buildInputDecoration(
                              hintText: "Confirm your password",
                              colorScheme: colorScheme)
                              .copyWith(
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureConfirmPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: colorScheme.primary,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureConfirmPassword = !_obscureConfirmPassword;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // Consultant checkbox with label
                    Row(
                      children: [
                        Transform.scale(
                          scale: 1.5,
                          child: Checkbox(
                            value: _isConsultant,
                            onChanged: (val) {
                              setState(() {
                                _isConsultant = val ?? false;
                              });
                            },
                            activeColor: colorScheme.primary,
                            checkColor: colorScheme.onSurface, // checkmark color here
                          ),
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: text(
                            label:
                            "Are you a consultant? (Selecting this requires verification)",
                            fontSize: 14,
                            color: colorScheme.surface.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 55),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: colorScheme.primary,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          provider.register(
                            email: widget.email,
                            firstName: _firstNameController.text.trim(),
                            lastName: _lastNameController.text.trim(),
                            phoneNumber: _phoneController.text.trim(),
                            gender: getSelectedGender(),
                            password: _passwordController.text.trim(),
                            role: _isConsultant ? 'consultant' : 'user',
                          );
                        } else {
                          _scrollController.animateTo(0,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut);
                        }
                      },
                      child: provider.isLoading
                          ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                          : text(
                        label: "Register",
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 40),
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
