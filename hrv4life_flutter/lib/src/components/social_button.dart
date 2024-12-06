import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hrv4life_flutter/src/constants/app_assets.dart';
import 'package:hrv4life_flutter/src/constants/app_text_styles.dart';

class SocialButton extends StatelessWidget {
  const SocialButton(
      {super.key,
      required this.label,
      required this.type,
      this.isShadow = false,
      this.image,
      required this.onTap});
  final String label;
  final SocialButtotype type;
  final bool isShadow;
  final String? image;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: isShadow
            ? [
                const BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 4),
                    blurRadius: 5.0)
              ]
            : [],
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(24),
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            elevation: 0,
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
                side: const BorderSide(width: 1, color: Colors.black12)),
            textStyle: const TextStyle(fontWeight: FontWeight.w600)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            image == null
                ? switch (type) {
                    SocialButtotype.apple => const Icon(
                        Icons.apple,
                        color: Colors.black,
                      ),
                    SocialButtotype.facebook => Icon(
                        Icons.facebook,
                        color: Colors.blue[800],
                      ),
                    _ => const SizedBox.shrink()
                  }
                : SvgPicture.asset(
                    AppAssets.google,
                    width: 24,
                    height: 24,
                  ),
            const SizedBox(
              width: 20,
            ),
            Text(
              label,
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: TextStyles.instance.secondary,
                  fontWeight: FontWeight.w100,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

enum SocialButtotype { google, apple, facebook }
