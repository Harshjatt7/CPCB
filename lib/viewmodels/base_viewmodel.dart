import 'package:flutter/material.dart';
import '../constants/enums/state_enums.dart';

class BaseViewModel with ChangeNotifier {
  ViewState _state = ViewState.idle;

  ViewState get state => _state;

  set state(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  set stateWithoutUpdate(ViewState viewState) {
    _state = viewState;
  }

  void updateUI() {
    notifyListeners();
  }
}
