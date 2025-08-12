import 'package:flutter/material.dart';
import '../Compoenets/InputTextField2.dart';
import '../Compoenets/SectionSentence.dart';

class Isconsaltant extends StatefulWidget {
  const Isconsaltant({super.key});

  @override
  State<Isconsaltant> createState() => _IsconsaltantState();
}

class _IsconsaltantState extends State<Isconsaltant> {
  final _formKey = GlobalKey<FormState>();
  final _fieldController = TextEditingController();
  final _specializationController = TextEditingController();
  final _lanController = TextEditingController();
  final _experienceController = TextEditingController();
  final _websiteController = TextEditingController();
  final _bioController = TextEditingController();

  @override
  void dispose() {
    _fieldController.dispose();
    _specializationController.dispose();
    _lanController.dispose();
    _experienceController.dispose();
    _websiteController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Success"),
          content: const Text("Your information has been submitted."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            )
          ],
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Consultant Registration",
          style: TextStyle(
            fontFamily: 'NotoSerifGeorgian',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: colorScheme.primary,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 2,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              "Let’s build your professional profile as a Consultant",
              style: TextStyle(
                color:Colors.white,
                fontSize: 12,
                fontFamily: 'NotoSerifGeorgian',
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(left: 20,right: 20,top: 8),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionTitle(label: "Industry Information"),
                InputTextField2(
                  label: "Field / Industry",
                  controller: _fieldController,
                  icon: Icons.business_center_outlined,
                ),
                InputTextField2(
                  label: "Specialization",
                  controller: _specializationController,
                  icon: Icons.school_outlined,
                ),
                InputTextField2(
                  label: "Years of Experience",
                  controller: _experienceController,
                  icon: Icons.timer_outlined,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Required";
                    if (int.tryParse(value) == null) return "Enter a number";
                    return null;
                  },
                ),
                SectionTitle(label: "Online Presence"),
                InputTextField2(
                  label: "Buisness Location",
                  controller: _websiteController,
                  icon: Icons.location_on_outlined,
                  validator: (value) {
                    if (value != null && value.isNotEmpty && !value.startsWith("http"))
                      return "Should start with http/https";
                    return null;
                  },
                ),
                SectionTitle(label: "About You"),
                InputTextField2(
                  label: "Your Bio",
                  controller: _bioController,
                  maxLength: 250,
                  icon: Icons.edit_note_outlined,
                ),
                InputTextField2(
                  label: "Spoken Languages",
                  controller: _lanController,
                  icon: Icons.language,
                ),

                Center(
                  child: Container(
                    height: 60,
                    width: 350,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _submitForm,
                      child: const Text(
                        "Submit",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'NotoSerifGeorgian',
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
