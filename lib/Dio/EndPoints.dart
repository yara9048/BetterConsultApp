class Endpoints {
  static const String baseUrl = 'http://10.209.132.112:8000/api/';
  static const String login = 'auth/login/';
  static const String register = 'auth/register/';
  static const String logout = 'auth/logout/';
  static const String sendOTP = 'auth/send-otp/';
  static const String verifyOTP = 'auth/verify-otp/';
  static const String resetPassword = 'auth/confirm-password-reset/';
  static const String getDomains = 'domains/';
  static const String getSubDomains = 'subdomains/by-domain/';
  static const String sendApplication = 'consultant-applications/';
  static const String allConsultantByDomain = 'consultants/by-domain-subdomain/';
  static const String favorite = 'favorites/';
  static const String consultantDetails = 'consultants/';
  static const String search = 'consultants/?search=';
  static const String viewProfile = 'auth/view_profile/';
  static const String editProfile = 'auth/update_profile/';
  static const String deleteProfile = 'auth/delete_account/';
  static const String review = 'reviews/';
  static const String checkQuality = 'consultations/quality-check/';
  static const String chat = 'chat/ask/';
  static const String deleteChat = 'chat/delete/';
  static const String chatHistory = 'chat/get_user_chats/';
  static const String chatHistoryContent = 'chat/messages/';
  static const String generalChat = 'chat/question_consultants/';
  static const String Vtt = 'transcribe/';

}
