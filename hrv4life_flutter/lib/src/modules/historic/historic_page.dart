import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:hrv4life_flutter/src/constants/app_colors.dart';
import 'package:hrv4life_flutter/src/constants/app_text_styles.dart';
import 'package:hrv4life_flutter/src/constants/routes_assets.dart';

class HistoricPage extends StatelessWidget {
  const HistoricPage({super.key});

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
                'Histórico',
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
                'Últimas medidas realizadas',
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
          ],
        ),
      ),
      bottomNavigationBar: ConvexAppBar(
        color: Colors.white,
        backgroundColor: AppColors.primaryPure,
        style: TabStyle.titled,
        items: const [
          TabItem(icon: Icons.home, title: 'Início'),
          // TabItem(icon: Icons.edit_note, title: 'Diario'),
          TabItem(icon: Icons.add, title: 'Medidas'),
          // TabItem(icon: Icons.message, title: 'Chat'),
          TabItem(icon: Icons.calendar_month_rounded, title: 'Histórico'),
        ],
        initialActiveIndex: 2,
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
}
