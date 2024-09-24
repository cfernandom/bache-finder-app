import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Información', style: TextStyle(color: Colors.white)),
        backgroundColor:  const Color(0xFF2C5461),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color(0xFFE8F5FB),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bache Finder',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2C5461),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Bache Finder es una innovadora herramienta que utiliza la inteligencia artificial y el procesamiento de imágenes para ofrecer análisis precisos y detallados de los defectos viales en nuestros sectores. Nuestra aplicación proporciona información valiosa sobre las características topográficas y estructurales de los defectos viales de manera rápida y conveniente, simplemente al tomar una fotografía.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 32),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline,
                  color: Color(0xFF2C5461),
                ),
                SizedBox(width: 8),
                Text(
                  'Versión actual: 0.0.1',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Center(
              child: Image.asset(
                'assets/images/splash.png',
                height: 150,
                width: 150,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
