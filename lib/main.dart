import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_ios/google_maps_flutter_ios.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'core/theme/app_theme.dart';
import 'core/routing/app_router.dart';
import 'core/config/api_keys.dart';

// Conditional import for web-specific initialization
import 'main_web.dart' if (dart.library.io) 'main_stub.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Google Maps for each platform
  if (kIsWeb) {
    // Web: Inject Maps JavaScript API with key from ApiKeys
    initializeGoogleMapsForWeb();
  } else {
    final GoogleMapsFlutterPlatform mapsImplementation =
        GoogleMapsFlutterPlatform.instance;

    if (mapsImplementation is GoogleMapsFlutterAndroid) {
      // Android: Uses AndroidManifest.xml (key injected from .env via build.gradle)
      mapsImplementation.useAndroidViewSurface = true;
    } else if (mapsImplementation is GoogleMapsFlutterIOS) {
      // iOS: Uses AppDelegate.swift (key from Config.swift, auto-generated from .env)
    }
  }

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);

    return MaterialApp.router(
      title: 'ChargeSpot - EV Charging',
      debugShowCheckedModeBanner: false,

      // Material Theme (Android)
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,

      // Router Configuration
      routerConfig: router,

      // Locale Configuration
      locale: const Locale('en', 'IN'),
      supportedLocales: const [
        Locale('en', 'IN'),
      ],

      // Builder for adaptive UI
      builder: (context, child) {
        // Wrap with Cupertino theme for iOS-specific widgets
        return CupertinoTheme(
          data: AppTheme.cupertinoTheme,
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
