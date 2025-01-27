// import 'package:flutter/material.dart';
// import 'package:receptico/generated/l10n.dart';

// class PlanTranslator {
//   final BuildContext context;

//   PlanTranslator(this.context);

//   String translate(String plan) {
//     final localization = S.of(context);
//     switch (plan.toLowerCase()) {
//       case "free":
//         return localization.freePlan;
//       case "pro":
//         return localization.proPlan;
//       default:
//         return localization.unknownPlan;
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:receptico/extensions/localization_extensions.dart';
import 'package:receptico/generated/l10n.dart';

class PlanTranslator {
  final BuildContext context;

  // Маппинг для перевода планов
  static const Map<String, String> _planKeys = {
    "free": "freePlan",
    "pro": "proPlan",
    "unknown": "unknownPlan",
  };

  PlanTranslator(this.context);

  String translate(String plan) {
    final localization = S.of(context);

    // Получаем ключ из маппинга, если он существует
    final key = _planKeys[plan.toLowerCase()] ?? "unknownPlan";

    // Вызываем метод локализации через рефлексию
    final localizedValue =
        localization.toJson()[key] ?? localization.unknownPlan;

    return localizedValue;
  }
}
