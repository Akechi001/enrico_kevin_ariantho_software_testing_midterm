part of 'pages.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthViewModel>().user;
    return Scaffold(
      appBar: AppBar(title: Text('Home Screen')),
      body: Center(
        child: Text('Welcome, ${user?.username ?? 'User'}!'),
      ),
    );
  }
}
