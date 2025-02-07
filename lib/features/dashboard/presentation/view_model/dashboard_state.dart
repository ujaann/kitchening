part of 'dashboard_cubit.dart';

class DashboardState extends Equatable {
  final int selectedIndex;
  final List<Widget> views = const [
    HomeView(),
    LibraryView(),
    ProfileView(),
    SettingsView(),
  ];

  const DashboardState({
    required this.selectedIndex,
  });

  const DashboardState.initial() : selectedIndex = 0;

  DashboardState copyWith({
    int? selectedIndex,
  }) {
    return DashboardState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }

  @override
  List<Object> get props => [selectedIndex];
}
