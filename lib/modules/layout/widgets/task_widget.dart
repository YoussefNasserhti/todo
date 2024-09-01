import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_4pm/core/models/task_model.dart';
import 'package:todo_4pm/modules/layout/manager/main_provider.dart';
import 'package:todo_4pm/modules/layout/widgets/task_edit_screen.dart';
import 'package:easy_localization/easy_localization.dart';

class TaskWidget extends StatelessWidget {
  final TaskModel task;

  TaskWidget({
    required this.task,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (context, provider, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Slidable(
            key: ValueKey(task.id),
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              dismissible: DismissiblePane(onDismissed: () {
                provider.deleteTask(task.id);
              }),
              children: [
                SlidableAction(
                  borderRadius: BorderRadius.circular(10),
                  onPressed: (context) {
                    provider.deleteTask(task.id);
                  },
                  backgroundColor: const Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'delete'.tr(), // Ensure the translation key exists
                ),
                SlidableAction(
                  borderRadius: BorderRadius.circular(10),
                  onPressed: (context) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaskEditScreen(task: task),
                      ),
                    );
                  },
                  backgroundColor: const Color(0xFF21B7CA),
                  foregroundColor: Colors.white,
                  icon: Icons.edit,
                  label: 'edit'.tr(), // Ensure the translation key exists
                ),
              ],
            ),
            child: Container(
              padding: const EdgeInsets.all(15),
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // Shadow position
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 4,
                    height: 60,
                    decoration: BoxDecoration(
                      color: task.isDone ? Colors.green : Colors.blue,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18, // Adjust font size
                            color: task.isDone ? Colors.green : Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          task.desc,
                          style: TextStyle(
                            color: Colors.grey[700], // Slightly darker text color
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            const Icon(Icons.timelapse, color: Colors.grey),
                            const SizedBox(width: 5),
                            Text(
                              task.time,
                              style: TextStyle(
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  task.isDone
                      ? InkWell(
                    onTap: () {
                      provider.completeTask(task.id);
                    },
                    child: const Text(
                      "Done..!",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                      : InkWell(
                    onTap: () {
                      provider.completeTask(task.id);
                    },
                    child: Container(
                      width: 50,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
