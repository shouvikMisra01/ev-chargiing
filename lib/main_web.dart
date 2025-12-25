import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'core/config/api_keys.dart';

/// Initialize Google Maps JavaScript API for web
/// This must be called before the app starts
void initializeGoogleMapsForWeb() {
  // Check if script is already loaded
  final existingScript = html.document.querySelector(
    'script[src*="maps.googleapis.com/maps/api/js"]',
  );

  if (existingScript == null) {
    // Create and inject the Google Maps script tag
    final script = html.ScriptElement()
      ..src = 'https://maps.googleapis.com/maps/api/js?key=${ApiKeys.googleMapsApiKey}'
      ..async = false  // Load synchronously
      ..defer = false;

    html.document.head?.append(script);
  }
}
