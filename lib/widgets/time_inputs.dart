import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TimeInputs extends StatelessWidget {
  final TextEditingController hoursController;
  final TextEditingController minutesController;
  final TextEditingController secondsController;
   const TimeInputs({
    super.key,
    required this.hoursController,
    required this.minutesController,
    required this.secondsController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: hoursController,
            decoration: const InputDecoration(
              labelText: 'Hours',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            maxLength: 100,
            inputFormatters: [
        
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(3), // Limits to 2 digits
        ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Required';
              }
              if (int.tryParse(value) == null) {
                return 'Invalid';
              }
              return null;
            },
          ),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: TextFormField(
            controller: minutesController,
            decoration: const InputDecoration(
              labelText: 'Minutes',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            maxLength: 60,
            inputFormatters: [
        
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(2), // Limits to 2 digits
        ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Required';
              }
              if (int.tryParse(value) == null) {
                return 'Invalid';
              }
              return null;
            },
          ),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: TextFormField(
            controller: secondsController,
            decoration: const InputDecoration(
              labelText: 'Seconds',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            maxLength: 60,
            inputFormatters: [
        
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(2), // Limits to 2 digits
        ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Required';
              }
              if (int.tryParse(value) == null) {
                return 'Invalid';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
