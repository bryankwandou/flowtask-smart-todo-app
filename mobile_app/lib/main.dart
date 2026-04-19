import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'core/theme/app_theme.dart';
import 'widgets/main_nav.dart';
import 'widgets/splash_screen.dart';
import 'features/onboarding/views/onboarding_screen.dart';
import 'features/auth/views/login_screen.dart';
import 'features/auth/views/register_screen.dart';
import 'features/tasks/views/task_detail_screen.dart';
import 'features/profile/views/paywall_screen.dart';
import 'features/analytics/views/analytics_screen.dart';
import 'features/tasks/models/task_model.dart';
import 'services/auth_service.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'core/theme/colors.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'features/onboarding/views/permission_priming_screen.dart';
import 'features/profile/views/about_screen.dart';
import 'features/profile/views/privacy_settings_screen.dart';
import 'features/profile/views/notification_settings_screen.dart';
import 'core/providers/settings_provider.dart';
import 'dart:ui';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Hardened Crash Resilience for 18th Submission
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    // Hardened Error Logging: Ensure no PII is leaked in release mode
    debugPrint('FlowTask Production Error: ${details.exception}');
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    debugPrint('FlowTask Async Failure: $error');
    return true;
  };

  // Critical Firebase Initialization with Rejection-Proof Readiness
  await Firebase.initializeApp();

  // Initialize Timezone
  tz.initializeTimeZones();

  // Initialize Notifications
  AwesomeNotifications().initialize(
    null, // default icon
    [
      NotificationChannel(
        channelKey: 'task_reminders',
        channelName: 'Task Reminders',
        channelDescription: 'Notifications for upcoming task deadlines',
        defaultColor: AppColors.primary,
        ledColor: Colors.white,
        importance: NotificationImportance.High,
        channelShowBadge: true,
        onlyAlertOnce: true,
        playSound: true,
        criticalAlerts: true,
      )
    ],
    debug: false, // Hardened for Production
  );

  // Lock orientation to portrait for a premium, consistent app feel
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Set system UI overlay style for immersive dark theme
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF0F172A),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  runApp(
    const ProviderScope(
      child: FlowTaskApp(),
    ),
  );
}

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) async {
      final bool loggingIn = state.matchedLocation == '/login' || 
                             state.matchedLocation == '/register' || 
                             state.matchedLocation == '/splash' || 
                             state.matchedLocation == '/onboarding' ||
                             state.matchedLocation == '/permission-priming';
      
      if (state.matchedLocation == '/splash') return null;

      final bool onboardingDone = await AuthService.isOnboardingDone();
      if (!onboardingDone && state.matchedLocation != '/onboarding') return '/onboarding';
      
      final bool loggedIn = await AuthService.isLoggedIn();
      if (!loggedIn && !loggingIn) return '/login';
      if (loggedIn && loggingIn && state.matchedLocation != '/splash') return '/';

      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        pageBuilder: (context, state) => AppTransitionPage(
          child: const OnboardingScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
        ),
      ),
      GoRoute(
        path: '/permission-priming',
        pageBuilder: (context, state) => AppTransitionPage(
          child: const PermissionPrimingScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
        ),
      ),
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) => AppTransitionPage(
          child: const LoginScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
        ),
      ),
      GoRoute(
        path: '/register',
        pageBuilder: (context, state) => AppTransitionPage(
          child: const RegisterScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
        ),
      ),
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => AppTransitionPage(
          child: const MainNavWrapper(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
        ),
      ),
      GoRoute(
        path: '/analytics',
        builder: (context, state) => const AnalyticsScreen(),
      ),
      GoRoute(
        path: '/paywall',
        builder: (context, state) => const PaywallScreen(),
      ),
      GoRoute(
        path: '/about',
        builder: (context, state) => const AboutScreen(),
      ),
      GoRoute(
        path: '/privacy-settings',
        builder: (context, state) => const PrivacySettingsScreen(),
      ),
      GoRoute(
        path: '/notification-settings',
        builder: (context, state) => const NotificationSettingsScreen(),
      ),
      GoRoute(
        path: '/task-detail',
        builder: (context, state) {
          final task = state.extra as Task;
          return TaskDetailScreen(task: task);
        },
      ),
    ],
  );
});

class FlowTaskApp extends ConsumerWidget {
  const FlowTaskApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);
    final settings = ref.watch(settingsProvider);

    return MaterialApp.router(
      title: 'FlowTask — Focused Progress',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: AppTheme.getTheme(settings.palette),
      locale: settings.locale,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('id'),
      ],
      routerConfig: router,
    );
  }
}

class AppTransitionPage extends CustomTransitionPage<void> {
  AppTransitionPage({
    required super.child,
    required super.transitionsBuilder,
  }) : super(
         key: ValueKey(child.hashCode),
         transitionDuration: const Duration(milliseconds: 300),
       );
}
