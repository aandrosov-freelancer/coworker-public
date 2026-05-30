import 'package:app/app/core/values/dimensions.dart';
import 'package:flutter/material.dart';
import 'local_widgets/left_panel.dart';
import 'local_widgets/signup_form.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > AppDimensions.minDesktopWidth) {
            return Row(
              children: [
                SizedBox(width: 576, child: const LeftPanel()),
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(80),
                      child: const SignupForm(),
                    ),
                  ),
                ),
              ],
            );
          } else {
            // Mobile/Tablet view
            return SingleChildScrollView(
              child: Column(
                children: [
                  const LeftPanel(),
                  const Padding(
                    padding: EdgeInsets.all(24),
                    child: Expanded(child: SignupForm()),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
