import 'package:flutter/material.dart';

class AppColors {
  // Primary (Indigo) - Core Branding
  static const Color primary = Color(0xFF4F46E5); 
  static const Color primaryLight = Color(0xFF818CF8); 
  static const Color primaryDark = Color(0xFF3730A3); 
  
  // Secondary (Emerald) - Success & Growth
  static const Color secondary = Color(0xFF10B981); 
  static const Color secondaryLight = Color(0xFF34D399); 
  
  // Status Colors
  static const Color error = Color(0xFFF43F5E); // Rose 500 (more vibrant than red)
  static const Color warning = Color(0xFFF59E0B); 
  static const Color info = Color(0xFF0EA5E9); 
  
  // Neutral / Background (Slate/Deep Blue) - Adjusted for Glassmorphism depth
  static const Color background = Color(0xFF020617); // Slate 950 (darker)
  static const Color surface = Color(0xFF0F172A); // Slate 900
  static const Color surfaceLight = Color(0xFF1E293B); // Slate 800
  
  // Text Colors
  static const Color textPrimary = Color(0xFFF8FAFC); // Slate 50
  static const Color textSecondary = Color(0xFF94A3B8); // Slate 400
  static const Color textMuted = Color(0xFF64748B); // Slate 500
  
  // Custom Gradients for "Premium" UI
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, primaryDark],
  );

  static const LinearGradient successGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [secondary, Color(0xFF059669)],
  );

  static const LinearGradient surfaceGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [surface, background],
  );
}
