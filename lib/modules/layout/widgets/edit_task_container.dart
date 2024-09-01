import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:easy_localization/easy_localization.dart';

class EditTaskContainer extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController detailsController;
  final TextEditingController timeController;
  final DateTime? selectedDate;
  final VoidCallback onSave;

  const EditTaskContainer({
    Key? key,
    required this.titleController,
    required this.detailsController,
    required this.timeController,
    required this.selectedDate,
    required this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height * 0.6, // Adjusted height
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'edit_task'.tr(), // Updated translation key
            style: TextStyle(
              fontSize: 24, // Slightly smaller font size
              fontWeight: FontWeight.bold, // Bolder text
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: titleController,
            style: const TextStyle(
              fontSize: 18, // Smaller text for input fields
              fontWeight: FontWeight.bold, // Bolder text for input fields
            ),
            decoration: InputDecoration(
              labelText: 'title'.tr(), // Updated translation key
              border: UnderlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: detailsController,
            style: const TextStyle(
              fontSize: 16, // Smaller text for input fields
              fontWeight: FontWeight.w500, // Bolder text for input fields
            ),
            decoration: InputDecoration(
              labelText: 'task_details'.tr(), // Updated translation key
              border: UnderlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: selectedDate ?? DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (pickedDate != null) {
                // Update the timeController or trigger a callback
                timeController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
              }
            },
            child: AbsorbPointer(
              child: TextField(
                controller: timeController,
                decoration: InputDecoration(
                  labelText: 'select_date'.tr(), // Updated translation key
                  hintText: selectedDate != null
                      ? DateFormat('dd-MM-yyyy').format(selectedDate!)
                      : 'select_date'.tr(), // Updated translation key
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: const UnderlineInputBorder(),
                ),
              ),
            ),
          ),
          const Spacer(), // Pushes the button to the bottom
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3498DB),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0), // Smaller button padding
              minimumSize: const Size(180, 40), // Fixed button size (width and height)
            ),
            onPressed: onSave,
            child: Text(
              'save_changes'.tr(), // Updated translation key
              style: TextStyle(
                fontSize: 18, // Slightly smaller font size
                fontWeight: FontWeight.bold, // Bolder text
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20), // Space below the button
        ],
      ),
    );
  }
}
