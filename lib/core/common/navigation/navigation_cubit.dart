import 'package:bloc/bloc.dart';
import 'package:dental_hero/core/common/navigation/navbar_item.dart';
import 'package:equatable/equatable.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationState(NavbarItem.home, 0));

  void getNavBarItem(NavbarItem navbarItem) {
    switch (navbarItem) {
      case NavbarItem.home:
        emit(NavigationState(NavbarItem.home, 0));
        break;
      case NavbarItem.scanAr:
        emit(NavigationState(NavbarItem.scanAr, 1));
        break;
      case NavbarItem.stats:
        emit(NavigationState(NavbarItem.stats, 2));
        break;
    }
  }
}
