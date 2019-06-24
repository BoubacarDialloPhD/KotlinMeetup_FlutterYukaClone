import 'dart:ui';

class AppColors {
  const AppColors._();

  static const Color _white = Color(0xFFFFFFFF);

  static const Color white_light = Color(0xFFFAFAFA);

  static const Color green_start = Color(0xFF82D84E);
  static const Color green_end = Color(0xFF0EAD69);

  static const Color primary = green_start;
  static const Color accent = green_end;
  static const Color splash = _white;

  static const Color dark_text = Color(0xFF1D1E2C);
  static const Color light_text = _white;
  static const Color gray_icon = Color(0xFF66728B);
  static const Color white_icon = _white;

  static const Color nutrition_score_low = Color(0xFF85BB2F);
  static const Color nutrition_score_moderate = Color(0xFFFDCB01);
  static const Color nutrition_score_high = Color(0xFFE63E12);
}
