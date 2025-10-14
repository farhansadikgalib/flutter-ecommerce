import 'package:ousadbazar/app/core/base/base_controller.dart';
import 'package:ousadbazar/app/core/helper/shared_value_helper.dart';

class ProfileController extends BaseController {
  // Toggle main notification setting
  void toggleNotifications(bool value) {
    notificationsEnabled.$ = value;
    notificationsEnabled.save();

    // If turning off, disable all notification types
    if (!value) {
      orderNotifications.$ = false;
      orderNotifications.save();
      promotionalNotifications.$ = false;
      promotionalNotifications.save();
      deliveryNotifications.$ = false;
      deliveryNotifications.save();
      newArrivalsNotifications.$ = false;
      newArrivalsNotifications.save();
    }
    update();
  }

  // Toggle order notifications
  void toggleOrderNotifications(bool value) {
    orderNotifications.$ = value;
    orderNotifications.save();
    _checkAndUpdateMainSwitch();
    update();
  }

  // Toggle promotional notifications
  void togglePromotionalNotifications(bool value) {
    promotionalNotifications.$ = value;
    promotionalNotifications.save();
    _checkAndUpdateMainSwitch();
    update();
  }

  // Toggle delivery notifications
  void toggleDeliveryNotifications(bool value) {
    deliveryNotifications.$ = value;
    deliveryNotifications.save();
    _checkAndUpdateMainSwitch();
    update();
  }

  // Toggle new arrivals notifications
  void toggleNewArrivalsNotifications(bool value) {
    newArrivalsNotifications.$ = value;
    newArrivalsNotifications.save();
    _checkAndUpdateMainSwitch();
    update();
  }

  // Check if any notification type is enabled and update main switch accordingly
  void _checkAndUpdateMainSwitch() {
    bool anyEnabled = orderNotifications.$ ||
        promotionalNotifications.$ ||
        deliveryNotifications.$ ||
        newArrivalsNotifications.$;

    if (anyEnabled && !notificationsEnabled.$) {
      notificationsEnabled.$ = true;
      notificationsEnabled.save();
    } else if (!anyEnabled && notificationsEnabled.$) {
      notificationsEnabled.$ = false;
      notificationsEnabled.save();
    }
  }
}
