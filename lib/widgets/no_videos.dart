import 'package:flutter/material.dart';

class NoVideos extends StatelessWidget {
 final  void Function()? onPressed;
  const NoVideos({super.key,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.video_library, size: 64, color: Colors.grey),
        const SizedBox(height: 16),
        Text(
          'No videos available',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(color: Colors.grey),
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: onPressed,
          child: const Text('Create your first video'),
        ),
      ],
    );
  }
}
