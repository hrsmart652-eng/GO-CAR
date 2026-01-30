import 'package:flutter/material.dart';
import 'package:go_car/core/routing/routes.dart';

class DriverAppBar extends StatelessWidget {
  const DriverAppBar({super.key, this.Name});
  final Name;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          'Good morning, $Name!!',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.phone_in_talk_rounded, color: Color(0xFF344054)),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.notifications);
              },
              icon: Icon(Icons.notifications_active, color: Color(0xFF266FFF)),
            ),
          ],
        ),
      ],
    );
  }
}
