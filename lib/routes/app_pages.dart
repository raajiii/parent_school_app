import '../controllers/attendance_controller/attendance_details_binding.dart';
import '../controllers/daily_activity_controller/class_time_table_controller/class_timetable_binding.dart';
import '../controllers/daily_activity_controller/news_circular_event_controller/news_circular_event_binding.dart';
import '../controllers/home_controller/home_binding.dart';
import '../controllers/inventory_controller/material_bill_binding.dart';
import '../controllers/library_controller/barrow_binding.dart';
import '../controllers/library_controller/fine_invoice_binding.dart';
import '../controllers/library_controller/fine_list_binding.dart';
import '../controllers/library_controller/renew_binding.dart';
import '../controllers/login_controller/login_binding.dart';
import '../controllers/profile_controller/profile_binding.dart';
import '../view/screens/Home/home_screen.dart';
import 'package:get/get.dart';
import '../view/screens/daily_actvities/attendance/attendance_details_screen.dart';
import '../view/screens/daily_actvities/attendance/leave_status_screen.dart';
import '../view/screens/daily_actvities/circular/circular_screen.dart';
import '../view/screens/daily_actvities/class_time_table/class_time_table_screen.dart';
import '../view/screens/daily_actvities/classtest/class_test_screen.dart';
import '../view/screens/daily_actvities/event/event_screen.dart';
import '../view/screens/daily_actvities/vehicle_tracking_screen.dart';
import '../view/screens/exam_manager/exam_result_and_timetable_screen.dart';
import '../view/screens/extra_activities/extra_curricular_screen.dart';
import '../view/screens/inventory/material_bill_screen.dart';
import '../view/screens/library/barrow_list_screen.dart';
import '../view/screens/library/fine_invoice_screen.dart';
import '../view/screens/library/fine_list_screen.dart';
import '../view/screens/library/renew_list_screen.dart';
import '../view/screens/online_classes/live_classes_screen.dart';
import '../view/screens/daily_actvities/news/news_screen.dart';
import '../view/screens/daily_actvities/sms/sms_screen.dart';
import '../view/screens/daily_actvities/staff/staff_details_screen.dart';
import '../view/screens/daily_actvities/homework/homework_screen.dart';
import '../view/screens/online_classes/study_labs_screen.dart';
import '../view/screens/daily_actvities/voice/voice_screen.dart';
import '../view/screens/login/login_screen.dart';
import '../view/screens/payment_and_invoice/fee_invoice_screen.dart';
import '../view/screens/payment_and_invoice/fee_payment_screen.dart';
import '../view/screens/payment_and_invoice/fee_pending.dart';
import '../view/screens/profile/profile_main.dart';
import '../view/screens/school_calender/school_calender_screen.dart';
import '../view/screens/splash_screen.dart';
import 'app_routes.dart';

