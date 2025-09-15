import 'package:easy_debounce/easy_debounce.dart';

class DebounceHelper {
  static const String searchTextTag = "support_search_debounce";
  static const String buttonTag = "booking_search_debounce";

  void debounce({tag, onMethod, time = 500}) {
    EasyDebounce.debounce(tag, Duration(milliseconds: time), () => onMethod());
  }

  void killDebounce({tag}) {
    EasyDebounce.cancel(tag);
  }

  void killAllDebounce() {
    EasyDebounce.cancelAll();
  }
}
