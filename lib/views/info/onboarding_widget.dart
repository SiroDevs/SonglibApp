part of 'onboarding_screen.dart';

class OnboardingWidget extends StatelessWidget {
  final Size? size;
  final String? image;
  final String? description;

  const OnboardingWidget({
    Key? key,
    required this.size,
    required this.image,
    this.description = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size!.height,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: ThemeColors.accent,
      ),
      child: Stack(
        children: [
          Container(
            height: size!.height - 200,
            padding: const EdgeInsets.all(20),
            child: Align(
              alignment: Alignment.topLeft,
              child: Image.asset('assets/images/$image.png'),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Text(
                description!,
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.right,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
