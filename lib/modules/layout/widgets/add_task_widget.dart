import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart'; // Import EasyLocalization
import 'package:todo_4pm/modules/layout/manager/main_provider.dart';

class AddTaskWidget extends StatelessWidget {
  const AddTaskWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (context, provider, child) {
        return Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text("add_task").tr(), // Translate "Add Task"
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: provider.titleController,
                decoration: InputDecoration(
                  hintText: "title".tr(), // Translate "Title"
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.blue.withOpacity(0.5)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.blue),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: provider.descController,
                decoration: InputDecoration(
                  hintText: "description".tr(), // Translate "Description"
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.blue.withOpacity(0.5)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.blue),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text("select_date").tr(), // Translate "Select Date"
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    initialDate: provider.selectedTimeTask,
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  ).then((value) {
                    provider.setTimeTask(value!);
                  });
                },
                child: Text(
                  provider.selectedTimeTask.toString().substring(0, 10),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text("select_time").tr(), // Translate "Select Time"
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  showTimePicker(
                    context: context,
                    initialTime: provider.timeOfDay,
                  ).then((value) {
                    provider.setTime(value!);
                  });
                },
                child: Text(
                  "${provider.timeOfDay.hour} : ${provider.timeOfDay.minute}",
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  provider.addTask();
                  Navigator.pop(context);
                },
                child: Text("add_task_button".tr()), // Translate "Add Task"
              )
            ],
          ),
        );
      },
    );
  }
}
