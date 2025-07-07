import 'package:flutter/material.dart';
import 'package:jezt_intern_task/models/dashboard_items.dart';
import 'package:jezt_intern_task/service/api_services.dart';

class DashboardProvider extends ChangeNotifier {
  DashboardItem? dashboardItem;
  bool isLoading = false;
  String? error;

  Future<void> loadDashboard(String token) async {
    isLoading = true;
    error = null;
    notifyListeners();

    final result = await ApiService.fetchDashboard(token);
    if (result != null) {
      dashboardItem = DashboardItem.fromJson(result);
    } else {
      error = "Failed to load dashboard data.";
    }
    isLoading = false;
    notifyListeners();
  }
}
