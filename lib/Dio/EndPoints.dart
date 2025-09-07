class Endpoints {
  static const String baseUrl = 'http://192.168.1.2:8000/api/';
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
  static const String videoAndVoiceUploading = 'consultations/check-quality/';
  static const String textUploading = 'consultations/';
  static const String segment = 'consultations/segment-from-quality/';
  static const String editAndShowConsultantProfile = 'consultants/me/';
  static const String roleShowing = 'consultations/my-role/';
  static const String vtt = 'transcribe/';
  static const String topRated = 'consultants/top-rated/';
  static const String notifications = 'notifications/register/';
  static const String waitingList = 'chat/waiting_questions_list/';
  static const String deleteWaitingList = 'chat/delete_question/';
  static const String answeringWaitingFile = 'consultations/segment-answer-waiting/';
  static const String answeringWaitingText = 'consultations/answer-waiting-question/';


}
