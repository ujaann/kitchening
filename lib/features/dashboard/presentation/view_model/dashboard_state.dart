part of 'dashboard_cubit.dart';

class DashboardState extends Equatable {
  final int selectedIndex;
  final List<Widget> views;

  const DashboardState({
    required this.selectedIndex,
    required this.views,
  });

  DashboardState.initial()
      : selectedIndex = 0,
        views = [
          const HomeView(),
          const LibraryView(),
          const ProfileView(),
          const SettingsView(),
        ];

  DashboardState copyWith({
    int? selectedIndex,
    List<Widget>? views,
  }) {
    return DashboardState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      views: views ?? this.views,
    );
  }

  @override
  List<Object> get props => [selectedIndex, views];
}
