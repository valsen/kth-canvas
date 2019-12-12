import 'package:equatable/equatable.dart';

import '../../data/models/app_tab.dart';

abstract class TabEvent extends Equatable {
  const TabEvent();
}

class UpdateTab extends TabEvent {
  final AppTab tab;

  const UpdateTab(this.tab);

  @override
  List<Object> get props => [tab];

  @override
  String toString() {
    return 'UpdateTab { tab: $tab }';
  }
}


