import 'dart:ffi';

import 'package:flutter/material.dart';

class Decoding {
  String decode(
      String nameServer, double ip1, double ip2, double ip3, double ip4) {
    int charSum = 0;

    for (int i = 0; i < nameServer.length; i++) {
      charSum += nameServer.codeUnitAt(i);
    }
    charSum = (charSum / 4.0).truncate();
    double ip1Aux = ip1 * 127;
    double ip2Aux = ip2 * 255;
    double ip3Aux = ip3 * 255;
    double ip4Aux = ip4 * 255;

    ip1Aux = charSum - ip1Aux;
    ip2Aux = charSum - ip2Aux;
    ip3Aux = charSum - ip3Aux;
    ip4Aux = charSum - ip4Aux;

    String sol =
        "${ip1Aux.truncate()}.${ip2Aux.truncate()}.${ip3Aux.truncate()}.${ip4Aux.truncate()}";

    return sol;
  }
}
