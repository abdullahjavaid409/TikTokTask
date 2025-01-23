import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tiktask/locator.dart';
import 'package:tiktask/screens/dashboard_screen.dart';
import 'package:tiktask/screens/home_screen.dart';
import 'package:tiktask/services/connectivity_service.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
   ConnectivityService.instance.initialize();
  await DependencyInjectionEnvironment.setup();
  runApp(const TicKTocDriver());
}

class TicKTocDriver extends StatelessWidget {
  const TicKTocDriver({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DashBoardScreen(),
    );
  }
}

// class ConnectivityExample extends StatefulWidget {
//   const ConnectivityExample({Key? key}) : super(key: key);
//
//   @override
//   State<ConnectivityExample> createState() => _ConnectivityExampleState();
// }
//
// class _ConnectivityExampleState extends State<ConnectivityExample> {
//   late StreamSubscription<List<ConnectivityResult>> _subscription;
//   List<ConnectivityResult> _currentStatus = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _subscription = ConnectivityService.instance.connectivityStream.listen((results) {
//       setState(() {
//         _currentStatus = results;
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     _subscription.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final connectivityStatus = _currentStatus.map((e) => e.toString()).join(', ');
//
//     return Scaffold(
//       appBar: AppBar(title: const Text('Connectivity Example')),
//       body: Center(
//         child: Text(
//           'Current Connectivity: $connectivityStatus',
//           style: const TextStyle(fontSize: 18),
//           textAlign: TextAlign.center,
//         ),
//       ),
//     );
//   }
// }
