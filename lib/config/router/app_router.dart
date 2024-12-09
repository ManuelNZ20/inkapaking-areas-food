import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/core.dart';
import '../../features/auth/presentation/providers/providers.dart';
import '../../features/auth/presentation/screens/screens.dart';
import '../../features/config/presentation/screens/screens.dart';
import '../../features/rrhh/presentation/screens/screens.dart';
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
          // Configuración de perfil
          GoRoute(
            path: 'config_profile',
            name: ConfigProfileScreen.routeName,
            builder: (context, state) {
              return const ConfigProfileScreen();
            },
          ),
          // Configuración de la aplicación
          GoRoute(
            path: 'orders_all_areas',
            name: OrdersAllAreasScreen.routeName,
            builder: (context, state) {
              return const OrdersAllAreasScreen();
            },
            routes: [
              GoRoute(
                path: 'form_order_all_areas',
                name: FormOrderAllAreasScreen.routeName,
                builder: (context, state) {
                  return const FormOrderAllAreasScreen();
                },
              ),
            ],
          ),
          // Notificaciones de registro
          GoRoute(
            path: 'notifications_register',
            name: NotificationsOfRegisterScreen.routeName,
            builder: (context, state) {
              return const NotificationsOfRegisterScreen();
            },
          ),
          // Historial de notificaciones
          GoRoute(
            path: 'historial_notifications',
            name: HistorialNotificationsScreen.routeName,
            builder: (context, state) {
              return const HistorialNotificationsScreen();
            },
            routes: [
              GoRoute(
                  path: 'request_new_user/:request_user_id',
                  name: RequestNewUser.routeName,
                  builder: (context, state) {
                    final userId =
                        state.pathParameters['request_user_id'] ?? '0';
                    return RequestNewUser(
                      userId: int.parse(userId),
                    );
                  },
                  routes: [
                    GoRoute(
                      path: 'assign_area',
                      name: AssignAreaScreen.routeName,
                      builder: (context, state) {
                        return const AssignAreaScreen();
                      },
                    ),
                  ]),
            ],
          ),
          // Mi área
          GoRoute(
            path: 'my_area',
            name: AreaScreen.routeName,
            builder: (context, state) {
              return const AreaScreen();
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
      print('Redirecting from: $isGoingTo, AuthStatus: $authStatus');
      if (authStatus == AuthStatus.offline) {
        return '/not_connection';
      }
      if (isGoingTo == '/splash' && authStatus == AuthStatus.checking) {
        return null;
      }
      if (authStatus == AuthStatus.unauthenticated) {
        if (isGoingTo == '/login' ||
            isGoingTo == '/login/recover_password' ||
            isGoingTo == '/register' ||
            isGoingTo == '/register/confirm_register_email') {
          return null;
        }
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
