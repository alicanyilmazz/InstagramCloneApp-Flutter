import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/constant/enums/bottom_navbar_enum.dart';

part 'bottom_nav_bar_state.dart';

class BottomNavBarCubit extends Cubit<BottomNavBarState> {
  BottomNavBarCubit() : super(BottomNavBarState(selectedItem: BottomNavItem.feed));

  void updateSelectedItem(BottomNavItem item) {
    if (item != state.selectedItem) {
      emit(BottomNavBarState(selectedItem: item));
    }
  }
}
