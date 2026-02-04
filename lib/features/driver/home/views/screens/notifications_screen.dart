import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  // Sample notification data
  final List<Map<String, dynamic>> todayNotifications = [
    {
      'title': 'there is more than one car you can choose from.',
      'message': 'You have a new ride request from Alexandria to Cairo',
      'time': '2 minutes ago.',
    },
    {
      'title': 'Payment received',
      'message': 'Payment of 150 SEK received for ride #1234',
      'time': '1 hour ago',
    },
  ];

  final List<Map<String, dynamic>> yesterdayNotifications = [
    {
      'title': 'Ride completed.',
      'message': 'Ride from Cairo to Alexandria completed successfully',
      'time': 'Yesterday, 3:45 PM',
    },
    {
      'title': 'New ride request.',
      'message': 'You have a new ride request from Giza to Cairo',
      'time': 'Yesterday, 2:30 PM',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),

        actions: [
          TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      'Clear All Notifications',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    content: Text(
                      'Are you sure you want to clear all notifications?',
                      style: TextStyle(fontSize: 14),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.grey[600],

                            fontSize: 14,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          setState(() {
                            // Clear notifications logic here
                          });
                        },
                        child: Text(
                          'Clear All',
                          style: TextStyle(
                            color: Color(0xffF04438),

                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            child: Text(
              'Clear',
              style: TextStyle(
                color: Color(0xff121212),

                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],

        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView(
        children: [
          // Today section
          if (todayNotifications.isNotEmpty) ...[
            Padding(
              padding: EdgeInsets.only(left: 16, top: 16, bottom: 8),
              child: Text(
                'Today',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff0D3244),
                ),
              ),
            ),
            ...todayNotifications.map(
              (notification) => _buildNotificationItem(notification),
            ),
          ],

          // Yesterday section
          if (yesterdayNotifications.isNotEmpty) ...[
            Padding(
              padding: EdgeInsets.only(left: 16, top: 16, bottom: 8),
              child: Text(
                'Yesterday',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff0D3244),
                ),
              ),
            ),
            ...yesterdayNotifications.map(
              (notification) => _buildNotificationItem(notification),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildNotificationItem(Map<String, dynamic> notification) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: notification['title'] + ' ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: notification['message'],
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                notification['time'],
                style: TextStyle(fontSize: 12, color: Colors.grey[500]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
