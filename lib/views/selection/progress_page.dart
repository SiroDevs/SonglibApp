part of 'selection_screen.dart';

/// Screen to visualise progress when data is being loaded to the app
class ProgressPage extends StatelessWidget {
  final SelectionVm vm;
  const ProgressPage(this.vm, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double radius = isDesktop ? size.height / 2.5 : size.width / 2.5;

    var backgroundProgress = RotatedBox(
      quarterTurns: 7,
      child: SizedBox(
        height: size.width,
        child: LinearPercentIndicator(
          percent: double.parse(
            (vm.progress / 100).toStringAsFixed(1),
          ),
          lineHeight: size.width,
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
        fontSize: radius / 1.5,
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
          fontSize: radius / 8,
          color: Colors.white24,
        ),
      ),
    );

    /*var timeLeft = Padding(
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
              fontSize: radius / 7,
              color: Colors.white,
            ),
          ),
          Text(
            vm.time,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: radius / 5,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );*/

    var foregroundProgress = Center(
      child: AdvancedProgress(
        radius: radius,
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
              SizedBox(height: radius / 2.1),
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
      body: vm.isBusy
          ? const CircularProgress()
          : Stack(
              children: [
                backgroundProgress,
                foregroundProgress,
              ],
            ),
    );
  }
}
