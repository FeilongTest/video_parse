import 'package:flutter/material.dart';

import '../values/index.dart';

/// 开始按钮
Widget buildStartButton() {
  return Container(
    width: double.infinity,
    height: 44,
    margin: const EdgeInsets.fromLTRB(30, 20, 30, 0),
    child: TextButton(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(const TextStyle(
          fontSize: 16,
        )),
        foregroundColor: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.focused) &&
                !states.contains(MaterialState.pressed)) {
              return Colors.blue;
            } else if (states.contains(MaterialState.pressed)) {
              return Colors.deepPurple;
            }
            return AppColors.primaryElementText;
          },
        ),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return AppColors.secendPrimaryElement;
          }
          return AppColors.primaryElement;
        }),
        shape: MaterialStateProperty.all(const RoundedRectangleBorder(
          borderRadius: Radii.k6pxRadius,
        )),
      ),
      onPressed: () => {},
      child: const Text("Get started"),
    ),
  );
}
