// import 'package:memories/main.dart';
// import 'package:memories/features/settings/settings_page.dart';

// import 'dashboard.dart';

// class App extends UI {
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       child:
//       //  settingsRM.isLocked()
//       // ? buildLockedScreen()
//       // :
//       SafeArea(child: buildMainScreen()),
//     );
//   }

//   Widget buildLockedScreen() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Text(
//             'Memories',
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 24),
//           TextFormField(
//             // initialValue: settingsRM.inputPassword(),
//             // onChanged: settingsRM.inputPassword,
//             decoration: const InputDecoration(
//               labelText: 'Password',
//               border: OutlineInputBorder(),
//               prefixIcon: Icon(Icons.lock),
//             ),
//             obscureText: true,
//           ),
//           const SizedBox(height: 16),
//           const CircularProgressIndicator(),
//         ],
//       ),
//     );
//   }

//   Widget buildMainScreen() {
//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           children: [
//             Icon(route().icon, size: 40),
//             const SizedBox(width: 8),
//             Text(route().name),
//           ],
//         ),
//       ),
//       body:
//           route().page, // Removed Expanded widget to fix ParentDataWidget issue
//       bottomNavigationBar: _NavigationBar(),
//     );
//   }

//   Widget _NavigationBar() {
//     return NavigationBar(
//       selectedIndex: Routes.values.indexOf(route()),
//       onDestinationSelected: (index) {
//         final selectedRoute = Routes.values[index];
//         if (selectedRoute != route()) {
//           route(selectedRoute);
//         }
//       },
//       destinations:
//           Routes.values.map((routeOption) {
//             return NavigationDestination(
//               icon: Icon(routeOption.icon),
//               label: routeOption.name,
//             );
//           }).toList(),
//     );
//   }
// }

// enum Routes {
//   dashboard(Icons.dashboard, 'Dashboard', const DashboardPage()),
//   // memories(Icons.memory, 'Memories', MemoriesUI()),
//   settings(Icons.settings, 'Settings', const SettingsPage());

//   const Routes(this.icon, this.name, this.page);
//   final IconData icon;
//   final String name;
//   final Widget page;
// }

// final routeRM = RM.inject(() => Routes.dashboard);

// Routes route([Routes? value]) {
//   if (value != null) {
//     routeRM.state = value;
//   }
//   return routeRM.state;
// }
