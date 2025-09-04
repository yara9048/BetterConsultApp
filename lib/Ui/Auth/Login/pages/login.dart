import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled6/Providers/Auth/LoginProvider.dart';
import '../../../../generated/l10n.dart';
import '../../../ConsaltantUi/NavBar/Pages/consultNavBar.dart';
import '../../../Home/Pages/NavBar.dart';
import '../../ForgetPassword/Pages/forgetPass.dart';
import '../../Register/Compoenets/text.dart';
import '../../Register/Pages/EmailConfiramtion.dart';
import '../../Register/Pages/register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) => LoginProvider(),
        child: Consumer<LoginProvider>(
          builder: (context, auth, _) {
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              if (auth.isSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: text(
                      label:S.of(context).loginSuccess,
                      fontSize: 14,
                      color: colorScheme.onSurface,
                    ),
                    backgroundColor: colorScheme.secondary,
                  ),
                );
                auth.reset();
                final prefs = await SharedPreferences.getInstance();
                final role = prefs.getString('user_role');
                print("User role is: $role");
                if (role == "user") {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Navbar()));
                } else {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => consultNavBar()));
                }
              } else if (auth.errorMessage != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: text(
                      label: S.of(context).loginErrorSnackBar,
                      fontSize: 14,
                      color: colorScheme.onSurface,
                    ),
                    backgroundColor: colorScheme.secondary,
                  ),
                );

                auth.reset();
              }
            });

            return Stack(
              children: [
                Image(
                  image: isLightMode
                      ? const AssetImage(
                    'assets/images/Blue and Pink Soft Watercolor No Copy Phone Wallpaper.png',
                  )
                      : const AssetImage(
                    'assets/images/photo_2025-07-24_11-11-23.jpg',
                  ),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
                Positioned(
                  top: 70,
                  left: 30,
                  child: Padding(
                    padding: EdgeInsets.only(left:isArabic() ? 260: 0),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.arrow_back_ios,
                          color: Colors.white, size: 28),
                    ),
                  ),
                ),
                Positioned(
                  top: 250,
                  left: 0,
                  right: 0,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                    child: Container(
                      height: 1000,
                      padding: const EdgeInsets.all(30),
                      color: colorScheme.onSurface,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Center(
                              child: Column(
                                children: [
                                  text(
                                    label: S.of(context).loginWelcome1,
                                    fontSize: 25,
                                    color: colorScheme.surface.withOpacity(0.6),
                                  ),
                                  text(
                                    label: S.of(context).loginWelcome2,
                                    fontSize: 16,
                                    color: colorScheme.surface.withOpacity(0.4),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 25),
                            text(
                              label: S.of(context).email,
                              fontSize: 16,
                              color: colorScheme.surface.withOpacity(0.4),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _emailController,
                              style: TextStyle(
                                color: colorScheme.surface.withOpacity(0.4),
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: colorScheme.surface.withOpacity(0.05),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: colorScheme.primary,
                                    width: 2.0,
                                  ),
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
                                hintText:S.of(context).emailHint,
                                hintStyle: TextStyle(
                                  color: colorScheme.primary,
                                  fontSize: 15,
                                  fontFamily: 'NotoSerifGeorgian',
                                ),
                                errorStyle: TextStyle(
                                  color: colorScheme.secondary,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return S.of(context).emailValidation1;
                                } else if (!value.contains('@')) {
                                  return S.of(context).emailValidation2;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            text(
                              label: S.of(context).password,
                              fontSize: 16,
                              color: colorScheme.surface.withOpacity(0.4),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              style: TextStyle(
                                color: colorScheme.surface.withOpacity(0.4),
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: colorScheme.surface.withOpacity(0.05),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: colorScheme.primary,
                                    width: 2.0,
                                  ),
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
                                hintText: S.of(context).passwordHint,
                                hintStyle: TextStyle(
                                  color: colorScheme.primary,
                                  fontSize: 15,
                                  fontFamily: 'NotoSerifGeorgian',
                                ),
                                errorStyle: TextStyle(
                                  color: colorScheme.secondary,
                                ),
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
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return S.of(context).passwordValidation1;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 5),
                            Align(
                              alignment: isArabic()? Alignment.centerLeft : Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ForgetPass(),
                                    ),
                                  );
                                },
                                child: text(
                                  label:S.of(context).doforgetPassword,
                                    color: colorScheme.surface.withOpacity(0.4),
                                    fontSize: 12,

                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: colorScheme.primary,
                                  padding:
                                   EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: auth.isLoading
                                    ? null
                                    : () {
                                  if (_formKey.currentState!.validate()) {
                                    auth.login(
                                      _emailController.text.trim(),
                                      _passwordController.text,
                                    );
                                  }
                                },
                                child: auth.isLoading
                                    ?  CircularProgressIndicator(
                                    strokeWidth: 4,
                                    color: Theme.of(context).colorScheme.primary,

                                )
                                    : text(
                                  label: S.of(context).login,
                                  fontSize: 20,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                text(
                                  label: S.of(context).DontHaveAccount,
                                  fontSize: 15,
                                  color: colorScheme.surface.withOpacity(0.4),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => //Emailconfiramtion()));
                                              Register(email:'yaramicrosoft1221@gmail.com')));
                                  },
                                  child: text(
                                    label: S.of(context).signup,
                                    fontSize: 15,
                                    color: colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
  bool isArabic () {
    return Intl.getCurrentLocale() == 'ar';
  }

}
