import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'page_state.dart';

abstract class BaseController extends GetxController {
  // final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  final isAuthenticated = false.obs;
  final isTopBgRequired = false.obs;
  final logger = Logger();
  final _pageSateController = PageState.defaultState.obs;
  // final  connectionController = Get.find<ConnectionManagerController>().obs;
  PageState get pageState => _pageSateController.value;

  PageState updatePageState(PageState state) => _pageSateController(state);

  PageState resetPageState() => _pageSateController(PageState.defaultState);

  dynamic showLoading() => updatePageState(PageState.loading);

  dynamic hideLoading() => resetPageState();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  // // ----------drawer control -- start----------
  //
  //  openNavDrawer(){
  //     globalKey.currentState!.openDrawer();
  //  }
  //
  //  closeNavDrawer(){
  //    globalKey.currentState!.closeDrawer();
  //  }
  //
  // // ----------drawer control -- end----------
}
