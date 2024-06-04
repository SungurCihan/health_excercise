import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_excercise/feature/bottom_navigation_bar/viewmodel/bottom_navigation_bar_view_model.dart';
import 'package:health_excercise/feature/bottom_navigation_bar/viewmodel/state/bottom_navigation_bar_state.dart';

/// BottomNavigationBarView
@RoutePage()
class BottomNavigationBarView extends StatelessWidget {
  /// BottomNavigationBarView initialization
  BottomNavigationBarView({super.key});

  /// BottomNavigationBarViewModel
  final BottomNavigationBarViewModel viewModel = BottomNavigationBarViewModel();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: Stack(
        children: [
          const SizedBox.expand(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xffF8F8FC),
                    Color(0xffF1F1F9),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          BlocConsumer<BottomNavigationBarViewModel, BottomNavigationBarState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Scaffold(
                body: Center(
                  child: viewModel.pages.elementAt(state.currentPage),
                ),
                bottomNavigationBar: Theme(
                  data: ThemeData(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                  child: BottomNavigationBar(
                    selectedFontSize: 12,
                    currentIndex: state.currentPage,
                    selectedItemColor: Colors.pink,
                    backgroundColor: Colors.white,
                    showUnselectedLabels: true,
                    showSelectedLabels: true,
                    type: BottomNavigationBarType.fixed,
                    onTap: _onItemTapped,
                    items: const <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: 'Ana Sayfa',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.access_alarm),
                        label: 'Aktivite',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.calendar_month),
                        label: 'Takvim',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.person),
                        label: 'Profil',
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    viewModel.changePage(index);
  }
}
