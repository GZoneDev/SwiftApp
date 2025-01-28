import 'package:receptico/generated/l10n.dart';

extension LocalizationJson on S {
  Map<String, String> toJson() {
    return {
      "freePlan": freePlan,
      "proPlan": proPlan,
      "unknownPlan": unknownPlan,
    };
  }
}
