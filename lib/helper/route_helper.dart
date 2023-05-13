import 'package:get/get.dart';
import '../views/views.dart';

class RouteHelper {
  //auth
  static String splashScreen = '/splashScreen';
  static String signIn = '/signIn';
  static String signUp = '/signUp';
  static String studentOrCoachSignIn = '/studentOrCoachSignIn';
  static String forgotPassword = '/forgotPassword';
  static String changePassword = '/changePassword';

  //student
  static String studentMainPage = '/studentMainPage';
  static String appointment = '/appointment';
  static String myAccount = '/myAccount';
  static String myWishList = '/myWishList';
  // static String mySavedCoach = '/mySavedCoach';
  // static String mySavedScholarship = '/mySavedScholarship';
  // static String mySavedUniversity = '/mySavedUniversity';
  // static String mySavedCourses = '/mySavedCourses';
  static String myCareerCoach = '/myCareerCoach';
  static String myCoachDetails = '/myCoachDetails';
  static String scheduleAppointment = '/scheduleAppointment';
  static String allUniversity = '/allUniversity';
  static String universityDetails = '/universityDetails';
  static String allScholarship = '/allScholarship';
  static String scholarshipDetails = '/scholarshipDetails';
  static String allCourses = '/allCourses';
  static String coursesDetails = '/coursesDetails';

  //coach
  static String coachMainPage = '/coachMainPage';
  static String profile = '/profile';
  static String bankDetails = '/bankDetails';
  static String workingHours = '/workingHours';
  static String upcomingAppointment = '/upcomingAppointment';
  static String cancelledAppointment = '/cancelledAppointment';
  static String acceptedAppointment = '/acceptedAppointment';

  static List<GetPage> getPages = [
    //auth
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: signIn, page: () => const SignIn()),
    GetPage(name: signUp, page: () => const SignUp()),
    GetPage(
        name: studentOrCoachSignIn, page: () => const StudentOrCoachSignIn()),
    GetPage(name: forgotPassword, page: () => const ForgotPassword()),
    GetPage(name: changePassword, page: () => const ChangePassword()),

    //student
    GetPage(name: studentMainPage, page: () => StudentMainPage()),
    GetPage(name: appointment, page: () => const Appointment()),
    GetPage(name: myAccount, page: () => MyAccount()),
    GetPage(name: myWishList, page: () => MyWishList()),
    // GetPage(name: mySavedCoach, page: () => const MySavedCareerCoach()),
    // GetPage(name: mySavedScholarship, page: () => const MySavedScholarship()),
    // GetPage(name: mySavedUniversity, page: () => const MySavedUniversity()),
    // GetPage(name: mySavedCourses, page: () => const MySavedCourses()),
    GetPage(name: myCareerCoach, page: () => const MyCareerCoach()),
    GetPage(name: myCoachDetails, page: () => const CoachDetails()),
    GetPage(name: scheduleAppointment, page: () => const ScheduleAppointment()),
    GetPage(name: allUniversity, page: () => const AllUniversity()),
    GetPage(name: universityDetails, page: () => const UniversityDetails()),
    GetPage(name: allScholarship, page: () => AllScholarship()),
    GetPage(name: scholarshipDetails, page: () => ScholarshipDetails()),
    GetPage(name: allCourses, page: () => const AllCourses()),
    GetPage(name: coursesDetails, page: () => const CoursesDetails()),

    //coach
    GetPage(name: coachMainPage, page: () => CoachMainPage()),
    GetPage(name: profile, page: () => Profile()),
    GetPage(name: bankDetails, page: () => BankDetails()),
    GetPage(name: workingHours, page: () => WorkingHours()),
    GetPage(name: upcomingAppointment, page: () => UpcomingAppointment()),
    GetPage(name: acceptedAppointment, page: () => AcceptedAppointment()),
    GetPage(name: cancelledAppointment, page: () => CancelledAppointment()),
  ];
}
