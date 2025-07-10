
import 'package:flutter/material.dart';

class MainCard extends StatelessWidget {
  final Function()? onTap;
  final String title;
  final IconData icon;
  const MainCard({super.key,required this.onTap, required this.title,required this.icon });

  @override
  Widget build(BuildContext context) {
    return Card(
              color: Colors.white,
              clipBehavior: Clip.antiAlias,
              elevation: 8.0,
              margin: const EdgeInsets.all(16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: InkWell(
                onTap: onTap,
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, size: 80.0),
                    SizedBox(height: 16.0),
                    Text(title, style: TextStyle(fontSize: 24.0)),
                  ],
                ),
              ),
            );
          
  }
}