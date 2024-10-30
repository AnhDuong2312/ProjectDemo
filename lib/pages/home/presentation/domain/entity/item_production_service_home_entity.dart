import 'package:flutter/material.dart';

enum EnumItemProductionServiceHome { invoiceAndPXK, electronicTicket }

class ItemProductionServiceHomeEntity {
  final EnumItemProductionServiceHome type;
  final String title;
  final Widget icon;

  ItemProductionServiceHomeEntity({
    required this.type,
    required this.title,
    required this.icon,
  });
}
