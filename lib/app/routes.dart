import 'package:go_router/go_router.dart';
import 'package:pollux/app/route_name.dart';
import 'package:pollux/src/core/base/view/base_view.dart';
import 'package:pollux/src/feature/auth/login/view/login_view.dart';
import 'package:pollux/src/feature/auth/otp/view/otp_view.dart';

class Routes {
  late final GoRouter router = GoRouter(
    initialLocation: RouteName.login,
    routes: [
      GoRoute(
        path: RouteName.base,
        name: RouteName.base,
        builder: (context, state) => const BaseView(),
      ),
      GoRoute(
        path: RouteName.login,
        name: RouteName.login,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: RouteName.otp,
        name: RouteName.otp,
        builder: (context, state) => const OtpView(),
      ),
    ],
  );
}
