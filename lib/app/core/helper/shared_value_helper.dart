import 'package:shared_value/shared_value.dart';

final SharedValue<bool> isLoggedIn = SharedValue(
  value: false,
  key: "isLoggedIn",
);
final SharedValue<String> accessToken = SharedValue(
  value: "",
  key: "accessToken",
);

final SharedValue<String> userEmail = SharedValue(
  value: "",
  key: "userEmail",
);

final SharedValue<String> userPhone = SharedValue(
  value: "",
  key: "userPhone",
);
final SharedValue<String> userName = SharedValue(value: "", key: "userName");

final SharedValue<String> userId = SharedValue(value: "", key: "staffID");

final SharedValue<String> userRole = SharedValue(value: "", key: "userRole");

final SharedValue<bool> isManager = SharedValue(value: false, key: "isManager");
final SharedValue<bool> isSupervisor = SharedValue(
  value: false,
  key: "isSupervisor",
);
final SharedValue<bool> isOperator = SharedValue(
  value: false,
  key: "isOperator",
);

// Notification Settings
final SharedValue<bool> notificationsEnabled = SharedValue(
  value: true,
  key: "notificationsEnabled",
);

final SharedValue<bool> orderNotifications = SharedValue(
  value: true,
  key: "orderNotifications",
);

final SharedValue<bool> promotionalNotifications = SharedValue(
  value: true,
  key: "promotionalNotifications",
);

final SharedValue<bool> deliveryNotifications = SharedValue(
  value: true,
  key: "deliveryNotifications",
);

final SharedValue<bool> newArrivalsNotifications = SharedValue(
  value: true,
  key: "newArrivalsNotifications",
);

