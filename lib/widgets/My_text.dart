import 'dart:ui';

class AppTextStyles {
      // Headings
      static final TextStyle heading1 = TextStyle(
          fontFamily: 'Poppins', fontSize: 40, fontWeight: FontWeight.w500, height: 1.2);
      static final TextStyle heading2 = TextStyle(
          fontFamily: 'Poppins', fontSize: 32, fontWeight: FontWeight.w500, height: 1.2);
      static final TextStyle heading3 = TextStyle(
          fontFamily: 'Poppins', fontSize: 24, fontWeight: FontWeight.w500, height: 1.2);
      static final TextStyle heading4 = TextStyle(
          fontFamily: 'Poppins', fontSize: 20, fontWeight: FontWeight.w500, height: 1.4, letterSpacing: -1);
      static final TextStyle heading5 = TextStyle(
          fontFamily: 'Poppins', fontSize: 18, fontWeight: FontWeight.w500);

      // Body
      static final TextStyle bodyL = TextStyle(fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.w500);
      static final TextStyle bodyM = TextStyle(fontFamily: 'Poppins', fontSize: 14, fontWeight: FontWeight.w500);
      static final TextStyle bodyS = TextStyle(fontFamily: 'Poppins', fontSize: 12, fontWeight: FontWeight.w500);

      // Button
      static final TextStyle buttonL = TextStyle(fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 2);
      static final TextStyle buttonM = TextStyle(fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 2);
      static  TextStyle buttonS = TextStyle(fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 2);

      // Label
      static  TextStyle label = TextStyle(fontSize: 12, fontWeight: FontWeight.w400, height: 1.2, letterSpacing: 2);

      // Numbers
      static  TextStyle numbers = TextStyle(fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 0);

      // Tab Bar
      static final TextStyle tabBar = TextStyle(fontSize: 12, fontWeight: FontWeight.w400, height: 1.2, letterSpacing: 2);
      static final TextStyle tabBarBold = TextStyle(fontSize: 12, fontWeight: FontWeight.w600, height: 1.2, letterSpacing: 2);
}
