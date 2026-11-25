import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'utils/app_state.dart';
import 'screens/dashboard_screen.dart';
import 'screens/graph_visualization_screen.dart';
import 'screens/alerts_screen.dart';
import 'screens/transactions_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
        title: 'Fraud Ring Detection',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MainScreen(),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const GraphVisualizationScreen(),
    const AlertsScreen(),
    const TransactionsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_tree),
            label: 'Graph',
          ),
          NavigationDestination(
            icon: Icon(Icons.warning),
            label: 'Alerts',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long),
            label: 'Transactions',
          ),
        ],
      ),
    );
  }
}
