part of 'dashboard_cubit.dart';

class DashboardState extends Equatable {
  final int selectedIndex;
  final List<Widget> views = [
    const HomeView(),
    const LibraryView(),
    MultiBlocProvider(
      providers: [
        BlocProvider<RecipeBloc>.value(
          value: getIt(),
        ),
        BlocProvider<SingleRecipeCubit>.value(
          value: getIt(),
        ),
      ],
      child: const CreateRecipeScreenView(),
    ),
    const ProfileView(),
    const SettingsView(),
  ];

  DashboardState({
    required this.selectedIndex,
  });

  DashboardState.initial() : selectedIndex = 0;

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
