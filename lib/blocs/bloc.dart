import 'package:rxdart/subjects.dart';

class Bloc {
  static Bloc? _bloc;

  static Bloc? getInstance() {
    if (_bloc == null) {
      _bloc = Bloc();
    }
    return _bloc;
  }

  final controller = BehaviorSubject<int>();
  Stream<int> selectedStream() => controller.stream;
  int _selectedTab = 0;

  void selectTab(int val) {
    // if (val != _selectedTab) {
    print(val);
    _selectedTab = val;
    controller.sink.add(_selectedTab);
    // }
  }

  dispose() {
    controller.close();
  }
}
