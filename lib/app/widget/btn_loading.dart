import 'package:flutter/material.dart';

class BtnLoading extends StatelessWidget {
  const BtnLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45,
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: Colors.white),
          SizedBox(width: 10),
          Text(
            " LOADING",
            style: TextStyle(
                fontSize: 17, color: Colors.white, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
