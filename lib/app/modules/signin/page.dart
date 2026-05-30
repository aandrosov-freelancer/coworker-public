import 'package:flutter/material.dart';
import '../signup/local_widgets/left_panel.dart';
import 'local_widgets/signin_form.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 1280) {
            return Row(
              children: [
                SizedBox(width: 576, child: const LeftPanel()),
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(80),
                      child: const SigninForm(),
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
                    child: Expanded(child: SigninForm()),
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
