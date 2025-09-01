import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:untitled6/Providers/Home/User/NavBarProviders/ViewProfileProvider.dart';
import '../../../Providers/Auth/logoutProvider.dart';
import '../../../Providers/Home/User/NavBarProviders/DeleteProfileProvider.dart';
import '../../../Providers/Home/User/NavBarProviders/EditProfile.dart';
import '../../../generated/l10n.dart';
import '../../../main.dart';
import '../../Auth/Login/pages/login.dart';
import '../../Auth/Register/Compoenets/text.dart';
import '../../Auth/Register/Pages/IsConsaltant.dart';
import '../Components/InfoCard.dart';
import '../Components/ProfileItemRow.dart';
import '../Components/ProfileItemRow2.dart';
import '../Components/SectionHeader.dart';
import '../Components/_buildCompactDropdown.dart';
import '../Pages/Notifications.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late bool isDarkMode;
  late String currentLanguage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ViewProfileProvider>(context, listen: false).fetchProfile();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isDarkMode = MyApp.of(context).isDarkMode;
    currentLanguage = MyApp.of(context).locale.languageCode;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer<Logoutprovider>(
      builder: (context, logoutProvider, _) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (logoutProvider.isSuccess) {
            logoutProvider.reset();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Login()),
            );
          } else if (logoutProvider.errorMessage != null) {
            final msg = logoutProvider.errorMessage!;
            logoutProvider.reset();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: text(
                label:msg,
                fontSize: 14,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              backgroundColor: Theme.of(context).colorScheme.secondary,
            ),
            );
          }
        });

        return Scaffold(
          backgroundColor: const Color(0xfff5f7fa),
          appBar: AppBar(
            backgroundColor: theme.colorScheme.primary,
            automaticallyImplyLeading: false,
            title: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(Icons.notifications_none),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Notifications()),
                      );
                    },
                  ),
                ),
                Text(
                  S.of(context).profile,
                  style: TextStyle(
                    fontFamily: 'NotoSerifGeorgian',
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.white,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: logoutProvider.isLoading
                      ? Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: theme.colorScheme.onSurface,
                        strokeWidth: 2,
                      ),
                    ),
                  )
                      : IconButton(
                    onPressed: () => logoutProvider.logout(),
                    icon: Icon(
                      Icons.logout,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: Consumer<ViewProfileProvider>(
            builder: (context, provider, child) {
              if (provider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (provider.errorMessage != null) {
                return Center(
                  child: text(
                    label: provider.errorMessage!,
                    fontSize: 16,
                    color: theme.colorScheme.error,
                  ),
                );
              } else if (provider.profile == null) {
                return Center(
                  child: text(
                    label: "nothing to show",
                    fontSize: 25,
                    color: theme.colorScheme.primary,
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Column(
                            children: [
                              ClipOval(
                                child: Container(
                                  width: 125,
                                  height: 125,
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.primary.withOpacity(0.1),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.person,
                                      size: 90,
                                      color: theme.colorScheme.primary,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                provider.profile!.firstName,
                                style: theme.textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'NotoSerifGeorgian',
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        SectionHeader(label: S.of(context).personalInformation),
                        const SizedBox(height: 8),
                        InfoCard(
                          children: [
                            ProfileItemRow2(
                              icon: Icons.person,
                              label: provider.profile!.firstName,
                              onTap: () {
                                showEditPopup(
                                  context: context,
                                  fieldType: "firstnaame",
                                  title: "Edit First Name",
                                  initialValue: provider.profile!.firstName,
                                );
                              },
                            ),
                            ProfileItemRow2(
                              icon: Icons.person_outline,
                              label: provider.profile!.lastName,
                              onTap: () {
                                showEditPopup(
                                  context: context,
                                  fieldType: "lastname",
                                  title: "Edit Last Name",
                                  initialValue: provider.profile!.lastName,
                                );
                              },
                            ),
                            ProfileItemRow2(
                              icon: provider.profile!.gender.toLowerCase() == "male"
                                  ? Icons.male
                                  : provider.profile!.gender.toLowerCase() == "female"
                                  ? Icons.female
                                  : Icons.person,
                              label: provider.profile!.gender,
                              onTap: () {
                                showEditPopup(
                                  context: context,
                                  fieldType: "gender",
                                  title: "Edit Gender",
                                  initialValue: provider.profile!.gender,
                                );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        SectionHeader(label: S.of(context).contactDetails),
                        const SizedBox(height: 8),
                        InfoCard(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: ProfileItemRow(
                                icon: Icons.email,
                                label: provider.profile!.email,
                              ),
                            ),
                            ProfileItemRow2(
                              icon: Icons.phone,
                              label: provider.profile!.phoneNumber,
                              onTap: () {
                                showEditPopup(
                                  context: context,
                                  fieldType: "phonenumber",
                                  title: "Edit phone number",
                                  initialValue: provider.profile!.phoneNumber,
                                );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        SectionHeader(label: S.of(context).preferences),
                        const SizedBox(height: 8),
                        InfoCard(
                          children: [
                            StatefulBuilder(
                              builder: (context, setStateSB) {
                                return ProfileItemRow(
                                  icon: isDarkMode ? Icons.dark_mode : Icons.light_mode,
                                  label: S.of(context).theme,
                                  trailingWidget: Padding(
                                    padding: EdgeInsets.only(
                                      left: isArabic() ? 0 : 140.0,
                                      right: isArabic() ? 140 : 0,
                                    ),
                                    child: Switch.adaptive(
                                      value: isDarkMode,
                                      onChanged: (value) {
                                        setStateSB(() {
                                          isDarkMode = value;
                                        });
                                        MyApp.of(context).setTheme(value);
                                      },
                                      activeColor: theme.colorScheme.primary,
                                      activeTrackColor: theme.colorScheme.primary.withOpacity(0.5),
                                      inactiveThumbColor: theme.colorScheme.primary,
                                      inactiveTrackColor: theme.colorScheme.primary.withOpacity(0.3),
                                    ),
                                  ),
                                );
                              },
                            ),
                            StatefulBuilder(
                              builder: (context, setStateSB) {
                                return ProfileItemRow(
                                  icon: Icons.language,
                                  label: S.of(context).language,
                                  trailingWidget: Padding(
                                    padding: EdgeInsets.only(
                                      left: isArabic() ? 0 : 60.0,
                                      right: isArabic() ? 90 : 0,
                                    ),
                                    child: SizedBox(
                                      width: 120,
                                      child: CompactDropdown(
                                        value: currentLanguage,
                                        items: [
                                          DropdownMenuItem(
                                            value: 'en',
                                            child: Text(
                                              S.of(context).english,
                                              style: TextStyle(
                                                color: theme.colorScheme.primary,
                                                fontFamily: 'NotoSerifGeorgian',
                                              ),
                                            ),
                                          ),
                                          DropdownMenuItem(
                                            value: 'ar',
                                            child: Text(
                                              S.of(context).arabic,
                                              style: TextStyle(
                                                color: theme.colorScheme.primary,
                                                fontFamily: 'NotoSerifGeorgian',
                                              ),
                                            ),
                                          ),
                                        ],
                                        onChanged: (val) {
                                          if (val != null) {
                                            setState(() => currentLanguage = val);
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        // Switch to Consultant
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () {
                                _Confirmation();
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 20,
                                  horizontal: 24,
                                ),
                                child: Center(
                                  child: text(
                                    label: S.of(context).switchToConsultant,
                                    color: Theme.of(context).colorScheme.onSurface,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Delete Account
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Theme.of(context).colorScheme.onPrimary),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () => _showDeleteConfirmation(context),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.delete_forever,
                                        color: Theme.of(context).colorScheme.onSurface),
                                    const SizedBox(width: 10),
                                    Text(
                                      "delete account",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'NotoSerifGeorgian',
                                        color: Theme.of(context).colorScheme.onSurface,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }

  Future<void> showEditPopup({
    required BuildContext context,
    required String fieldType,
    required String title,
    required String initialValue,
  }) async {
    final TextEditingController controller = TextEditingController(text: initialValue);
    TextInputType keyboardType;
    switch (fieldType.toLowerCase()) {
      case "firstnaame":
      case "gender":
      case "lastname":
        keyboardType = TextInputType.name;
        break;
      case "phonenumber":
        keyboardType = TextInputType.phone;
        break;
      default:
        keyboardType = TextInputType.text;
    }

    await showDialog(
      context: context,
      builder: (context) {
        final theme = Theme.of(context);
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          backgroundColor: theme.colorScheme.onSurface,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Consumer2<EditProfile, ViewProfileProvider>(
              builder: (context, editProvider, viewProvider, _) {
                return StatefulBuilder(
                  builder: (context, setStateSB) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                            fontFamily: 'NotoSerifGeorgian',
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: controller,
                          keyboardType: keyboardType,
                          style: TextStyle(
                            color: theme.colorScheme.surface.withOpacity(0.4),
                            fontFamily: 'NotoSerifGeorgian',
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            hintText: "Enter $fieldType",
                            hintStyle: TextStyle(
                              color: theme.colorScheme.primary,
                              fontSize: 16,
                              fontFamily: 'NotoSerifGeorgian',
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: theme.colorScheme.primary),
                              ),
                              child: TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text(
                                  S.of(context).cancel,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: theme.colorScheme.primary,
                                    fontFamily: 'NotoSerifGeorgian',
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            // Submit
                            Container(
                              width: 100,
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: TextButton(
                                onPressed: editProvider.isLoading
                                    ? null
                                    : () async {
                                  final newValue = controller.text.trim();
                                  final profile = viewProvider.profile!;
                                  final phone = fieldType == "phonenumber"
                                      ? int.tryParse(newValue) ?? int.parse(profile.phoneNumber)
                                      : int.parse(profile.phoneNumber);
                                  final first = fieldType == "firstnaame" ? newValue : profile.firstName;
                                  final last = fieldType == "lastname" ? newValue : profile.lastName;
                                  final gender = fieldType == "gender" ? newValue : profile.gender;

                                  await editProvider.editProfile(phone, first, last, gender);

                                  setStateSB(() {});

                                  if (editProvider.isVerified) {
                                    await viewProvider.fetchProfile();
                                    Navigator.of(context).pop();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: text(
                                          label:"Profile updated successfully",
                                          fontSize: 14,
                                          color: Theme.of(context).colorScheme.onSurface,
                                        ),
                                        backgroundColor: Theme.of(context).colorScheme.secondary,
                                      ),
                                    );
                                  } else if (editProvider.errorMessage != null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: text(
                                          label:editProvider.errorMessage!,
                                          fontSize: 14,
                                          color: Theme.of(context).colorScheme.onSurface,
                                        ),
                                        backgroundColor: Theme.of(context).colorScheme.secondary,
                                      ),
                                                                     );
                                  }
                                },
                                child: editProvider.isLoading
                                    ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                                )
                                    : Text(
                                  "Submit",
                                  style: TextStyle(
                                    color: theme.colorScheme.onSurface,
                                    fontFamily: 'NotoSerifGeorgian',
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  bool isArabic() {
    return Intl.getCurrentLocale() == 'ar';
  }


void _Confirmation() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 12,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSurface,
              borderRadius: BorderRadius.circular(10),
            ),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.85,
            ),
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  S.of(context).confirmation,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.primary,
                    fontFamily: 'NotoSerifGeorgian',
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  S.of(context).confirmation1 +
                      " " +
                      S.of(context).confirmation2 +
                      " " +
                      S.of(context).confirmation3 +
                      " " +
                      S.of(context).confirmation4,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.primary,
                    fontFamily: 'NotoSerifGeorgian',
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          foregroundColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                          textStyle: const TextStyle(
                            fontFamily: 'NotoSerifGeorgian',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(S.of(context).cancel),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          textStyle: const TextStyle(
                            fontFamily: 'NotoSerifGeorgian',
                            fontWeight: FontWeight.w600,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return Isconsaltant();
                              },
                            ),
                          );
                        },
                        child: Text(S.of(context).confirm),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Consumer<DeleteProfile>(
          builder: (context, deleteProvider, child) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 12,
              insetPadding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 24),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme
                      .of(context)
                      .colorScheme
                      .onSurface,
                  borderRadius: BorderRadius.circular(10),
                ),
                constraints: BoxConstraints(
                  maxWidth: MediaQuery
                      .of(context)
                      .size
                      .width * 0.85,
                ),
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.warning, size: 60, color: Theme
                        .of(context)
                        .colorScheme
                        .primary),
                    const SizedBox(height: 16),
                    Text(
                      "Delete Account",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'NotoSerifGeorgian',
                        color: Theme
                            .of(context)
                            .colorScheme
                            .primary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Are you sure you want to delete your personal account forever?",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'NotoSerifGeorgian',
                        fontWeight: FontWeight.w500,
                        color: Theme
                            .of(context)
                            .colorScheme
                            .primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Cancel button
                        Container(
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Theme
                                  .of(context)
                                  .colorScheme
                                  .primary,
                            ),
                          ),
                          child: TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text(
                              S
                                  .of(context)
                                  .cancel,
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme
                                    .of(context)
                                    .colorScheme
                                    .primary,
                                fontFamily: 'NotoSerifGeorgian',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Confirm Delete Button
                        Container(
                          width: 100,
                          decoration: BoxDecoration(
                            color: Theme
                                .of(context)
                                .colorScheme
                                .primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextButton(
                            onPressed: deleteProvider.isLoading
                                ? null
                                : () async {
                              await deleteProvider.deleteAccount();
                              if (deleteProvider.isVerified) {
                                Navigator.of(context).pop(); // close dialog
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (_) => Login()),
                                      (route) => false,
                                );
                              } else if (deleteProvider.errorMessage != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: text(
                                      label: deleteProvider.errorMessage!,
                                      fontSize: 14,
                                      color: Theme.of(context).colorScheme.onSurface,
                                    ),
                                    backgroundColor: Theme.of(context).colorScheme.secondary,
                                  ),
                                );
                              }
                            },
                            child: deleteProvider.isLoading
                                ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2, color: Colors.white),
                            )
                                : Text(
                              S
                                  .of(context)
                                  .confirm,
                              style: TextStyle(
                                color: Theme
                                    .of(context)
                                    .colorScheme
                                    .onSurface,
                                fontFamily: 'NotoSerifGeorgian',
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    bool isArabic() {
      return Intl.getCurrentLocale() == 'ar';
    }
  }}