part of 'pages.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthViewModel>().user;
    return Scaffold(
      appBar: AppBar(title: Text('Home Screen')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              const Gap(20),
              Text('Welcome, ${user?.username ?? 'User'}!'),
              const Gap(20),
              CustomButton(text: "Logout", onPressed: (){Navigator.pushReplacementNamed(context, '/');})
            ],
          ),
        ),
      ),
    );
  }
}
