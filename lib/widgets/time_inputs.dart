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
            decoration: InputDecoration(
              labelText: 'Hours',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Theme.of(context).colorScheme.surfaceVariant,
              counterText: '',
            ),
            keyboardType: TextInputType.number,
            maxLength: 3,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
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
        const SizedBox(width: 12.0),
        Expanded(
          child: TextFormField(
            controller: minutesController,
            decoration: InputDecoration(
              labelText: 'Minutes',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Theme.of(context).colorScheme.surfaceVariant,
              counterText: '',
            ),
            keyboardType: TextInputType.number,
            maxLength: 2,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Required';
              }
              final minutes = int.tryParse(value);
              if (minutes == null || minutes >= 60) {
                return 'Invalid';
              }
              return null;
            },
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: TextFormField(
            controller: secondsController,
            decoration: InputDecoration(
              labelText: 'Seconds',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Theme.of(context).colorScheme.surfaceVariant,
              counterText: '',
            ),
            keyboardType: TextInputType.number,
            maxLength: 2,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Required';
              }
              final seconds = int.tryParse(value);
              if (seconds == null || seconds >= 60) {
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