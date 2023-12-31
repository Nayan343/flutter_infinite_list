import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/features/main/presentation/pages/posts_page.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppRoutes {
  static Route<dynamic> onGenerateRoutes(RouteSettings settings) {
    debugPrint("${settings.name}");
    switch (settings.name) {
      case PostsPage.route:
        return _materialRoute(const PostsPage());
      default:
        return _materialRoute(const SizedBox.shrink());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
