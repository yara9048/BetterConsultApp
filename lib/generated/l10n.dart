// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Welcome to Better Consult`
  String get title1 {
    return Intl.message(
      'Welcome to Better Consult',
      name: 'title1',
      desc: '',
      args: [],
    );
  }

  /// `Your trusted partner for smart and secure consultations.`
  String get description1 {
    return Intl.message(
      'Your trusted partner for smart and secure consultations.',
      name: 'description1',
      desc: '',
      args: [],
    );
  }

  /// `Choose Your Expert`
  String get title2 {
    return Intl.message(
      'Choose Your Expert',
      name: 'title2',
      desc: '',
      args: [],
    );
  }

  /// `Get personalized advice from professionals you select.`
  String get description2 {
    return Intl.message(
      'Get personalized advice from professionals you select.',
      name: 'description2',
      desc: '',
      args: [],
    );
  }

  /// `Powered by AI`
  String get title3 {
    return Intl.message('Powered by AI', name: 'title3', desc: '', args: []);
  }

  /// `AI-enhanced features for a smarter, faster experience.`
  String get description3 {
    return Intl.message(
      'AI-enhanced features for a smarter, faster experience.',
      name: 'description3',
      desc: '',
      args: [],
    );
  }

  /// `Wide Range of Categories`
  String get title4 {
    return Intl.message(
      'Wide Range of Categories',
      name: 'title4',
      desc: '',
      args: [],
    );
  }

  /// `Access consultations across health, finance, tech, and more.`
  String get description4 {
    return Intl.message(
      'Access consultations across health, finance, tech, and more.',
      name: 'description4',
      desc: '',
      args: [],
    );
  }

  /// `Your Privacy, Our Priority`
  String get title5 {
    return Intl.message(
      'Your Privacy, Our Priority',
      name: 'title5',
      desc: '',
      args: [],
    );
  }

  /// `Advanced security ensures your data stays safe and confidential.`
  String get description5 {
    return Intl.message(
      'Advanced security ensures your data stays safe and confidential.',
      name: 'description5',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message('Skip', name: 'skip', desc: '', args: []);
  }

  /// `Start`
  String get start {
    return Intl.message('Start', name: 'start', desc: '', args: []);
  }

  /// `Wrong login information`
  String get loginErrorSnackBar {
    return Intl.message(
      'Wrong login information',
      name: 'loginErrorSnackBar',
      desc: '',
      args: [],
    );
  }

  /// `Login success!`
  String get loginSuccess {
    return Intl.message(
      'Login success!',
      name: 'loginSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Welcome Back!`
  String get loginWelcome1 {
    return Intl.message(
      'Welcome Back!',
      name: 'loginWelcome1',
      desc: '',
      args: [],
    );
  }

  /// `login to our app to continue`
  String get loginWelcome2 {
    return Intl.message(
      'login to our app to continue',
      name: 'loginWelcome2',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Enter your email`
  String get emailHint {
    return Intl.message(
      'Enter your email',
      name: 'emailHint',
      desc: '',
      args: [],
    );
  }

  /// `Email mustn't be empty`
  String get emailValidation1 {
    return Intl.message(
      'Email mustn\'t be empty',
      name: 'emailValidation1',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email`
  String get emailValidation2 {
    return Intl.message(
      'Please enter a valid email',
      name: 'emailValidation2',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Enter your password`
  String get passwordHint {
    return Intl.message(
      'Enter your password',
      name: 'passwordHint',
      desc: '',
      args: [],
    );
  }

  /// `Password mustn't be empty`
  String get passwordValidation1 {
    return Intl.message(
      'Password mustn\'t be empty',
      name: 'passwordValidation1',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Sign up`
  String get signup {
    return Intl.message('Sign up', name: 'signup', desc: '', args: []);
  }

  /// `Forgot Password?`
  String get doforgetPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'doforgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get DontHaveAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'DontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password`
  String get forgetPassword {
    return Intl.message(
      'Forgot Password',
      name: 'forgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Mail address here`
  String get emailVerification1 {
    return Intl.message(
      'Mail address here',
      name: 'emailVerification1',
      desc: '',
      args: [],
    );
  }

  /// `Enter the mail address associated`
  String get emailVerification2 {
    return Intl.message(
      'Enter the mail address associated',
      name: 'emailVerification2',
      desc: '',
      args: [],
    );
  }

  /// `with your account.`
  String get emailVerification3 {
    return Intl.message(
      'with your account.',
      name: 'emailVerification3',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email`
  String get emailValidation3 {
    return Intl.message(
      'Please enter your email',
      name: 'emailValidation3',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message('Send', name: 'send', desc: '', args: []);
  }

  /// `OTP sent successfully! Check your email.`
  String get sendOTPSnackBar {
    return Intl.message(
      'OTP sent successfully! Check your email.',
      name: 'sendOTPSnackBar',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Email`
  String get sendOTPFailed {
    return Intl.message(
      'Invalid Email',
      name: 'sendOTPFailed',
      desc: '',
      args: [],
    );
  }

  /// `Email Verified Successfully`
  String get OTPSuccess {
    return Intl.message(
      'Email Verified Successfully',
      name: 'OTPSuccess',
      desc: '',
      args: [],
    );
  }

  /// `email invalid`
  String get OTPFailed {
    return Intl.message('email invalid', name: 'OTPFailed', desc: '', args: []);
  }

  /// `Email Verification`
  String get emailVerification {
    return Intl.message(
      'Email Verification',
      name: 'emailVerification',
      desc: '',
      args: [],
    );
  }

  /// `Get your Code`
  String get OTP1 {
    return Intl.message('Get your Code', name: 'OTP1', desc: '', args: []);
  }

  /// `Please enter your 6 digit code that`
  String get OTP2 {
    return Intl.message(
      'Please enter your 6 digit code that',
      name: 'OTP2',
      desc: '',
      args: [],
    );
  }

  /// `was sent to your email address`
  String get OTP3 {
    return Intl.message(
      'was sent to your email address',
      name: 'OTP3',
      desc: '',
      args: [],
    );
  }

  /// `Please enter all 6 digits of the OTP`
  String get OTPValidation {
    return Intl.message(
      'Please enter all 6 digits of the OTP',
      name: 'OTPValidation',
      desc: '',
      args: [],
    );
  }

  /// `Verify and Proceed`
  String get verifyAnsProceed {
    return Intl.message(
      'Verify and Proceed',
      name: 'verifyAnsProceed',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetPassword {
    return Intl.message(
      'Reset Password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password reset successfully! Please login.`
  String get resetSuccess {
    return Intl.message(
      'Password reset successfully! Please login.',
      name: 'resetSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Password reset failed`
  String get resetFailed {
    return Intl.message(
      'Password reset failed',
      name: 'resetFailed',
      desc: '',
      args: [],
    );
  }

  /// `Enter new password`
  String get reset1 {
    return Intl.message(
      'Enter new password',
      name: 'reset1',
      desc: '',
      args: [],
    );
  }

  /// `Your new password should be different`
  String get reset2 {
    return Intl.message(
      'Your new password should be different',
      name: 'reset2',
      desc: '',
      args: [],
    );
  }

  /// `from your previously used one`
  String get reset3 {
    return Intl.message(
      'from your previously used one',
      name: 'reset3',
      desc: '',
      args: [],
    );
  }

  /// `Enter your new password`
  String get newPasswordHint {
    return Intl.message(
      'Enter your new password',
      name: 'newPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter new password`
  String get newPasswordValidation1 {
    return Intl.message(
      'Please enter new password',
      name: 'newPasswordValidation1',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters`
  String get newPasswordValidation2 {
    return Intl.message(
      'Password must be at least 6 characters',
      name: 'newPasswordValidation2',
      desc: '',
      args: [],
    );
  }

  /// `Confirm the password`
  String get confirmPasswordHint {
    return Intl.message(
      'Confirm the password',
      name: 'confirmPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Please confirm your password`
  String get confirmPasswordValidation1 {
    return Intl.message(
      'Please confirm your password',
      name: 'confirmPasswordValidation1',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get confirmPasswordValidation2 {
    return Intl.message(
      'Passwords do not match',
      name: 'confirmPasswordValidation2',
      desc: '',
      args: [],
    );
  }

  /// `Recover Password`
  String get recover {
    return Intl.message(
      'Recover Password',
      name: 'recover',
      desc: '',
      args: [],
    );
  }

  /// `In order to implement the registration`
  String get confirmEmailReg1 {
    return Intl.message(
      'In order to implement the registration',
      name: 'confirmEmailReg1',
      desc: '',
      args: [],
    );
  }

  /// `process, we need to verify your email`
  String get confirmEmailReg2 {
    return Intl.message(
      'process, we need to verify your email',
      name: 'confirmEmailReg2',
      desc: '',
      args: [],
    );
  }

  /// `Step 1 out of 3`
  String get step1 {
    return Intl.message('Step 1 out of 3', name: 'step1', desc: '', args: []);
  }

  /// `Step 2 out of 3`
  String get step2 {
    return Intl.message('Step 2 out of 3', name: 'step2', desc: '', args: []);
  }

  /// `Step 3 out of 3`
  String get step3 {
    return Intl.message('Step 3 out of 3', name: 'step3', desc: '', args: []);
  }

  /// `Send Code`
  String get sendCode {
    return Intl.message('Send Code', name: 'sendCode', desc: '', args: []);
  }

  /// `Male`
  String get male {
    return Intl.message('Male', name: 'male', desc: '', args: []);
  }

  /// `Female`
  String get female {
    return Intl.message('Female', name: 'female', desc: '', args: []);
  }

  /// `Welcome!`
  String get register1 {
    return Intl.message('Welcome!', name: 'register1', desc: '', args: []);
  }

  /// `Your email has verified successfully`
  String get register2 {
    return Intl.message(
      'Your email has verified successfully',
      name: 'register2',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your personal information`
  String get register3 {
    return Intl.message(
      'Please enter your personal information',
      name: 'register3',
      desc: '',
      args: [],
    );
  }

  /// `First name`
  String get firstName {
    return Intl.message('First name', name: 'firstName', desc: '', args: []);
  }

  /// `Please enter your first name`
  String get firstNameHint {
    return Intl.message(
      'Please enter your first name',
      name: 'firstNameHint',
      desc: '',
      args: [],
    );
  }

  /// `First name`
  String get firstNameValidator {
    return Intl.message(
      'First name',
      name: 'firstNameValidator',
      desc: '',
      args: [],
    );
  }

  /// `Last name`
  String get secondName {
    return Intl.message('Last name', name: 'secondName', desc: '', args: []);
  }

  /// `Last name`
  String get secondNameHint {
    return Intl.message(
      'Last name',
      name: 'secondNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your last name`
  String get secondNameValidator {
    return Intl.message(
      'Please enter your last name',
      name: 'secondNameValidator',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Enter your phone number`
  String get phoneNumberHint {
    return Intl.message(
      'Enter your phone number',
      name: 'phoneNumberHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your phone number`
  String get phoneNumberValidator {
    return Intl.message(
      'Please enter your phone number',
      name: 'phoneNumberValidator',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message('Gender', name: 'gender', desc: '', args: []);
  }

  /// `Join us as Consultant`
  String get consultantJoin {
    return Intl.message(
      'Join us as Consultant',
      name: 'consultantJoin',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message('Register', name: 'register', desc: '', args: []);
  }

  /// `Confirm your password`
  String get confirmpassword {
    return Intl.message(
      'Confirm your password',
      name: 'confirmpassword',
      desc: '',
      args: [],
    );
  }

  /// `Consultant Registration`
  String get consultantRegistration {
    return Intl.message(
      'Consultant Registration',
      name: 'consultantRegistration',
      desc: '',
      args: [],
    );
  }

  /// `Let’s build your professional profile as a Consultant`
  String get consultantRegistration1 {
    return Intl.message(
      'Let’s build your professional profile as a Consultant',
      name: 'consultantRegistration1',
      desc: '',
      args: [],
    );
  }

  /// `IndustryInformation`
  String get IndustryInformation {
    return Intl.message(
      'IndustryInformation',
      name: 'IndustryInformation',
      desc: '',
      args: [],
    );
  }

  /// `Field / Industry`
  String get field {
    return Intl.message('Field / Industry', name: 'field', desc: '', args: []);
  }

  /// `Specialization`
  String get specialization {
    return Intl.message(
      'Specialization',
      name: 'specialization',
      desc: '',
      args: [],
    );
  }

  /// `Years of Experience`
  String get years {
    return Intl.message(
      'Years of Experience',
      name: 'years',
      desc: '',
      args: [],
    );
  }

  /// `location`
  String get presence {
    return Intl.message('location', name: 'presence', desc: '', args: []);
  }

  /// `Business Location`
  String get location {
    return Intl.message(
      'Business Location',
      name: 'location',
      desc: '',
      args: [],
    );
  }

  /// `About You`
  String get about {
    return Intl.message('About You', name: 'about', desc: '', args: []);
  }

  /// `Your Bio`
  String get bio {
    return Intl.message('Your Bio', name: 'bio', desc: '', args: []);
  }

  /// `Spoken Languages`
  String get languages {
    return Intl.message(
      'Spoken Languages',
      name: 'languages',
      desc: '',
      args: [],
    );
  }

  /// `Upload Files`
  String get files {
    return Intl.message('Upload Files', name: 'files', desc: '', args: []);
  }

  /// `Attach supporting documents that prove your expertise and consultancy credentials.`
  String get files1 {
    return Intl.message(
      'Attach supporting documents that prove your expertise and consultancy credentials.',
      name: 'files1',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message('Add', name: 'add', desc: '', args: []);
  }

  /// `No files uploaded yet`
  String get addError {
    return Intl.message(
      'No files uploaded yet',
      name: 'addError',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message('Submit', name: 'submit', desc: '', args: []);
  }

  /// `enter`
  String get enter {
    return Intl.message('enter', name: 'enter', desc: '', args: []);
  }

  /// `Welcome`
  String get welcome {
    return Intl.message('Welcome', name: 'welcome', desc: '', args: []);
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Let’s find the consultation you need`
  String get welcome1 {
    return Intl.message(
      'Let’s find the consultation you need',
      name: 'welcome1',
      desc: '',
      args: [],
    );
  }

  /// `Search for your desired consultant`
  String get searchHint {
    return Intl.message(
      'Search for your desired consultant',
      name: 'searchHint',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categories {
    return Intl.message('Categories', name: 'categories', desc: '', args: []);
  }

  /// `See All'`
  String get seeAll {
    return Intl.message('See All\'', name: 'seeAll', desc: '', args: []);
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Favorites`
  String get favorite {
    return Intl.message('Favorites', name: 'favorite', desc: '', args: []);
  }

  /// `History`
  String get history {
    return Intl.message('History', name: 'history', desc: '', args: []);
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Preferences`
  String get preferences {
    return Intl.message('Preferences', name: 'preferences', desc: '', args: []);
  }

  /// `Themes`
  String get theme {
    return Intl.message('Themes', name: 'theme', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Arabic`
  String get arabic {
    return Intl.message('Arabic', name: 'arabic', desc: '', args: []);
  }

  /// `English`
  String get english {
    return Intl.message('English', name: 'english', desc: '', args: []);
  }

  /// `CANCEL`
  String get cancel {
    return Intl.message('CANCEL', name: 'cancel', desc: '', args: []);
  }

  /// `Apply`
  String get apply {
    return Intl.message('Apply', name: 'apply', desc: '', args: []);
  }

  /// `Confirm`
  String get confirm {
    return Intl.message('Confirm', name: 'confirm', desc: '', args: []);
  }

  /// `All Consultant`
  String get allConsultant {
    return Intl.message(
      'All Consultant',
      name: 'allConsultant',
      desc: '',
      args: [],
    );
  }

  /// `Need help finding the right consultant? `
  String get generalChat1 {
    return Intl.message(
      'Need help finding the right consultant? ',
      name: 'generalChat1',
      desc: '',
      args: [],
    );
  }

  /// `Our team is available to assist you — `
  String get generalChat2 {
    return Intl.message(
      'Our team is available to assist you — ',
      name: 'generalChat2',
      desc: '',
      args: [],
    );
  }

  /// `start a chat`
  String get generalChat3 {
    return Intl.message(
      'start a chat',
      name: 'generalChat3',
      desc: '',
      args: [],
    );
  }

  /// ` for personalized recommendations.`
  String get generalChat4 {
    return Intl.message(
      ' for personalized recommendations.',
      name: 'generalChat4',
      desc: '',
      args: [],
    );
  }

  /// `Consultant Details`
  String get consultantDetails {
    return Intl.message(
      'Consultant Details',
      name: 'consultantDetails',
      desc: '',
      args: [],
    );
  }

  /// `About me`
  String get aboutMe {
    return Intl.message('About me', name: 'aboutMe', desc: '', args: []);
  }

  /// `Chat with me`
  String get chatWithMe {
    return Intl.message('Chat with me', name: 'chatWithMe', desc: '', args: []);
  }

  /// `Chat History`
  String get chatHistory {
    return Intl.message(
      'Chat History',
      name: 'chatHistory',
      desc: '',
      args: [],
    );
  }

  /// `Personal Information`
  String get personalInformation {
    return Intl.message(
      'Personal Information',
      name: 'personalInformation',
      desc: '',
      args: [],
    );
  }

  /// `Contact Details`
  String get contactDetails {
    return Intl.message(
      'Contact Details',
      name: 'contactDetails',
      desc: '',
      args: [],
    );
  }

  /// `Cost`
  String get fee {
    return Intl.message('Cost', name: 'fee', desc: '', args: []);
  }

  /// `Chat with Consultant`
  String get chatWithConsultant {
    return Intl.message(
      'Chat with Consultant',
      name: 'chatWithConsultant',
      desc: '',
      args: [],
    );
  }

  /// `Type your message..`
  String get chatHint {
    return Intl.message(
      'Type your message..',
      name: 'chatHint',
      desc: '',
      args: [],
    );
  }

  /// `General Chat`
  String get generalChat {
    return Intl.message(
      'General Chat',
      name: 'generalChat',
      desc: '',
      args: [],
    );
  }

  /// `Start Your Consultant Journey with us`
  String get switchToConsultant {
    return Intl.message(
      'Start Your Consultant Journey with us',
      name: 'switchToConsultant',
      desc: '',
      args: [],
    );
  }

  /// `Confirmation`
  String get confirmation {
    return Intl.message(
      'Confirmation',
      name: 'confirmation',
      desc: '',
      args: [],
    );
  }

  /// `By becoming a consultant, you will be able to share your experience,`
  String get confirmation1 {
    return Intl.message(
      'By becoming a consultant, you will be able to share your experience,',
      name: 'confirmation1',
      desc: '',
      args: [],
    );
  }

  /// `but also will be having higher responsibilities. `
  String get confirmation2 {
    return Intl.message(
      'but also will be having higher responsibilities. ',
      name: 'confirmation2',
      desc: '',
      args: [],
    );
  }

  /// `However, this role requires dedication, professionalism, `
  String get confirmation3 {
    return Intl.message(
      'However, this role requires dedication, professionalism, ',
      name: 'confirmation3',
      desc: '',
      args: [],
    );
  }

  /// `and consistent performance. Are you ready to take on these responsibilities?`
  String get confirmation4 {
    return Intl.message(
      'and consistent performance. Are you ready to take on these responsibilities?',
      name: 'confirmation4',
      desc: '',
      args: [],
    );
  }

  /// `Let’s display some of the consultant that has been implemented `
  String get welcomeCons {
    return Intl.message(
      'Let’s display some of the consultant that has been implemented ',
      name: 'welcomeCons',
      desc: '',
      args: [],
    );
  }

  /// `Professional Information`
  String get professionalInformation {
    return Intl.message(
      'Professional Information',
      name: 'professionalInformation',
      desc: '',
      args: [],
    );
  }

  /// `Add a Consultation`
  String get addConsultant {
    return Intl.message(
      'Add a Consultation',
      name: 'addConsultant',
      desc: '',
      args: [],
    );
  }

  /// `Choose the consultation type then uploaded it`
  String get addConsultant1 {
    return Intl.message(
      'Choose the consultation type then uploaded it',
      name: 'addConsultant1',
      desc: '',
      args: [],
    );
  }

  /// `Video`
  String get video {
    return Intl.message('Video', name: 'video', desc: '', args: []);
  }

  /// `Voice`
  String get voice {
    return Intl.message('Voice', name: 'voice', desc: '', args: []);
  }

  /// `Text`
  String get text {
    return Intl.message('Text', name: 'text', desc: '', args: []);
  }

  /// `Invalid file type. Please upload a `
  String get uploadValidationInvalid {
    return Intl.message(
      'Invalid file type. Please upload a ',
      name: 'uploadValidationInvalid',
      desc: '',
      args: [],
    );
  }

  /// `No file selected.`
  String get uploadValidationNoneSelected {
    return Intl.message(
      'No file selected.',
      name: 'uploadValidationNoneSelected',
      desc: '',
      args: [],
    );
  }

  /// `uploaded successfully!`
  String get uploadValidationSuccess {
    return Intl.message(
      'uploaded successfully!',
      name: 'uploadValidationSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Upload your video`
  String get uploadYourVideo {
    return Intl.message(
      'Upload your video',
      name: 'uploadYourVideo',
      desc: '',
      args: [],
    );
  }

  /// `Upload Video`
  String get uploadVideo {
    return Intl.message(
      'Upload Video',
      name: 'uploadVideo',
      desc: '',
      args: [],
    );
  }

  /// `Upload Audio`
  String get uploadVoice {
    return Intl.message(
      'Upload Audio',
      name: 'uploadVoice',
      desc: '',
      args: [],
    );
  }

  /// `Upload your voice recording`
  String get uploadYourVoice {
    return Intl.message(
      'Upload your voice recording',
      name: 'uploadYourVoice',
      desc: '',
      args: [],
    );
  }

  /// `Write your consultation text`
  String get uploadText {
    return Intl.message(
      'Write your consultation text',
      name: 'uploadText',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your text consultation`
  String get uploadYourTextHint {
    return Intl.message(
      'Please enter your text consultation',
      name: 'uploadYourTextHint',
      desc: '',
      args: [],
    );
  }

  /// `Confirmed! Option:`
  String get confirmedOption {
    return Intl.message(
      'Confirmed! Option:',
      name: 'confirmedOption',
      desc: '',
      args: [],
    );
  }

  /// `Consultation submitted successfully!`
  String get consultationDone {
    return Intl.message(
      'Consultation submitted successfully!',
      name: 'consultationDone',
      desc: '',
      args: [],
    );
  }

  /// `Please upload a`
  String get pleaseUpload {
    return Intl.message(
      'Please upload a',
      name: 'pleaseUpload',
      desc: '',
      args: [],
    );
  }

  /// `file.`
  String get file {
    return Intl.message('file.', name: 'file', desc: '', args: []);
  }

  /// `No categories found.`
  String get NoCategories {
    return Intl.message(
      'No categories found.',
      name: 'NoCategories',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message('All', name: 'all', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