class AppPages {
  static List<GetPage> routes = [
    GetPage(
        name: AppRoutes.SPLASHVIEW,
        page: () => const SplashScreen(),
        bindings: []),
    GetPage(
        name: AppRoutes.LOGINVIEW,
        page: () => LoginScreen(),
        bindings: [LoginBinding()]),
    GetPage(
        name: AppRoutes.HOMESCREEN,
        page: () => HomeScreen(),
        bindings: [HomeBinding(), NewsCircularEventBinding()]),
    GetPage(
        name: AppRoutes.CLASSTIEMTABLE,
        page: () =>const ClassTimeTableScreen(),
        bindings: [ClassTimeTableBinding()]),
    GetPage(
        name: AppRoutes.FEEPAYMENT,
        page: () => const FeePaymentScreen(),
        bindings: []),
    GetPage(
        name: AppRoutes.FEEINVOICE,
        page: () => const FeeInvoiceScreen(),
        bindings: []),
    GetPage(
        name: AppRoutes.FEEPENDING,
        page: () =>  FeePendingScreen(),
        bindings: []),
    GetPage(
        name: AppRoutes.STAFFDETAILS,
        page: () => StaffDetailsScreen(),
        bindings: []),
    GetPage(
        name: AppRoutes.EXAMRESULT,
        page: () => const ExamResultScreen(tag: "Exam Result"),
        bindings: [],
        arguments: const {"name": "Exam Result"}),
    GetPage(
        name: AppRoutes.EXAMTIMETABLE,
        page: () => const ExamResultScreen(tag: "Exam TimeTable"),
        bindings: [],
        arguments: const {"name": "Exam TimeTable"}),
    GetPage(
        name: AppRoutes.SMSView,
        page: () =>  SMSScreen(),
        bindings: [NewsCircularEventBinding()],
        arguments: const {"tag": "SMS"}),
    GetPage(
        name: AppRoutes.NEWS,
        page: () => const NewsScreen(),
        bindings: [NewsCircularEventBinding()],
        arguments: const {"tag": "News"}),
    GetPage(
        name: AppRoutes.CIRCULAR,
        page: () => const CircularScreen(),
        bindings: [NewsCircularEventBinding()],
        arguments: const {"tag": "Circular"}),
    GetPage(
        name: AppRoutes.EVENT,
        page: () => const EventScreen(),
        bindings: [NewsCircularEventBinding()],
        arguments: const {"tag": "Event"}),
    GetPage(
        name: AppRoutes.HOMEWORK,
        page: () => const HomeWorkScreen(),
        bindings: [HomeBinding()],
        arguments: const {"tag": "Homework"}),
    GetPage(
        name: AppRoutes.CLASSTEST,
        page: () => const ClassTestScreen(),
        bindings: [],
        arguments: const {"tag": "ClassTest"}),
    GetPage(
        name: AppRoutes.ATTENDANCEDETAILS,
        page: () => AttendanceDetailsScreen(),
        bindings: [AttendanceDetailsBinding()]),
    GetPage(
        name: AppRoutes.VOICE,
        page: () =>  const VoiceScreen(),
        bindings: [],
        arguments: const {"tag": "Voice"}),
    GetPage(
        name: AppRoutes.VEHICLETRACKING,
        page: () => const VehicleTRackingScreen(),
        bindings: []),
    GetPage(
        name: AppRoutes.LIVECLASSES,
        page: () => const LiveClassesScreen(),
        bindings: []),
    GetPage(
        name: AppRoutes.STUDYLABS,
        page: () => const StudyLabsScreen(),
        bindings: []),
    GetPage(
        name: AppRoutes.BAROWLIST,
        page: () => const BarrowListScreen(),
        bindings: [BarrowBinding()]),
    GetPage(
        name: AppRoutes.FINELIST,
        page: () => const FineListScreen(),
        bindings: [FineListBinding()]),
    GetPage(
        name: AppRoutes.RENEWLIST,
        page: () => const RenewListScreen(),
        bindings: [RenewBinding()]),
    GetPage(
        name: AppRoutes.FINEINVOICELIST,
        page: () => FineInvoiceScreen(),
        bindings: [FineInvoiceBinding()]),
    GetPage(
        name: AppRoutes.MATERIALBILL,
        page: () => const MaterialBillScreen(),
        bindings: [MaterialBillBinding()]),
    GetPage(
        name: AppRoutes.EXTRACURRICULAR,
        page: () => const ExtraCurricularScreen(),
        bindings: []),
    GetPage(
        name: AppRoutes.SCHOOLCALENDER,
        page: () => const SchoolCalenderScreen(),
        bindings: []),
    GetPage(
        name: AppRoutes.PROFILE,
        page: () => Profile(),
        bindings: [ProfileBinding()]),
    GetPage(
        name: AppRoutes.LEAVESTATUS,
        page: () => const LeaveStatusScreen(),
        bindings: [AttendanceDetailsBinding()]),
  ];
}
