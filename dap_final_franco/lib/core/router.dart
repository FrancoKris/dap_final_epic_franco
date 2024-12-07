import 'package:dap_final_franco/screens/home_screen.dart';
import 'package:dap_final_franco/screens/login_screen.dart';
import 'package:dap_final_franco/screens/details_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:dap_final_franco/screens/register_screen.dart';

final appRouter = GoRouter(initialLocation: '/login', routes: [
  GoRoute(
    name: LoginScreen.name,
    path: '/login',
    builder: (context, state) => const LoginScreen(),
  ),
  GoRoute(
    name: RegisterScreen.name,
    path: '/register',
    builder: (context, state) => const RegisterScreen(),
  ),
  GoRoute(
    name: HomeScreen.name,
    path: '/home',
    builder: (context, state) => const HomeScreen(),
  ),
  GoRoute(
    name: DetailScreen.name,
    path: '/detalles',
    builder: (context, state) => DetailScreen(),
  ),
]);
