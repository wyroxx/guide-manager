import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:guide_manager/features/applications/presentation/applications_page.dart';
import 'package:guide_manager/features/auth/presentation/login_page.dart';
import 'package:guide_manager/features/auth/presentation/register_page.dart';
import 'package:guide_manager/features/excursions/presentation/excursions_page.dart';
import 'package:guide_manager/features/profile/presentation/profile_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoute.login.path,
    routes: [
      GoRoute(
        path: AppRoute.login.path,
        name: AppRoute.login.name,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoute.register.path,
        name: AppRoute.register.name,
        builder: (context, state) => const RegisterPage(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoute.excursions.path,
                name: AppRoute.excursions.name,
                builder: (context, state) => const ExcursionsPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoute.applications.path,
                name: AppRoute.applications.name,
                builder: (context, state) => const ApplicationsPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoute.profile.path,
                name: AppRoute.profile.name,
                builder: (context, state) => const ProfilePage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});

enum AppRoute {
  login('/login'),
  register('/register'),
  excursions('/excursions'),
  applications('/applications'),
  profile('/profile');

  const AppRoute(this.path);

  final String path;
}

class AppShell extends StatelessWidget {
  const AppShell({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: _onDestinationSelected,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Excursions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Applications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  void _onDestinationSelected(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
