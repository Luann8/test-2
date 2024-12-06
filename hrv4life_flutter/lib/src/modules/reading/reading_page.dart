import 'package:auto_size_text/auto_size_text.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:hrv4life_flutter/src/constants/app_colors.dart';
import 'package:hrv4life_flutter/src/constants/app_text_styles.dart';
import 'package:hrv4life_flutter/src/constants/routes_assets.dart';

class ReadingPage extends StatelessWidget {
  const ReadingPage({super.key});

  get constraintsmaxHeight => null;

  @override
  Widget build(BuildContext context) {
    final sizeOF = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        alignment: AlignmentDirectional.topCenter,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Text(
                'Medidas',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  fontFamily: TextStyles.instance.primary,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Text(
                'Escolha o tipo de medida',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: TextStyles.instance.secondary,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .8,
              child: const Divider(
                height: 4,
                color: AppColors.secondaryLight,
              ),
            ),
            SizedBox(height: sizeOF.height * 0.03),
            _buildMeasurementContainer(
              context,
              sizeOF,
              'Avaliação diária',
              'Faça logo após acordar e receba orientação de como melhorar o seu dia.',
              Icons.wb_sunny_outlined,
              '/reading/morning',
            ),
            SizedBox(height: sizeOF.height * 0.03),
            _buildMeasurementContainer(
              context,
              sizeOF,
              'Respiração guiada',
              'Faça exercícios de respiração para voltar a calma e controlar o estresse.',
              Icons.air,
              '/reading/pacer',
            ),
          ],
        ),
      ),
      bottomNavigationBar: ConvexAppBar(
        color: Colors.white,
        backgroundColor: AppColors.primaryPure,
        style: TabStyle.titled,
        items: const [
          TabItem(icon: Icons.home, title: 'Início'),
          TabItem(icon: Icons.add, title: 'Medida'),
          TabItem(icon: Icons.calendar_month_rounded, title: 'Histórico'),
        ],
        initialActiveIndex: 1,
        onTap: (int i) {
          switch (i) {
            case 0:
              Navigator.pushReplacementNamed(context, RoutesAssets.homePage);
            case 1:
              Navigator.pushReplacementNamed(context, RoutesAssets.readingHome);
            case 2:
              Navigator.pushReplacementNamed(
                  context, RoutesAssets.historicPage);
          }
        },
      ),
    );
  }

  Widget _buildMeasurementContainer(
    BuildContext context,
    Size sizeOF,
    String title,
    String description,
    IconData icon,
    String route,
  ) {
    return Container(
      width: sizeOF.width * .9,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            blurStyle: BlurStyle.normal,
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 8),
                      child: Container(
                        height: 32,
                        width: 32,
                        decoration: const BoxDecoration(
                          color: AppColors.primaryPure,
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        child: Icon(icon, color: Colors.white, size: 20),
                      ),
                    ),
                    AutoSizeText(
                      title,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: TextStyles.instance.secondary,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, route);
                  },
                  icon: const Icon(
                    Icons.chevron_right_outlined,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .8,
            child: const Divider(
              color: Colors.black12,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 20),
            child: AutoSizeText(
              description,
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: Colors.black38,
                fontSize: 14,
                fontFamily: TextStyles.instance.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
