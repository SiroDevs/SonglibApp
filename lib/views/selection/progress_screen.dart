import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../navigator/main_navigator.dart';
import '../../theme/theme_colors.dart';
import '../../utils/utilities.dart';
import '../../vms/selection/progress_vm.dart';
import '../../widgets/progress/advanced/advanced_progress.dart';
import '../../widgets/progress/circular_progress.dart';
import '../../widgets/provider/provider_widget.dart';

/// Screen to visualise progress when data is being loaded to the app
class ProgressScreen extends StatefulWidget {
  static const String routeName = 'progress';

  const ProgressScreen({Key? key}) : super(key: key);

  @override
  ProgressScreenState createState() => ProgressScreenState();
}

class ProgressScreenState extends State<ProgressScreen>
    implements ProgressNavigator {
  Size? size;
  double? radius;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    radius = isDesktop ? size!.height / 2.5 : size!.width / 2.5;

    return ProviderWidget<ProgressVm>(
        create: () => GetIt.I()..init(this),
        childBuilderWithViewModel: (context, vm, theme, localization) {
        vm.tr = AppLocalizations.of(context)!;
          var backgroundProgress = RotatedBox(
            quarterTurns: 7,
            child: SizedBox(
              height: size!.width,
              child: LinearPercentIndicator(
                percent: double.parse(
                  (vm.progress / 100).toStringAsFixed(1),
                ),
                lineHeight: size!.width,
                backgroundColor: Colors.black,
                progressColor: ThemeColors.primaryDark,
              ),
            ),
          );
          var progressPercentage = Text(
            '${vm.progress} %',
            textAlign: TextAlign.center,
            style: TextStyle(
              letterSpacing: 1.5,
              fontWeight: FontWeight.w400,
              fontSize: radius! / 1.5,
              color: Colors.white,
            ),
          );
          var progressState = Center(
            child: Text(
              vm.state.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                letterSpacing: 1.5,
                fontWeight: FontWeight.w800,
                fontSize: radius! / 8,
                color: Colors.white24,
              ),
            ),
          );

          var timeLeft = Padding(
            padding: const EdgeInsets.only(
              top: 10,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Time Left',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: radius! / 7,
                    color: Colors.white,
                  ),
                ),
                Text(
                  vm.time,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: radius! / 5,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          );

          var foregroundProgress = Center(
            child: AdvancedProgress(
              radius: radius!,
              levelAmount: 100,
              levelLowHeight: 16,
              levelHighHeight: 20,
              division: 10,
              secondaryWidth: 10,
              progressGap: 10,
              primaryValue: vm.progress / 100,
              secondaryValue: vm.progress / 100,
              primaryColor: Colors.yellow,
              secondaryColor: Colors.red,
              tertiaryColor: Colors.white24,
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(height: radius! / 2.1),
                    progressPercentage,
                    progressState,
                    //timeLeft,
                  ],
                ),
              ),
            ),
          );

          return Scaffold(
            backgroundColor: Colors.black,
            body: vm.isLoading
                ? const CircularProgress()
                : Stack(
                    children: [
                      backgroundProgress,
                      foregroundProgress,
                    ],
                  ),
          );
        });
  }

  @override
  void goToHome() => MainNavigator.of(context).goToHome();

  @override
  void goToOnboarding() => MainNavigator.of(context).goToOnboarding();
}
