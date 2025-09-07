import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../DIO/EndPoints.dart';
import '../../../../Providers/Auth/RegisterProvider.dart';
import '../../../../Providers/Home/User/Others/NotificationProvider.dart';
import '../../../../generated/l10n.dart';
import '../../../ConsaltantUi/NavBar/Pages/consultNavBar.dart';
import '../../../Home/Pages/NavBar.dart';
import '../Compoenets/text.dart';
import 'IsConsaltant.dart';

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
  final _scrollController = ScrollController();

  InputDecoration _buildInputDecoration({
    required String hintText,
    required ColorScheme colorScheme,
  }) {
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
        borderSide: BorderSide(color: colorScheme.primary, width: 2.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: colorScheme.primary, width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: colorScheme.secondary, width: 2.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: colorScheme.secondary, width: 2.0),
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
    final List<String> _genderOptions = [
      S.of(context).male,
      S.of(context).female,
    ];
    String getSelectedGender() {
      for (int i = 0; i < _selectedGender.length; i++) {
        if (_selectedGender[i]) {
          if (_genderOptions[i] == S.of(context).male) {
            return 'male';
          } else if (_genderOptions[i] == S.of(context).female) {
            return 'female';
          }
        }
      }
      return '';
    }

    return ChangeNotifierProvider(
      create: (_) => RegisterProvider(),
      child: Consumer<RegisterProvider>(
        builder: (context, provider, _) {
          if (provider.isSuccess) {
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              provider.reset();
              final prefs = await SharedPreferences.getInstance();
              final userId = prefs.getString('user_id') ?? ' ';
              final deviceToken = prefs.getString('device_token') ?? '';

              final notificationProvider =
              Provider.of<NotificationProvider>(context, listen: false);

              await notificationProvider.notification(
                id: int.parse(userId),
                deviceToken: deviceToken,
              );

              if (notificationProvider.isVerified) {
                print("Notification registered successfully!");
              } else if (notificationProvider.errorMessage != null) {
                print("Notification error: ${notificationProvider.errorMessage}");
              }
              print(_isConsultant);
              if (_isConsultant) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => Isconsaltant()),
                );
              }
              else {Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => Navbar()),
              );}
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
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: colorScheme.primary,
                                  size: 28,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: isArabic()? 0:  180.0, right: isArabic()?180:0),
                                child: text(
                                  label: S.of(context).step3,
                                  fontSize: 14,
                                  color: colorScheme.surface.withOpacity(0.4),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          text(
                            label: S.of(context).register1,
                            fontSize: 28,
                            color: colorScheme.surface.withOpacity(0.6),
                          ),
                          const SizedBox(height: 5),
                          text(
                            label: S.of(context).register2,
                            fontSize: 16,
                            color: colorScheme.surface.withOpacity(0.4),
                          ),
                          text(
                            label: S.of(context).register3,
                            fontSize: 16,
                            color: colorScheme.surface.withOpacity(0.4),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),

                    // First & Last Name
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              text(
                                label: S.of(context).firstName,
                                fontSize: 16,
                                color: colorScheme.surface.withOpacity(0.4),
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: _firstNameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return S.of(context).firstNameValidator;
                                  }
                                  return null;
                                },
                                style: TextStyle(
                                  color: colorScheme.surface.withOpacity(0.4),
                                ),
                                decoration: _buildInputDecoration(
                                  hintText: S.of(context).firstNameHint,
                                  colorScheme: colorScheme,
                                ),
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
                                label: S.of(context).secondName,
                                fontSize: 16,
                                color: colorScheme.surface.withOpacity(0.4),
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: _lastNameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return S.of(context).secondNameValidator;
                                  }
                                  return null;
                                },
                                style: TextStyle(
                                  color: colorScheme.surface.withOpacity(0.4),
                                ),
                                decoration: _buildInputDecoration(
                                  hintText: S.of(context).secondNameHint,
                                  colorScheme: colorScheme,
                                ),
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
                          label: S.of(context).phoneNumber,
                          fontSize: 16,
                          color: colorScheme.surface.withOpacity(0.4),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.of(context).phoneNumberValidator;
                            }
                            if (value.length != 10 ||
                                !RegExp(r'^\d{10}$').hasMatch(value)) {
                              return S.of(context).passwordValidation1;
                            }
                            return null;
                          },
                          style: TextStyle(
                            color: colorScheme.surface.withOpacity(0.4),
                          ),
                          decoration: _buildInputDecoration(
                            hintText: S.of(context).phoneNumberHint,
                            colorScheme: colorScheme,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Gender Picker
                    text(
                      label: S.of(context).gender,
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
                            .map(
                              (gender) => Text(
                            gender,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'NotoSerifGeorgian',
                            ),
                          ),
                        )
                            .toList(),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Password
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        text(
                          label: S.of(context).password,
                          fontSize: 16,
                          color: colorScheme.surface.withOpacity(0.4),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.of(context).passwordValidation1;
                            }
                            return null;
                          },
                          style: TextStyle(
                            color: colorScheme.surface.withOpacity(0.4),
                          ),
                          decoration: _buildInputDecoration(
                            hintText: S.of(context).passwordHint,
                            colorScheme: colorScheme,
                          ).copyWith(
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
                          label: S.of(context).confirmpassword,
                          fontSize: 16,
                          color: colorScheme.surface.withOpacity(0.4),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: _obscureConfirmPassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.of(context).confirmPasswordValidation1;
                            }
                            if (value != _passwordController.text) {
                              return S.of(context).confirmPasswordValidation2;
                            }
                            return null;
                          },
                          style: TextStyle(
                            color: colorScheme.surface.withOpacity(0.4),
                          ),
                          decoration: _buildInputDecoration(
                            hintText: S.of(context).confirmPasswordHint,
                            colorScheme: colorScheme,
                          ).copyWith(
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureConfirmPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: colorScheme.primary,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureConfirmPassword =
                                  !_obscureConfirmPassword;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // Consultant Checkbox
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
                            checkColor: colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: text(
                            label: S.of(context).consultantJoin,
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
                            role: 'user',
                          );

                        } else {
                          _scrollController.animateTo(
                            0,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      child: provider.isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : text(
                        label: S.of(context).register,
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
  bool isArabic () {
    return Intl.getCurrentLocale() == 'ar';
  }
}
