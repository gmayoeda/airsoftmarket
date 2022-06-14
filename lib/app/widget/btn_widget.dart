// ignore_for_file: must_be_immutable

import 'package:airsoftmarket/app/utils/color.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  var btnText = "";
  var onClick;
  var icon;

  ButtonWidget({required this.btnText, this.onClick, Widget? this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 20),
      child: Container(
        decoration: BoxDecoration(
          color: mainColors,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.grey,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            onTap: onClick,
            child: Container(
              width: double.infinity,
              height: 45,
              decoration: BoxDecoration(
                // color: mainColors,
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                btnText,
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
