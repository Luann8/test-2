import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:hrv4life_core/hrv4life_core.dart';
import 'package:hrv4life_flutter/src/constants/app_assets.dart';
import 'package:hrv4life_flutter/src/constants/app_colors.dart';
import 'package:hrv4life_flutter/src/constants/app_text_styles.dart';
import 'package:hrv4life_flutter/src/constants/routes_assets.dart';
import 'package:hrv4life_flutter/src/modules/register/register_controller.dart';
import 'package:validatorless/validatorless.dart';

class RegisterNamePage extends StatefulWidget {
  const RegisterNamePage({super.key});

  @override
  State<RegisterNamePage> createState() => _RegisterNamePageState();
}

class _RegisterNamePageState extends State<RegisterNamePage>
    with MessageViewMixin {
  final formKey = GlobalKey<FormState>();
  final nomeEC = TextEditingController();
  final sobrenomeEC = TextEditingController();
  final controller = Injector.get<RegisterController>();

  @override
  void dispose() {
    nomeEC.dispose();
    sobrenomeEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: sizeOf.height - MediaQuery.of(context).padding.top,
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
                    Padding(
                      padding: const EdgeInsets.only(left: 40.0, top: 10.0),
                      child: Text(
                        'Cadastrar',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: TextStyles.instance.secondary,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 40.0, top: 10.0),
                      child: Text(
                        'Boas Vindas!\nQual é o seu nome?',
                        style: Hrv4lifeThema.titleStyle,
                      ),
                    ),
                    SizedBox(height: sizeOf.height * 0.04),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: nomeEC,
                            validator:
                                Validatorless.required('Nome obrigatório'),
                            decoration: const InputDecoration(
                              labelText: 'Nome',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: sizeOf.height * 0.04),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: sobrenomeEC,
                            validator:
                                Validatorless.required('Sobrenome obrigatório'),
                            decoration: const InputDecoration(
                              labelText: 'Sobrenome',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: sizeOf.height * 0.05,
                            width: sizeOf.width * 0.37,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.popAndPushNamed(
                                    context, RoutesAssets.onbording);
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.w600),
                              ),
                              label: const Text(
                                'Voltar',
                                style: TextStyle(color: Colors.black45),
                              ),
                              icon: const Icon(
                                color: Colors.white,
                                Icons.arrow_circle_left,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: sizeOf.height * 0.05,
                            width: sizeOf.width * 0.37,
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
                                if (formKey.currentState!.validate()) {
                                  final nome = nomeEC.text;
                                  final sobrenome = sobrenomeEC.text;
                                  controller.registerName(nome, sobrenome);
                                  Navigator.pushNamed(
                                      context, RoutesAssets.registerQuestion);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.w600),
                              ),
                              label: const Text('Avançar'),
                              icon: const Icon(
                                color: Colors.white,
                                Icons.arrow_circle_right,
                              ),
                            ),
                          ),
                        ),
                      ],
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
