import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:icapps_architecture/icapps_architecture.dart';

import '../../theme/theme_data.dart';

class DataProviderWidget
    extends BaseThemeProviderWidget<AppTheme, AppLocalizations> {
  const DataProviderWidget({
    Widget Function(BuildContext context, AppTheme theme)?
        childBuilderTheme,
    Widget Function(BuildContext context, AppLocalizations localization)?
        childBuilderLocalization,
    Widget Function(BuildContext context, AppTheme theme,
            AppLocalizations localization)?
        childBuilder,
  }) : super(
          childBuilderTheme: childBuilderTheme,
          childBuilderLocalization: childBuilderLocalization,
          childBuilder: childBuilder,
        );
}
