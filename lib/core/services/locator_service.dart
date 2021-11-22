import 'package:get_it/get_it.dart';
import 'package:tcourier/core/services/push_notifications_service.dart';

GetIt locator = GetIt.instance;

void setUpLocatorServices() {
  locator.registerLazySingleton(() => PushNotificationService());
  // locator.registerLazySingleton(() => NavigationService());
  // DeepLinkService _deepLinkService = DeepLinkService();
  // locator.registerSingleton<DeepLinkService>(_deepLinkService);
}
