import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/dashboard_provider.dart';
import 'login_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    final token = Provider.of<AuthProvider>(context, listen: false).token!;
    Provider.of<DashboardProvider>(context, listen: false).loadDashboard(token);
  }

  @override
  Widget build(BuildContext context) {
    final dashboardProvider = Provider.of<DashboardProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authProvider.logout();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: dashboardProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : dashboardProvider.error != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 8),
                  Text(
                    dashboardProvider.error!,
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () {
                      final token = authProvider.token!;
                      dashboardProvider.loadDashboard(token);
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            )
          : dashboardProvider.dashboardItem == null
          ? const Center(child: Text("No data found"))
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildStatCard(
                  icon: Icons.business,
                  title: 'Company Name',
                  value: dashboardProvider.dashboardItem!.companyName,
                ),
                _buildStatCard(
                  icon: Icons.people,
                  title: 'Employee Count',
                  value: dashboardProvider.dashboardItem!.employeeCount
                      .toString(),
                ),
                _buildStatCard(
                  icon: Icons.videocam,
                  title: 'Camera Count',
                  value: dashboardProvider.dashboardItem!.cameraCount
                      .toString(),
                ),
                _buildStatCard(
                  icon: Icons.bar_chart,
                  title: 'Attendance (%)',
                  value: dashboardProvider.dashboardItem!.attendancePercentage
                      .toString(),
                ),
                _buildStatCard(
                  icon: Icons.calendar_today,
                  title: 'Today\'s Date',
                  value: dashboardProvider.dashboardItem!.todayDate,
                ),
                _buildStatCard(
                  icon: Icons.image,
                  title: 'Total Images Processed',
                  value: dashboardProvider.dashboardItem!.totalImagesProcessed
                      .toString(),
                ),
                // you can keep adding more fields here
              ],
            ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blueAccent,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
