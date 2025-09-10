import 'package:flutter/foundation.dart';
import '../models/activity.dart';

class ActivityProvider with ChangeNotifier {
  final List<Activity> _activities = [];
  bool _showOnlyAfter6PM = false;

  List<Activity> get activities {
    if (_showOnlyAfter6PM) {
      return _activities.where((activity) => activity.isAfter6PM).toList();
    }
    return List.unmodifiable(_activities);
  }

  List<Activity> get allActivities => List.unmodifiable(_activities);

  bool get showOnlyAfter6PM => _showOnlyAfter6PM;

  int get totalCount => _activities.length;
  int get filteredCount => activities.length;

  void addActivity(Activity activity) {
    _activities.add(activity);
    // Sort activities by time
    _activities.sort((a, b) => a.timeAsDateTime.compareTo(b.timeAsDateTime));
    notifyListeners();
  }

  void removeActivity(String id) {
    _activities.removeWhere((activity) => activity.id == id);
    notifyListeners();
  }

  void updateActivity(Activity updatedActivity) {
    final index = _activities.indexWhere((activity) => activity.id == updatedActivity.id);
    if (index != -1) {
      _activities[index] = updatedActivity;
      // Sort activities by time after update
      _activities.sort((a, b) => a.timeAsDateTime.compareTo(b.timeAsDateTime));
      notifyListeners();
    }
  }

  void toggleFilter() {
    _showOnlyAfter6PM = !_showOnlyAfter6PM;
    notifyListeners();
  }

  void clearFilter() {
    _showOnlyAfter6PM = false;
    notifyListeners();
  }

  Activity? getActivityById(String id) {
    try {
      return _activities.firstWhere((activity) => activity.id == id);
    } catch (e) {
      return null;
    }
  }

  bool hasActivities() {
    return _activities.isNotEmpty;
  }

  bool hasFilteredActivities() {
    return activities.isNotEmpty;
  }
}