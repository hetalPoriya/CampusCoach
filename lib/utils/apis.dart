class Apis {
  //student
  static String studentImageUrl =
      'http://techharrier.com/mycampuscoach/assets/userimage/';
  static String studentSignUp = 'Signup';
  static String studentLogin = 'student_login';
  static String studentForgotPass = 'student_forget_password';
  static String getAllBanner = 'get_all_banner';
  static String studentUpdateProfile = 'update_user_profile';
  static String getCourseLevel = 'getcourselevel';

  static String getAllStream = 'getallstream?level_id=';
  static String getAllUniversityStream = 'getalluniversitystream?level_id=';
  static String getAllCourseStream = 'getallcoursestream?level_id=';

  static String getScholarshipLevel = 'getscholarshiplevel';
  static String getUniversityLevel = 'getuniversitylevel';
  static String getUniversityDetails = 'getuniversitydetails';
  static String getStudyLevel = 'getallstudylevel';
  static String getAllZone = 'getallzone';
  static String getAllCampusCoach = 'get_all_campuscoach';
  static String getAllCourseCoach = 'get_all_coursecoach';
  static String getAllUniversityCoach = 'get_all_universitycoach';
  static String getAllScholarship = 'get_all_scholarship';
  static String getUniversities = 'getuniversities';
  static String getAllCourse = 'getallcourse';
  static String fetchReview = 'fetchreview';
  static String updateUserPassword = 'updateuserpassword';

  //for wishList coach
  static String addMasterInWishlist = 'add_master_in_wishlist';
  static String getMasterWishlist = 'get_master_wishlist';
  static String removeMasterFromWishlist = 'remove_master_from_wishlist';

  //for wishList university
  static String addWishlist = 'add_wishlist';
  static String getWishlist = 'get_wishlist';
  static String removeItemFromWishlist = 'remove_item_from_wishlist';

  //for wishList course
  static String addCourseInWishlist = 'add_course_in_wishlist';
  static String getCourseWishlist = 'get_course_wishlist';
  static String removeCourseFromWishlist = 'remove_course_from_wishlist';

  //for wishList scholarship
  static String addScholarshipInWishlist = 'add_scholarship_in_wishlist';
  static String getScholarshipWishlist = 'get_scholarship_wishlist';
  static String removeScholarshipFromWishlist =
      'remove_scholarship_from_wishlist';

  //book coach
  //call saveBooking api then after you have to access to set review
  static String saveBooking = 'savebooking';
  static String updateFeedback = 'updatefeedback';
  static String getTimeSlot = 'gettimeslot';
  static String getUserOrder = 'getuserorder';

  //coach
  static String coachImageUrl =
      'http://techharrier.com/mycampuscoach/assets/coach_image/';
  static String coachSignUp = 'coachsignup';
  static String coachLogin = 'coach_login';
  static String coachForgotPass = 'master_forget_password';
  static String coachUpdateProfile = 'updatecoachprofile';
  static String updateCoachPassword = 'updatecoachpassword';
  static String updateCoachBankDetails = 'updatecoachbankdetails';

  //booking
  static String coachUpcomingBooking = 'coachupcomingbooking';
  static String coachCancelBooking = 'coachcancelbooking';
  static String acceptBooking = 'acceptbooking';
  static String getCoachOrder = 'getcoachorder';
  static String reScheduleBooking = 'resechdulebooking';
  static String completeBooking = 'completebooking';
  static String rejectBooking = 'rejectbooking';
  static String addTimes = 'add_times';
  static String addWorkingDays = 'add_working_hours_changes';
  static String getWorkingHoursChange = 'get_working_hours_change';
}
