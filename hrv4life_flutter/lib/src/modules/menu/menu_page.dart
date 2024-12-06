import 'package:flutter/material.dart';
import 'package:hrv4life_flutter/src/constants/app_colors.dart';
import 'package:hrv4life_flutter/src/constants/app_text_styles.dart';
import 'package:hrv4life_flutter/src/constants/routes_assets.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeOF = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: AppColors.primaryLight.withOpacity(0.9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            // Adicionado para centralizar todo o conteúdo
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: sizeOF.height * 0.02),
              child: Column(
                children: [
                  _buildUserInfoContainer(sizeOF),
                  SizedBox(height: sizeOF.height * 0.03),
                  _buildMenuOptionsContainer(context, sizeOF),
                  SizedBox(height: sizeOF.height * 0.03),
                  _buildCloseButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfoContainer(Size sizeOF) {
    return Container(
      padding: const EdgeInsets.all(15),
      width: sizeOF.width * 0.85,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
              color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
        ],
        gradient: const LinearGradient(
            colors: [Color(0xFFFF9000), Color(0xFFFD821C), Color(0xFFF37221)]),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                  color: AppColors.neutral,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Icon(
                  Icons.person_2_rounded,
                  color: Colors.white,
                  size: 60,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nome do Usuário',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                        fontFamily: TextStyles.instance.secondary,
                        shadows: const <Shadow>[
                          Shadow(
                            offset: Offset(1.0, 2.0),
                            blurRadius: 1.0,
                            color: Colors.black26,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Editar informações',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        fontFamily: TextStyles.instance.secondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            'Como está sendo sua experiência com o app?',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 12,
              fontWeight: FontWeight.w400,
              fontFamily: TextStyles.instance.secondary,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              5,
              (index) => const Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Icon(
                  Icons.star_border_purple500_outlined,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Nos avalie',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              fontFamily: TextStyles.instance.secondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuOptionsContainer(BuildContext context, Size sizeOF) {
    return Container(
      width: sizeOF.width * 0.85,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
              color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
        ],
        gradient: const LinearGradient(
            colors: [Color(0xFFFF9000), Color(0xFFFD821C), Color(0xFFF37221)]),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          _buildMenuOption(
            icon: Icons.person,
            title: 'Meu perfil',
            onPressed: () {},
          ),
          _buildDivider(),
          _buildMenuOption(
            icon: Icons.wifi_outlined,
            title: 'Sincronizar dados',
            onPressed: () {},
          ),
          _buildDivider(),
          _buildMenuOption(
            icon: Icons.settings,
            title: 'Configuração',
            onPressed: () {},
          ),
          _buildDivider(),
          _buildMenuOption(
            icon: Icons.exit_to_app_outlined,
            title: 'Fechar',
            onPressed: () {
              Navigator.popAndPushNamed(context, RoutesAssets.homePage);
            },
            iconColor: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(50),
      ),
      child: IconButton(
        onPressed: () {
          Navigator.popAndPushNamed(context, RoutesAssets.homePage);
        },
        icon: const Icon(
          Icons.close,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildMenuOption({
    required IconData icon,
    required String title,
    required VoidCallback onPressed,
    Color iconColor = const Color(0xFFFC7732),
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                  color: iconColor,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  title,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    fontFamily: TextStyles.instance.secondary,
                  ),
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: onPressed,
            icon: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 15,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Divider(
        thickness: 0.4,
        color: Colors.white,
        height: 1,
      ),
    );
  }
}
