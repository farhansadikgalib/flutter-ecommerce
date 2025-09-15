import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import '../../core/helper/print_log.dart';
import '../../core/helper/webview_helper.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  static RemoteMessage? initialNotification;

  factory NotificationService() => _instance;

  NotificationService._internal();

  Future<void> initialize() async {
    // Request permission
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Subscribe to flash_sale topic
    await FirebaseMessaging.instance.subscribeToTopic('flash_sale');

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // Handle notification clicks when app is in background or terminated
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);

    // Check for initial message (app opened from terminated state)
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      initialNotification = initialMessage;
      // Delay navigation until after first frame
      WidgetsBinding.instance.addPostFrameCallback((_) {
        printLog('App opened from terminated state via notification');
        printLog(
          'Navigating to notification screen with data: ${initialMessage.data}',
        );
        // Get.offAllNamed(Routes.NOTIFICATION, arguments: initialMessage);
        _handleInitialMessage(initialMessage);
      });
    }
  }

  // Call this when notification is removed
  Future<void> removeNotificationAndUnsubscribe() async {
    await FirebaseMessaging.instance.unsubscribeFromTopic('tropic');
    printLog('Unsubscribed from topic tropic');
  }

  void _handleForegroundMessage(RemoteMessage message) {
    _showNotificationDialog(message);
  }

  void _handleMessageOpenedApp(RemoteMessage message) {
    _showNotificationDialog(message);
  }

  void _handleInitialMessage(RemoteMessage message) {
    _showNotificationDialog(message);
  }

  void _showNotificationDialog(RemoteMessage message) {
    final notification = message.notification;
    final data = message.data;

    if (notification != null) {
      Get.dialog(
        AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Get.theme.primaryColor, width: 2),
          ),
          title: Row(
            children: [
              Icon(Icons.notifications, color: Get.theme.primaryColor),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  notification.title ?? 'New Notification',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Get.theme.primaryColor,
                  ),
                ),
              ),
            ],
          ),
          content: Container(
            constraints: const BoxConstraints(maxHeight: 300),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Linkify(
                      text: notification.body ?? '',
                      style: const TextStyle(fontSize: 16),
                      onOpen: (link) {
                        printLog('Link clicked: ${link.url}');
                        launchURL(link.url, false);
                      },
                    ),
                  ),
                  if (data.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    const Text(
                      'Additional Data:',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...data.entries.map(
                      (e) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${e.key}: ',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Expanded(child: Text(e.value)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          actions: [
            Center(
              child: ElevatedButton(
                onPressed: () => Get.back(closeOverlays: true, canPop: true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Get.theme.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Close'),
              ),
            ),
          ],
          actionsPadding: const EdgeInsets.only(bottom: 16),
        ),
        barrierDismissible: false,
      );
    }
  }
}

/*
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  Future<void> initialize() async {
    // Request permission
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // Handle notification clicks when app is in background or terminated
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);

    // Check for initial message (app opened from terminated state)
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleInitialMessage(initialMessage);
    }
  }

  void _handleForegroundMessage(RemoteMessage message) {
    _showNotificationDialog(message);
  }

  void _handleMessageOpenedApp(RemoteMessage message) {
    _showNotificationDialog(message);
  }

  void _handleInitialMessage(RemoteMessage message) {
    _showNotificationDialog(message);
  }

void _showNotificationDialog(RemoteMessage message) {
    final notification = message.notification;
    final data = message.data;

    if (notification != null) {
      Get.dialog(
        AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Get.theme.primaryColor, width: 2),
          ),
          title: Row(
            children: [
              Icon(Icons.notifications, color: Get.theme.primaryColor),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  notification.title ?? 'New Notification',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Get.theme.primaryColor,
                  ),
                ),
              ),
            ],
          ),
          content: Container(
            constraints: const BoxConstraints(maxHeight: 300),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      notification.body ?? 'You have a new notification',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  if (data.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    const Text(
                      'Additional Data:',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...data.entries.map((e) => Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${e.key}: ',
                                style: const TextStyle(fontWeight: FontWeight.w500),
                              ),
                              Expanded(child: Text(e.value)),
                            ],
                          ),
                        )),
                  ],
                ],
              ),
            ),
          ),
          actions: [
            Center(
              child: ElevatedButton.icon(
                onPressed: () => Get.back(closeOverlays: true, canPop: true),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Back'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Get.theme.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
          actionsPadding: const EdgeInsets.only(bottom: 16),
        ),
        barrierDismissible: false,
      );
    }
  }}*/
