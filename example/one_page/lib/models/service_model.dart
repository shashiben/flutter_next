import 'package:flutter/material.dart';

class ServiceModel {
  final String title;
  final String description;
  final Color color;
  final String background;
  final IconData icon;

  ServiceModel(
      {required this.title,
      required this.description,
      required this.color,
      required this.background,
      required this.icon});
}
