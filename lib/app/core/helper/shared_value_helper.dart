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
  key: "designation",
);
final SharedValue<String> userName = SharedValue(
  value: "",
  key: "userName",
);

final SharedValue<String> userId = SharedValue(
  value: "",
  key: "staffID",
);

final SharedValue<String> userRole = SharedValue(
  value: "",
  key: "userRole",
);

final SharedValue<bool> isManager = SharedValue(
  value: false,
  key: "isManager",
);
final SharedValue<bool> isSupervisor = SharedValue(
  value: false,
  key: "isSupervisor",
);
final SharedValue<bool> isOperator = SharedValue(
  value: false,
  key: "isOperator",
);
