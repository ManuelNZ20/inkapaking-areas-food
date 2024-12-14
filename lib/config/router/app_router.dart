import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inkapaking/main.dart';
import '../../core/core.dart';
import '../../features/all_areas/presentation/screens/screens.dart';
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
    navigatorKey: navigatorKey,
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
            path: 'config_profile/:config_user_id',
            name: ConfigProfileScreen.routeName,
            builder: (context, state) {
              final userId = state.pathParameters['config_user_id'] ?? '0';
              return ConfigProfileScreen(
                userId: int.parse(userId),
              );
            },
          ),
          // Configuración de la aplicación
          GoRoute(
            path: 'orders_all_areas',
            name: OrdersAllAreasScreen.routeName,
            builder: (context, state) {
              return const OrdersAllAreasScreen();
            },
            routes: const [],
          ),
          // Notificaciones de registro
          GoRoute(
            path: 'notifications_register',
            name: NotificationsOfRegisterScreen.routeName,
            builder: (context, state) {
              return const NotificationsOfRegisterScreen();
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
                      path: 'assign_area/:assign_area_user_id',
                      name: AssignAreaScreen.routeName,
                      builder: (context, state) {
                        final userId =
                            state.pathParameters['assign_area_user_id'] ?? '0';
                        return AssignAreaScreen(
                          userId: int.parse(userId),
                        );
                      },
                    ),
                  ]),
            ],
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
                path: 'detail_user/:detail_user_id',
                name: DetailUserScreen.routeName,
                builder: (context, state) {
                  final userId = state.pathParameters['detail_user_id'] ?? '0';
                  return DetailUserScreen(
                    userUserId: int.parse(userId),
                  );
                },
              ),
            ],
          ),
          // Mi área
          GoRoute(
            path: 'my_area/:my_area_type_user_id',
            name: MyAreaScreen.routeName,
            builder: (context, state) {
              final userId =
                  state.pathParameters['my_area_type_user_id'] ?? '0';
              return MyAreaScreen(
                typeUserId: int.parse(userId),
              );
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
      // final keyValue = ref.read(keyValueStorageProvider);
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
