import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_4pm/core/models/task_model.dart';
import 'package:todo_4pm/core/service/firebase_functions.dart';
import 'package:todo_4pm/modules/auth/pages/login_screen.dart';
import 'package:todo_4pm/modules/layout/pages/settings_screen.dart';
import 'package:todo_4pm/modules/layout/pages/task_screen.dart';
import 'package:easy_localization/easy_localization.dart'; // إضافة EasyLocalization
import '../../../core/models/user_model.dart';

class MainProvider extends ChangeNotifier {
  int selectedIndex = 0;
  DateTime selectedTime = DateTime.now();
  DateTime selectedTimeTask = DateTime.now();
  TimeOfDay timeOfDay = TimeOfDay.now();
  List<Widget> screens = [TaskScreen(), SettingsScreen()];
  List<String> title = ["Tasks".tr(), "Settings".tr()]; // ترجمة العناوين
  UserModel? user;

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  // متغيرات جديدة للغة والثيم
  String language = 'English'; // اللغة الافتراضية
  ThemeMode themeMode = ThemeMode.light; // الثيم الافتراضي

  void setIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  void setDate(DateTime time) {
    selectedTime = time;
    notifyListeners();
  }

  void setTime(TimeOfDay time) {
    timeOfDay = time;
    notifyListeners();
  }

  void setTimeTask(DateTime time) {
    selectedTimeTask = time;
    notifyListeners();
  }

  void addTask() async {
    TaskModel task = TaskModel(
      title: titleController.text,
      date: DateUtils.dateOnly(selectedTimeTask).millisecondsSinceEpoch,
      desc: descController.text,
      time: "${timeOfDay.hour} : ${timeOfDay.minute}",
      isDone: false,
    );
    await FireBaseFunctions.addTask(task);
    titleController.clear();
    descController.clear();
    notifyListeners(); // Notify listeners after adding task
  }

  Stream<QuerySnapshot<TaskModel?>> getTasksStream() {
    return FireBaseFunctions.getTask(
      DateUtils.dateOnly(selectedTime).millisecondsSinceEpoch,
    );
  }

  void deleteTask(String id) async {
    await FireBaseFunctions.deleteTask(id);
    notifyListeners(); // Notify listeners after deleting task
  }

  void setDone(TaskModel model) async {
    await FireBaseFunctions.setDone(model);
    notifyListeners(); // Notify listeners after updating task status
  }

  void completeTask(String taskId) async {
    DocumentReference taskRef = FirebaseFirestore.instance.collection('Tasks').doc(taskId);

    // Fetch current task data
    DocumentSnapshot taskSnapshot = await taskRef.get();
    if (taskSnapshot.exists) {
      TaskModel task = TaskModel.fromJson(taskSnapshot.data() as Map<String, dynamic>);

      // Toggle the isDone status
      bool newStatus = !task.isDone;

      // Update Firestore
      await taskRef.update({'isDone': newStatus});

      notifyListeners(); // Notify listeners after updating task status
    }
  }

  void getUser() async {
    user = await FireBaseFunctions.getUser();
    notifyListeners();
  }

  void logout(BuildContext context) {
    FireBaseFunctions.logout();
    Navigator.pushNamedAndRemoveUntil(
      context,
      LoginScreen.routeName,
          (route) => false,
    );
  }

  // طرق لضبط اللغة والثيم
  void setLanguage(BuildContext context, String newLanguage) {
    language = newLanguage;
    context.setLocale(Locale(newLanguage)); // تحديث اللغة باستخدام EasyLocalization
    notifyListeners();
  }

  void setThemeMode(ThemeMode newMode) {
    themeMode = newMode;
    notifyListeners();
  }
}
