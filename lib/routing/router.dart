import 'package:go_router/go_router.dart';
import 'package:twitter_clone/features/authentication/presentation/create_account/create_account_view.dart';
import 'package:twitter_clone/features/authentication/presentation/welcome/welcome_view.dart';
import 'package:twitter_clone/features/home/presentation/home_view.dart';

enum AppRoute {
  home,
  welcome,
  createAccount,
}

final goRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: false,
  routes: [
    GoRoute(
      path: '/',
      name: AppRoute.home.name,
      builder: (context, state) => const HomeView(),
      redirect: (context, GoRouterState state) {
        bool isAuthenticated = false;
        if (!isAuthenticated) {
          return state.namedLocation(AppRoute.welcome.name);
        }

        // ignore: dead_code
        return null;
      },
      // routes: [],
    ),
    GoRoute(
      path: '/welcome',
      name: AppRoute.welcome.name,
      builder: (context, state) => const WelcomeView(),
      routes: [
        GoRoute(
          path: 'createAccount',
          name: AppRoute.createAccount.name,
          builder: (context, state) => const CreateAcoountView(),
        ),
      ],
    ),
  ],
);
