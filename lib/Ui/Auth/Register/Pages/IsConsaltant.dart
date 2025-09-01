import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import '../../../../generated/l10n.dart';
import '../../../ConsaltantUi/NavBar/Pages/consultNavBar.dart';
import '../Compoenets/InputTextField2.dart';
import '../Compoenets/SectionSentence.dart';
import '../Compoenets/text.dart';
import '../../../../Providers/Home/User/Others/SendApplicationProvider.dart';
import '../../../../Providers/Home/User/NavBarProviders/GetDomainsProvider.dart';
import '../../../../Providers/Home/User/Others/GetSubDomainsProvider.dart';
import 'WaititngPage.dart';

class Isconsaltant extends StatefulWidget {
  const Isconsaltant({Key? key}) : super(key: key);

  @override
  State<Isconsaltant> createState() => _IsconsaltantState();
}

class _IsconsaltantState extends State<Isconsaltant> {
  final _formKey = GlobalKey<FormState>();
  final _costController = TextEditingController();
  final _lanController = TextEditingController();
  final _experienceController = TextEditingController();
  final _locationController = TextEditingController();
  final _bioController = TextEditingController();

  int? selectedDomainId;
  int? selectedSubDomainId;
  List<PlatformFile> _uploadedFiles = [];

  @override
  void dispose() {
    _costController.dispose();
    _lanController.dispose();
    _experienceController.dispose();
    _locationController.dispose();
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
  void initState() {
    super.initState();
    final domainsProvider =
    Provider.of<GetDomainsProvider>(context, listen: false);
    domainsProvider.fetchDomains();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<SendApplicationProvider, GetDomainsProvider,
        GetSubDomainsProvider>(
      builder: (context, provider, domainsProvider, subDomainsProvider, _) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              S.of(context).consultantRegistration,
              style: const TextStyle(
                  fontFamily: 'NotoSerifGeorgian', fontWeight: FontWeight.bold),
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Colors.white,
            centerTitle: true,
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
                    SectionTitle(label: S.of(context).IndustryInformation),
                    Text(
                      S.of(context).field,
                      style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .surface
                              .withOpacity(0.4)),
                    ),
                    const SizedBox(height: 8),
                    domainsProvider.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : DropdownButtonFormField<int>(
                      value: selectedDomainId,
                      dropdownColor: Theme.of(context).colorScheme.onSurface,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Theme.of(context)
                            .colorScheme
                            .surface
                            .withOpacity(0.05),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                              width: 1.2),
                        ),
                      ),
                      hint: Text('selectDomain'),
                      items: domainsProvider.domains
                          .map(
                            (d) => DropdownMenuItem<int>(
                          value: d.id,
                              child: text(label: d.name,fontSize: 16,color: Theme.of(context).colorScheme.primary,),
                        ),
                      )
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          selectedDomainId = val;
                          selectedSubDomainId = null;
                        });
                        if (val != null) {
                          subDomainsProvider.fetchSubDomains(id: val);
                        }
                      },
                      validator: (value) =>
                      value == null ? 'fieldRequired' : null,
                    ),

                    const SizedBox(height: 16),

                    Text(
                      S.of(context).specialization,
                      style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .surface
                              .withOpacity(0.4)),
                    ),
                    const SizedBox(height: 8),
                    subDomainsProvider.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : DropdownButtonFormField<int>(
                      value: selectedSubDomainId,
                      dropdownColor: Theme.of(context).colorScheme.onSurface,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Theme.of(context)
                            .colorScheme
                            .surface
                            .withOpacity(0.05),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                              width: 1.2),
                        ),
                      ),
                      hint: Text('selectSubDomain'),
                      items: subDomainsProvider.domains
                          .map(
                            (d) => DropdownMenuItem<int>(
                          value: d.id,
                          child: text(label: d.name,fontSize: 16,color: Theme.of(context).colorScheme.primary,),
                        ),
                      )
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          selectedSubDomainId = val;
                          print(selectedDomainId);
                          print(selectedSubDomainId);
                        });
                      },
                      validator: (value) => value == null
                          ? 'specializationRequired'
                          : null,
                    ),

                    const SizedBox(height: 16),

                    InputTextField2(
                      label: S.of(context).years,
                      controller: _experienceController,
                      icon: Icons.timer_outlined,
                      keyboardType: TextInputType.number,
                    ),
                    SectionTitle(label: S.of(context).presence),
                    InputTextField2(
                      label: S.of(context).location,
                      controller: _locationController,
                      icon: Icons.location_on_outlined,
                    ),
                    SectionTitle(label: S.of(context).fee),
                    InputTextField2(
                      label: S.of(context).fee,
                      controller: _costController,
                      icon: Icons.money,
                      keyboardType: TextInputType.number,
                    ),
                    SectionTitle(label: S.of(context).about),
                    InputTextField2(
                      label: S.of(context).bio,
                      controller: _bioController,
                      maxLength: 250,
                      icon: Icons.edit_note_outlined,
                    ),
                    InputTextField2(
                      label: S.of(context).languages,
                      controller: _lanController,
                      icon: Icons.language,
                    ),

                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SectionTitle(label: S.of(context).files),
                        Container(
                          width: 70,
                          height: 27,
                          child: ElevatedButton.icon(
                            onPressed: _pickFiles,
                            icon: const Icon(Icons.add, size: 14),
                            label: Text(
                              S.of(context).add,
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'NotoSerifGeorgian'),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                              Theme.of(context).colorScheme.primary,
                              foregroundColor: Colors.white,
                              elevation: 1,
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(16),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: _uploadedFiles.isEmpty
                          ? Center(
                        child: Text(
                          S.of(context).addError,
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surface
                                  .withOpacity(0.4),
                              fontFamily: 'NotoSerifGeorgian'),
                        ),
                      )
                          : Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _uploadedFiles
                            .asMap()
                            .entries
                            .map((entry) {
                          int index = entry.key;
                          PlatformFile file = entry.value;

                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
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
                                  constraints:
                                  const BoxConstraints(maxWidth: 140),
                                  child: Text(
                                    file.name,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary,
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
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(Icons.close,
                                        size: 14,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
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
                            minimumSize: const Size(double.infinity, 55),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Theme.of(context).colorScheme.primary,
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              List<File> files = _uploadedFiles
                                  .where((file) => file.path != null)
                                  .map((file) => File(file.path!))
                                  .toList();

                              await provider.sendApplication(
                                location: _locationController.text,
                                description: _bioController.text,
                                cost: _costController.text,
                                domain: selectedDomainId.toString(),
                                subDomain: selectedSubDomainId.toString(),
                                yearsExperience: _experienceController.text,
                                languages: _lanController.text,
                                files: files,
                              );

                              if (provider.isSuccess) {
                               Navigator.push(context, MaterialPageRoute(builder: (context){return WaititngPage();}));
                              } else if (provider.errorMessage != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: text(
                                      label:provider.errorMessage!,
                                      fontSize: 14,
                                      color: Theme.of(context).colorScheme.onSurface,
                                    ),
                                    backgroundColor: Theme.of(context).colorScheme.secondary,
                                  ),

                                );
                              }
                            }
                          },
                          child: provider.isLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : text(
                            label: S.of(context).submit,
                            fontSize: 18,
                            color: Colors.white,
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
      },
    );
  }
}
