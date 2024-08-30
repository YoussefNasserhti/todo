import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_4pm/modules/layout/widgets/edit_task_container.dart'; // تأكد من استيراد ملف `EditTaskContainer`
import 'package:todo_4pm/core/models/task_model.dart';
import 'package:easy_localization/easy_localization.dart';// تأكد من استيراد ملف `TaskModel`

class TaskEditScreen extends StatefulWidget {
  final TaskModel task; // تأكد من أن النوع هو TaskModel
  TaskEditScreen({required this.task});

  @override
  _TaskEditScreenState createState() => _TaskEditScreenState();
}

class _TaskEditScreenState extends State<TaskEditScreen> {
  late TextEditingController _titleController;
  late TextEditingController _detailsController;
  late TextEditingController _timeController;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _detailsController = TextEditingController(text: widget.task.desc);
    _timeController = TextEditingController(
      text: widget.task.date != 0
          ? DateFormat('dd-MM-yyyy').format(DateTime.fromMillisecondsSinceEpoch(widget.task.date))
          : '',
    );
    _selectedDate = widget.task.date != 0 ? DateTime.fromMillisecondsSinceEpoch(widget.task.date) : null;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _detailsController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    // Save the changes to the task model
    widget.task.title = _titleController.text;
    widget.task.desc = _detailsController.text;
    widget.task.date = _selectedDate?.millisecondsSinceEpoch ?? 0;

    // Navigate back to the task screen with the updated task
    Navigator.pop(context, widget.task);
  }

  void _updateDate(DateTime date) {
    setState(() {
      _selectedDate = date;
      _timeController.text = DateFormat('dd-MM-yyyy').format(date);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('edit task').tr(),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveChanges,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: EditTaskContainer(
          titleController: _titleController,
          detailsController: _detailsController,
          timeController: _timeController,
          selectedDate: _selectedDate,
          onSave: _saveChanges,
        ),
      ),
    );
  }
}
