import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/activity_provider.dart';
import '../widgets/add_activity_dialog.dart';
import '../widgets/activity_item.dart';
import '../models/activity.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity Manager'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          Consumer<ActivityProvider>(
            builder: (context, provider, child) {
              return PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'filter') {
                    provider.toggleFilter();
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'filter',
                    child: Row(
                      children: [
                        Icon(
                          provider.showOnlyAfter6PM
                              ? Icons.filter_list_off
                              : Icons.filter_list,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          provider.showOnlyAfter6PM
                              ? 'Show All'
                              : 'Show After 18:00',
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: Consumer<ActivityProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              // Filter indicator
              if (provider.showOnlyAfter6PM)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  // ignore: deprecated_member_use
                  color: Colors.deepPurple.withOpacity(0.1),
                  child: Row(
                    children: [
                      const Icon(Icons.filter_list, size: 16),
                      const SizedBox(width: 8),
                      Text(
                        'Showing only activities after 18:00 (${provider.filteredCount}/${provider.totalCount})',
                        style: const TextStyle(fontSize: 14),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: provider.clearFilter,
                        child: const Text('Cancel'),
                      ),
                    ],
                  ),
                ),

              // Activity list
              Expanded(
                child: provider.hasFilteredActivities()
                    ? RefreshIndicator(
                        onRefresh: () async {
                          // Simple refresh animation
                          await Future.delayed(
                              const Duration(milliseconds: 500));
                        },
                        child: ListView.builder(
                          itemCount: provider.activities.length,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          itemBuilder: (context, index) {
                            final activity = provider.activities[index];
                            return ActivityItem(
                              activity: activity,
                              onDelete: () =>
                                  provider.removeActivity(activity.id),
                            );
                          },
                        ),
                      )
                    : _buildEmptyState(provider),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddActivityDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmptyState(ActivityProvider provider) {
    String message;
    IconData icon;

    if (!provider.hasActivities()) {
      message = 'No activities yet\nStart adding your first activity!';
      icon = Icons.event_available;
    } else {
      message =
          'No activities after 18:00\nTry turning off the filter to see all activities';
      icon = Icons.filter_list_off;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade600,
              height: 1.5,
            ),
          ),
          if (!provider.hasActivities()) ...[
            const SizedBox(height: 24),
            Consumer<ActivityProvider>(
              builder: (context, provider, child) {
                return ElevatedButton.icon(
                  onPressed: () => _showAddActivityDialog(context),
                  icon: const Icon(Icons.add),
                  label: const Text('Add Activity'),
                );
              },
            ),
          ],
        ],
      ),
    );
  }

  void _showAddActivityDialog(BuildContext context) async {
    final Activity? newActivity = await showDialog<Activity>(
      context: context,
      builder: (context) => const AddActivityDialog(),
    );

    if (newActivity != null) {
      if (context.mounted) {
        context.read<ActivityProvider>().addActivity(newActivity);

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Added activity "${newActivity.title}" successfully'),
            duration: const Duration(seconds: 2),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                context.read<ActivityProvider>().removeActivity(newActivity.id);
              },
            ),
          ),
        );
      }
    }
  }
}
