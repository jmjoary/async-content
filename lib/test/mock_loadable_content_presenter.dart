import 'package:extension_dart_tools/extension_tools.dart';
import 'package:async_content/src/loadable_content_viewmodel.dart';

class MockLoadableContentPresenter extends ILoadableContentPresenter
    with MockMixin {
  @override
  void startedLoading() {
    addCalledFunction(named: "startedLoading");
  }

  @override
  void onError(dynamic error) {
    addCalledFunction(named: "onError");
    addReceivedObject(error, name: "error");
  }

  @override
  void clearErrors() {
    addCalledFunction(named: "clearError");
  }

  @override
  void finishedLoading() {
    addCalledFunction(named: "finishedLoading");
  }
}
