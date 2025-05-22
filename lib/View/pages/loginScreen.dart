part of 'pages.dart';
// TODO: add more robust error notification
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<AuthViewModel>().isLoading;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Gap(100),
              Text("Selamat Datang!", style: TextStyle(fontSize: 32),),
              Text("Silahkan masuk untuk melanjutkan", style: TextStyle(fontSize: 12),),
              const Gap(100),
              Form(
                key: _formKey,
                child: OverflowBar(
                  overflowAlignment: OverflowBarAlignment.center,
                  alignment: MainAxisAlignment.start,
                  overflowSpacing: 10,
                  children: [
                    FormFieldWidget(
                      controller: _emailController,
                      labelText: "Email",
                      prefixIcon: Icons.email,
                      keyboardType: TextInputType.name,
                      autofillHints: const [AutofillHints.email],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    FormFieldWidget(
                      controller: _passwordController,
                      labelText: "Password",
                      prefixIcon: Icons.key,
                      isPassword: true,
                      autofillHints: const [AutofillHints.password],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) {
                        _submitForm();
                      },
                    ),
                    const Gap(0),
                    isLoading
                        ? CircularProgressIndicator()
                        : CustomButton(
                      text: "Masuk",
                      onPressed: _submitForm,
                    ),
                  ],
                ),
              ),
              const Gap(14),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Belum punya akun?",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                  GestureDetector(
                    onTap: () {
                    },
                    child: Text(
                      ' Daftar Disini',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();

      final authViewModel = context.read<AuthViewModel>();

      final error = await authViewModel.login(email, password);
      if (error == null) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
      }
    }
  }


}
