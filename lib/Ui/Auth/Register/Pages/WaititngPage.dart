import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled6/Providers/Home/Consultant/RoleProvider.dart';
import 'package:untitled6/Ui/Auth/Login/pages/login.dart';
import 'package:untitled6/Ui/Auth/Register/Compoenets/text.dart';

import '../../../../generated/l10n.dart';


class WaititngPage extends StatefulWidget {
  const WaititngPage({super.key});

  @override
  State<WaititngPage> createState() => _WaititngPageState();
}

class _WaititngPageState extends State<WaititngPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSurface,
      body: Stack(
        children: [
          Image.asset("assets/images/Untitled design (1).png"),
          Positioned(
            top: 70,
            left: 30,
            child: Text(
              "Waiting Page",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
                fontFamily: 'NotoSerifGeorgian',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 350.0, left: 20, right: 20),
            child: Column(
              children: [
                Text(
                  "Your application has been submitted.\nPlease wait for the admin's confirmation to login as a consultant.",
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.primary,
                    height: 1.5,
                    fontFamily: 'NotoSerifGeorgian',
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Consumer<GetRole>(
                  builder: (context, roleProvider, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Theme.of(context).colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(color: Theme.of(context).colorScheme.primary),
                            ),
                            minimumSize: const Size(140, 40),
                          ),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => const Login()));
                          },
                          child: const Text(
                            'Return to Login',
                            style: TextStyle(fontFamily: 'NotoSerifGeorgian', fontSize: 14),
                          ),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            foregroundColor: Theme.of(context).colorScheme.onSurface,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            minimumSize: const Size(140, 40),
                          ),
                          onPressed: roleProvider.isLoading
                              ? null
                              : () async {
                            await roleProvider.getRole();
                            final messenger = ScaffoldMessenger.of(context);
                            if (roleProvider.isSuccess) {
                              if (roleProvider.role!.role == 'user') {
                                messenger.showSnackBar(
                                  SnackBar(
                                    content: text(
                                      label: "You're still a user, retry later or login. ",
                                      fontSize: 14,
                                      color: Theme.of(context).colorScheme.onSurface,
                                    ),
                                    backgroundColor: Theme.of(context).colorScheme.secondary,
                                  ),
                                );
                              } else if (roleProvider.role!.role == 'consultant') {
                                messenger.showSnackBar(
                                      SnackBar(
                                        content: text(
                                          label: 'You become a consultant, Login!',
                                          fontSize: 14,
                                          color: Theme.of(context).colorScheme.onSurface,
                                        ),
                                        backgroundColor: Theme.of(context).colorScheme.secondary,
                                      ),
                                );
                              }
                            } else if (roleProvider.errorMessage != null) {
                              messenger.showSnackBar(
                                SnackBar(
                                  content: Text(roleProvider.errorMessage!),
                                  backgroundColor: Theme.of(context).colorScheme.secondary,
                                ),
                              );
                            }
                          },
                          child: roleProvider.isLoading
                              ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                          )
                              : const Text(
                            "Refresh",
                            style: TextStyle(fontSize: 16, fontFamily: 'NotoSerifGeorgian'),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
