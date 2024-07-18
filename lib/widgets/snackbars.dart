import "package:flutter/material.dart";

SnackBar bottomMessage({required String title, required Color color}) {
  return SnackBar(
    content: Text(
      title,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
    backgroundColor: color,
  );
}