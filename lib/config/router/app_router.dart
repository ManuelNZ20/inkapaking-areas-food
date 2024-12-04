import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/core.dart';
import '../../features/auth/presentation/providers/providers.dart';
import '../../features/auth/presentation/screens/screens.dart';
import '../../features/config/presentation/screens/screens.dart';
import 'auth_router_notifier.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final goRouterNotifier = ref.watch(goRouterProvider);
  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: goRouterNotifier,
    routes: [
      /// Splash screen para verificar el estado de autenticación
      /// y redirigir al usuario a la pantalla correcta.
      GoRoute(
        path: '/splash',
        name: CheckAuthStatusScreen.routeName,
        builder: (context, state) {
          return const CheckAuthStatusScreen();
        },
      ),

      /// Rutas de autenticación
      GoRoute(
        path: '/login',
        name: LoginScreen.routeName,
        builder: (context, state) {
          return const LoginScreen();
        },
        routes: [
          GoRoute(
            path: 'recover_password',
            name: RecoverPasswordScreen.routeName,
            builder: (context, state) {
              return const RecoverPasswordScreen();
            },
          ),
        ],
      ),
      GoRoute(
        path: '/register',
        name: RegisterScreen.routeName,
        builder: (context, state) {
          return const RegisterScreen();
        },
        routes: [
          GoRoute(
            name: ConfirmRegisterEmailScreen.routeName,
            path: 'confirm_register_email',
            builder: (context, state) {
              return const ConfirmRegisterEmailScreen();
            },
          ),
        ],
      ),
      GoRoute(
        path: '/home',
        name: HomeScreen.routeName,
        builder: (context, state) {
          return const HomeScreen();
        },
        routes: [
          GoRoute(
            path: 'config_profile',
            name: ConfigProfileScreen.routeName,
            builder: (context, state) {
              return const ConfigProfileScreen();
            },
          ),
        ],
      ),
      GoRoute(
        path: '/not_connection',
        name: NotConnectionScreen.routeName,
        builder: (context, state) {
          return const NotConnectionScreen();
        },
      ),
    ],
    redirect: (context, state) async {
      // Presenta la ruta en la que se encuentra el usuario
      final isGoingTo = state.matchedLocation;
      final authStatus = goRouterNotifier.authStatus;
      final keyValue = ref.read(keyValueStorageProvider);
      print(isGoingTo);
      print(authStatus);
      if (/* isGoingTo == '/splash' && */ authStatus == AuthStatus.offline) {
        return '/not_connection';
      }
      if (isGoingTo == '/splash' && authStatus == AuthStatus.checking) {
        return null;
      }
      if (authStatus == AuthStatus.unauthenticated) {
        if (isGoingTo == '/login' ||
            isGoingTo == '/register' ||
            isGoingTo == '/login/recover_password') {
          return null;
        }
        // final isOnBoarding =
        //     await keyValue.getValue<bool>('onBoarding') ?? false;
        // if (!isOnBoarding) {
        //   return '/onboarding';
        // }
        return '/login';
      }
      if (authStatus == AuthStatus.authenticated) {
        if (isGoingTo == '/login' ||
            isGoingTo == '/splash' ||
            isGoingTo == '/not_connection') {
          return '/home';
        }
      }
      return null;
    },
  );
});
