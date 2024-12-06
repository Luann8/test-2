import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:hrv4life_core/hrv4life_core.dart';
import 'package:hrv4life_flutter/src/constants/app_assets.dart';
import 'package:hrv4life_flutter/src/constants/app_colors.dart';
import 'package:hrv4life_flutter/src/constants/routes_assets.dart';
import 'package:hrv4life_flutter/src/modules/login/login_controller.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with MessageViewMixin {
  final formKey = GlobalKey<FormState>();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();
  final controller = Injector.get<LoginController>();

  @override
  void initState() {
    messageListener(controller);
    effect(() {
      if (controller.logged) {
        Navigator.of(context).pushReplacementNamed(RoutesAssets.homePage);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    emailEC.dispose();
    passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOF = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: sizeOF.height -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom,
            ),
            child: IntrinsicHeight(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 40, top: 40),
                      child: Image(
                        image: AssetImage(AppAssets.splash),
                        height: 40,
                        width: 40,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 40.0, top: 40.0),
                      child: Text(
                        'Informe seu\nusuário e senha',
                        style: Hrv4lifeThema.titleStyle,
                      ),
                    ),
                    SizedBox(height: sizeOF.height * 0.04),
                    Padding(
                      padding: const EdgeInsets.only(left: 40.0, top: 10.0),
                      child: SizedBox(
                        height: 40,
                        width: sizeOF.width * .8,
                        child: TextFormField(
                          controller: emailEC,
                          validator: Validatorless.multiple([
                            Validatorless.required('Email obrigatório'),
                            Validatorless.email('Email inválido'),
                          ]),
                          decoration: const InputDecoration(
                            label: Text('Email'),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: sizeOF.height * 0.04),
                    Padding(
                      padding: const EdgeInsets.only(left: 40.0, top: 10.0),
                      child: SizedBox(
                        height: 40,
                        width: sizeOF.width * .8,
                        child: Watch(
                          (_) {
                            return TextFormField(
                              obscureText: controller.obscurePassword,
                              controller: passwordEC,
                              validator: Validatorless.multiple([
                                Validatorless.required('Senha obrigatório')
                              ]),
                              decoration: InputDecoration(
                                label: const Text('Senha'),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.passwordToggle();
                                  },
                                  icon: controller.obscurePassword
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 184, top: 8.0),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.primary,
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          onPressed: () {},
                          child: const Text('Esqueci minha senha'),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: sizeOF.width * 0.7,
                          decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(0, 4),
                                  blurRadius: 5.0)
                            ],
                            gradient: const LinearGradient(colors: [
                              Color(0xFFFF9000),
                              Color(0xFFFD821C),
                              Color(0xFFF37221)
                            ]),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, RoutesAssets.homePage);
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              textStyle:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            ),
                            icon: const Icon(
                              color: Colors.white,
                              Icons.arrow_circle_right_rounded,
                            ),
                            label: const Text('Entrar'),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
