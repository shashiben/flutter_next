import 'package:flutter/material.dart';

class NextLoadingHelper extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  final Widget? loadingWidget;
  final bool ignoreWhileLoading;
  const NextLoadingHelper(
      {Key? key,
      required this.isLoading,
      this.ignoreWhileLoading = true,
      required this.child,
      this.loadingWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: IgnorePointer(ignoring: ignoreWhileLoading , child: child)),
        AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: isLoading
                ? loadingWidget ??
                    Scaffold(
                      backgroundColor: Colors.transparent,
                      body: Container(
                        color: Colors.transparent,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: SizedBox(
                            height: 100,
                            child: AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 15),
                              content: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    "Loading....",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                : const SizedBox())
      ],
    );
  }
}
