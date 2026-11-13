import 'package:flutter/material.dart';

void main() {
  runApp(const RevrseApp());
}

const Color revrseBlue = Color(0xFF1769E8);
const Color revrseNavy = Color(0xFF10234D);
const Color revrsePale = Color(0xFFF3F7FF);
const Color revrseBorder = Color(0xFFDCE6F8);

class RevrseApp extends StatelessWidget {
  const RevrseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'REVRSE',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: revrseBlue),
        fontFamily: 'Roboto',
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFFBFCFF),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 17,
          ),
          hintStyle: const TextStyle(color: Color(0xFF8290AA), fontSize: 14),
          prefixIconColor: revrseNavy,
          suffixIconColor: const Color(0xFF667A9E),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: revrseBorder),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: revrseBlue, width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.redAccent),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
          ),
        ),
      ),
      home: const LoginPage(),
    );
  }
}

class Brand extends StatelessWidget {
  final double size;
  final bool compact;

  const Brand({super.key, this.size = 35, this.compact = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size + 12,
          height: size + 12,
          decoration: BoxDecoration(
            color: revrseBlue.withValues(alpha: .09),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.all_inclusive_rounded,
            color: revrseBlue,
            size: size,
          ),
        ),
        const SizedBox(height: 7),
        Text(
          'REVRSE',
          style: TextStyle(
            fontSize: compact ? 23 : 29,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
            color: revrseNavy,
          ),
        ),
        if (!compact) ...[
          const SizedBox(height: 5),
          const Text(
            'Different Minds. Different Views.',
            style: TextStyle(color: revrseNavy, fontSize: 13),
            textAlign: TextAlign.center,
          ),
          const Text(
            'One Connection.',
            style: TextStyle(
              color: revrseBlue,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ],
    );
  }
}

class AuthBackground extends StatelessWidget {
  final Widget child;

  const AuthBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -95,
          left: -85,
          child: _blob(220, const Color(0xFFEAF2FF)),
        ),
        Positioned(
          bottom: -120,
          right: -85,
          child: _blob(250, const Color(0xFFEAF2FF)),
        ),
        SafeArea(child: child),
      ],
    );
  }

  Widget _blob(double size, Color color) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
  );
}

class AuthPageShell extends StatelessWidget {
  final Widget child;
  final bool showBack;
  final VoidCallback? onBack;

  const AuthPageShell({
    super.key,
    required this.child,
    this.showBack = false,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: Column(
          children: [
            if (showBack)
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: onBack ?? () => Navigator.maybePop(context),
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  color: revrseNavy,
                ),
              )
            else
              const SizedBox(height: 16),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 12, 24, 28),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 430),
                    child: child,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const PrimaryButton({super.key, required this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 53,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: revrseBlue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
        ),
        child: Text(label),
      ),
    );
  }
}

class AuthTextField extends StatefulWidget {
  final String hint;
  final IconData icon;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool password;
  final String? Function(String?)? validator;

  const AuthTextField({
    super.key,
    required this.hint,
    required this.icon,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.password = false,
    this.validator,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.password && obscure,
      validator: widget.validator,
      decoration: InputDecoration(
        hintText: widget.hint,
        prefixIcon: Icon(widget.icon, size: 20),
        suffixIcon: widget.password
            ? IconButton(
                onPressed: () => setState(() => obscure = !obscure),
                icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
              )
            : null,
      ),
    );
  }
}

String? requiredField(String? value) {
  if (value == null || value.trim().isEmpty) return 'This field is required';
  return null;
}

String? emailValidator(String? value) {
  if (value == null || value.trim().isEmpty) return 'Email is required';
  if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value.trim())) {
    return 'Enter a valid email address';
  }
  return null;
}

void showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final identity = TextEditingController();
  final password = TextEditingController();
  bool rememberMe = false;

  @override
  void dispose() {
    identity.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthPageShell(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Brand(),
            const SizedBox(height: 32),
            const Text(
              'Welcome back',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w800,
                color: revrseNavy,
              ),
            ),
            const SizedBox(height: 7),
            const Text(
              'Sign in and see the world from another view.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF71809B), fontSize: 13),
            ),
            const SizedBox(height: 25),
            AuthTextField(
              hint: 'Email or Username',
              icon: Icons.mail_outline_rounded,
              controller: identity,
              validator: requiredField,
            ),
            const SizedBox(height: 13),
            AuthTextField(
              hint: 'Password',
              icon: Icons.lock_outline_rounded,
              controller: password,
              password: true,
              validator: requiredField,
            ),
            const SizedBox(height: 3),
            Row(
              children: [
                Checkbox(
                  value: rememberMe,
                  activeColor: revrseBlue,
                  onChanged: (v) => setState(() => rememberMe = v ?? false),
                ),
                const Text('Remember me', style: TextStyle(fontSize: 12)),
                const Spacer(),
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ForgotPasswordPage(),
                    ),
                  ),
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            PrimaryButton(
              label: 'Sign In',
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  showMessage(
                    context,
                    'UI demo: connect login to your backend.',
                  );
                }
              },
            ),
            const SizedBox(height: 20),
            const _OrDivider(label: 'or continue with'),
            const SizedBox(height: 14),
            OutlinedButton.icon(
              onPressed: () =>
                  showMessage(context, 'Google sign-in is not connected yet.'),
              icon: const Icon(
                Icons.g_mobiledata_rounded,
                size: 28,
                color: revrseBlue,
              ),
              label: const Text('Continue with Google'),
              style: OutlinedButton.styleFrom(
                foregroundColor: revrseNavy,
                side: const BorderSide(color: revrseBorder),
                minimumSize: const Size.fromHeight(49),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Wrap(
              alignment: WrapAlignment.center,
              children: [
                const Text(
                  "Don't have an account? ",
                  style: TextStyle(fontSize: 13),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RegisterPage()),
                  ),
                  child: const Text(
                    'Create Account',
                    style: TextStyle(
                      color: revrseBlue,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirm = TextEditingController();
  bool agreed = false;

  @override
  void dispose() {
    name.dispose();
    username.dispose();
    email.dispose();
    password.dispose();
    confirm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthPageShell(
      showBack: true,
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Brand(size: 27, compact: true),
            const SizedBox(height: 22),
            const Text(
              'Create Account',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w800,
                color: revrseNavy,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Join our community and share your perspective!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF71809B), fontSize: 13),
            ),
            const SizedBox(height: 22),
            AuthTextField(
              hint: 'Full Name',
              icon: Icons.person_outline,
              controller: name,
              validator: requiredField,
            ),
            const SizedBox(height: 11),
            AuthTextField(
              hint: 'Username',
              icon: Icons.alternate_email,
              controller: username,
              validator: requiredField,
            ),
            const SizedBox(height: 11),
            AuthTextField(
              hint: 'Email Address',
              icon: Icons.mail_outline,
              controller: email,
              keyboardType: TextInputType.emailAddress,
              validator: emailValidator,
            ),
            const SizedBox(height: 11),
            AuthTextField(
              hint: 'Password',
              icon: Icons.lock_outline,
              controller: password,
              password: true,
              validator: (v) {
                if (v == null || v.length < 8)
                  return 'Use at least 8 characters';
                return null;
              },
            ),
            const SizedBox(height: 11),
            AuthTextField(
              hint: 'Confirm Password',
              icon: Icons.lock_outline,
              controller: confirm,
              password: true,
              validator: (v) {
                if (v != password.text) return 'Passwords do not match';
                return null;
              },
            ),
            const SizedBox(height: 7),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              value: agreed,
              activeColor: revrseBlue,
              onChanged: (v) => setState(() => agreed = v ?? false),
              title: const Text(
                'I agree to the Terms and Conditions',
                style: TextStyle(fontSize: 12),
              ),
            ),
            const SizedBox(height: 8),
            PrimaryButton(
              label: 'Create Account',
              onPressed: () {
                if (!agreed) {
                  showMessage(
                    context,
                    'Please agree to the Terms and Conditions.',
                  );
                  return;
                }
                if (formKey.currentState!.validate()) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => VerifyEmailPage(email: email.text.trim()),
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 17),
            const _OrDivider(label: 'or sign up with'),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () =>
                  showMessage(context, 'Google sign-up is not connected yet.'),
              icon: const Icon(
                Icons.g_mobiledata_rounded,
                color: revrseBlue,
                size: 27,
              ),
              label: const Text('Continue with Google'),
              style: OutlinedButton.styleFrom(
                foregroundColor: revrseNavy,
                side: const BorderSide(color: revrseBorder),
                minimumSize: const Size.fromHeight(48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 17),
            Wrap(
              alignment: WrapAlignment.center,
              children: [
                const Text(
                  'Already have an account? ',
                  style: TextStyle(fontSize: 13),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: revrseBlue,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class VerifyEmailPage extends StatefulWidget {
  final String email;

  const VerifyEmailPage({super.key, required this.email});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  final code = List.generate(6, (_) => TextEditingController());
  final nodes = List.generate(6, (_) => FocusNode());

  @override
  void dispose() {
    for (final c in code) {
      c.dispose();
    }
    for (final n in nodes) {
      n.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthPageShell(
      showBack: true,
      child: Column(
        children: [
          const Icon(
            Icons.mark_email_read_outlined,
            color: revrseBlue,
            size: 76,
          ),
          const SizedBox(height: 20),
          const Text(
            'Verify Your Email',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w800,
              color: revrseNavy,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "We've sent a 6-digit verification code to",
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xFF71809B)),
          ),
          const SizedBox(height: 5),
          Text(
            widget.email,
            style: const TextStyle(
              color: revrseBlue,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 28),
          Row(
            children: List.generate(6, (i) {
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: i == 5 ? 0 : 7),
                  child: TextField(
                    controller: code[i],
                    focusNode: nodes[i],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    decoration: const InputDecoration(
                      counterText: '',
                      contentPadding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty && i < 5)
                        nodes[i + 1].requestFocus();
                      if (value.isEmpty && i > 0) nodes[i - 1].requestFocus();
                    },
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 25),
          PrimaryButton(
            label: 'Verify',
            onPressed: () {
              final entered = code.map((c) => c.text).join();
              if (entered.length != 6) {
                showMessage(context, 'Enter the complete 6-digit code.');
              } else {
                showMessage(
                  context,
                  'UI demo: verify this code through your backend.',
                );
              }
            },
          ),
          const SizedBox(height: 18),
          TextButton(
            onPressed: () => showMessage(
              context,
              'A new code should be sent by your backend.',
            ),
            child: const Text('Resend Code'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Change Email'),
          ),
        ],
      ),
    );
  }
}

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthPageShell(
      showBack: true,
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.lock_reset_rounded, size: 76, color: revrseBlue),
            const SizedBox(height: 20),
            const Text(
              'Forgot Password?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w800,
                color: revrseNavy,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Enter your email address and we'll send you a link to reset your password.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF71809B), height: 1.5),
            ),
            const SizedBox(height: 27),
            AuthTextField(
              hint: 'Email Address',
              icon: Icons.mail_outline,
              controller: email,
              keyboardType: TextInputType.emailAddress,
              validator: emailValidator,
            ),
            const SizedBox(height: 17),
            PrimaryButton(
              label: 'Send Reset Link',
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  showMessage(
                    context,
                    'UI demo: send a reset link through your backend.',
                  );
                }
              },
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Back to Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final password = TextEditingController();
  final confirm = TextEditingController();

  @override
  void dispose() {
    password.dispose();
    confirm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthPageShell(
      showBack: true,
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.verified_user_outlined,
              color: revrseBlue,
              size: 76,
            ),
            const SizedBox(height: 18),
            const Text(
              'Reset Your Password',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: revrseNavy,
              ),
            ),
            const SizedBox(height: 9),
            const Text(
              'Create a new password to keep your account secure.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF71809B)),
            ),
            const SizedBox(height: 25),
            AuthTextField(
              hint: 'New Password',
              icon: Icons.lock_outline,
              controller: password,
              password: true,
              validator: (v) {
                if (v == null || v.length < 8)
                  return 'Use at least 8 characters';
                return null;
              },
            ),
            const SizedBox(height: 12),
            AuthTextField(
              hint: 'Confirm New Password',
              icon: Icons.lock_outline,
              controller: confirm,
              password: true,
              validator: (v) {
                if (v != password.text) return 'Passwords do not match';
                return null;
              },
            ),
            const SizedBox(height: 14),
            const Text(
              'Password must contain:',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: revrseNavy,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 6),
            const _Requirement(text: 'At least 8 characters'),
            const _Requirement(text: 'A mix of letters and numbers'),
            const SizedBox(height: 20),
            PrimaryButton(
              label: 'Reset Password',
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  showMessage(
                    context,
                    'UI demo: save the new password through your backend.',
                  );
                  Navigator.popUntil(context, (route) => route.isFirst);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _Requirement extends StatelessWidget {
  final String text;
  const _Requirement({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          const Icon(Icons.check_circle, size: 15, color: revrseBlue),
          const SizedBox(width: 7),
          Text(text, style: const TextStyle(fontSize: 12, color: revrseNavy)),
        ],
      ),
    );
  }
}

class _OrDivider extends StatelessWidget {
  final String label;
  const _OrDivider({required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: revrseBorder)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            label,
            style: const TextStyle(color: Color(0xFF71809B), fontSize: 12),
          ),
        ),
        const Expanded(child: Divider(color: revrseBorder)),
      ],
    );
  }
}
