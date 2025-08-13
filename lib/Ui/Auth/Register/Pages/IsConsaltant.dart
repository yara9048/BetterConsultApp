import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../../../ConsaltantUi/NavBar/Pages/consultNavBar.dart';
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

  List<PlatformFile> _uploadedFiles = [];

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

  Future<void> _pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
    );

    if (result != null) {
      setState(() {
        _uploadedFiles.addAll(result.files);
      });
    }
  }

  void _removeFile(int index) {
    setState(() {
      _uploadedFiles.removeAt(index);
    });
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
                color: Colors.white,
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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
                  label: "Business Location",
                  controller: _websiteController,
                  icon: Icons.location_on_outlined,
                  validator: (value) {
                    if (value != null &&
                        value.isNotEmpty &&
                        !value.startsWith("http")) {
                      return "Should start with http/https";
                    }
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

                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SectionTitle(label: "Upload Files"),

                    Container(
                      width: 70, // control width
                      height: 27, // control height
                      child: ElevatedButton.icon(
                        onPressed: _pickFiles,
                        icon: const Icon(Icons.add, size: 14),
                        label: const Text(
                          "Add",
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold,fontFamily: 'NotoSerifGeorgian'
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          foregroundColor: Colors.white,
                          elevation: 1,
                          padding: EdgeInsets.zero, // remove internal padding so container controls size
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
            Text(
              "Attach supporting documents that prove your expertise and consultancy credentials.",
              style: TextStyle(color: Theme.of(context).colorScheme.surface.withOpacity(0.4),fontFamily: 'NotoSerifGeorgian'
              ),),
                SizedBox(height: 10,),
                Container(
                  padding: const EdgeInsets.all(16),
                  width: 400,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: _uploadedFiles.isEmpty
                      ?  Center(
                    child: Text(
                      "No files uploaded yet",
                      style: TextStyle(color: Theme.of(context).colorScheme.surface.withOpacity(0.4),fontFamily: 'NotoSerifGeorgian'
                      ),
                    ),
                  )
                      : Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _uploadedFiles.asMap().entries.map((entry) {
                      int index = entry.key;
                      PlatformFile file = entry.value;

                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.15),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.insert_drive_file,
                                  size: 14, color: Colors.blueGrey),
                            ),
                            const SizedBox(width: 8),

                            ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 140),
                              child: Text(
                                file.name,
                                overflow: TextOverflow.ellipsis,
                                style:  TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),

                            InkWell(
                              onTap: () => _removeFile(index),
                              borderRadius: BorderRadius.circular(50),
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child:  Icon(Icons.close,
                                    size: 14, color: Theme.of(context).colorScheme.primary),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 25),
                Center(
                  child: SizedBox(
                    height: 60,
                    width: 350,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 3,
                      ),
                      onPressed:(){Navigator.push(context, MaterialPageRoute(builder: (context){return consultNavBar();}));},
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
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

