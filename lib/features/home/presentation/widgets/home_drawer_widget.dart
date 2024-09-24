import 'package:flutter/material.dart';

class HomeDrawerWidget extends StatelessWidget {
  const HomeDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFE8F5FB),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFFE8F5FB),
            ),
            padding: const EdgeInsets.all(0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, left: 8),
                  child: Image.asset(
                    'assets/images/banner.png', // Asegúrate de tener tu logo aquí.
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 8.0, right: 8.0),
                  child: Text(
                    'Tus ojos en la calle. Tu voz en la ciudad',
                    style: TextStyle(
                      color: Color(0xFF2C5461),
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          _ListTileWidget(
            icon: const Icon(Icons.person, color: Color(0xFF2C5461)),
            label: 'Mi Perfil',
            onTap: () {
              // Navega a la página de perfil
            },
          ),
          _ListTileWidget(
            icon: const Icon(Icons.view_list, color: Color(0xFF2C5461)),
            label: 'Mis Reportes',
            onTap: () {
              // Navega a la página de reportes
            },
          ),
          _ListTileWidget(
            icon: const Icon(Icons.add_circle, color: Color(0xFF2C5461)),
            label: 'Nuevo Reporte',
            onTap: () {
              // Navega a la página de nuevo reporte
            },
          ),
          _ListTileWidget(
            icon: const Icon(Icons.map, color: Color(0xFF2C5461)),
            label: 'Ver Mapa',
            onTap: () {
              // Navega a la página del mapa
            },
          ),
          _ListTileWidget(
            icon: const Icon(Icons.info, color: Color(0xFF2C5461)),
            label: 'Información',
            onTap: () {
              // Navega a la página de información
            },
          ),
          _ListTileWidget(
            icon: const Icon(Icons.logout, color: Color(0xFF2C5461)),
            label: 'Cerrar sesión',
            onTap: () {
              // Realiza la acción de cerrar sesión
            },
          )
        ],
      ),
    );
  }
}

class _ListTileWidget extends StatelessWidget {
  const _ListTileWidget({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final Widget icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: Text(
        label,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: const Color(0xFF2C5461),
            ),
      ),
      onTap: onTap,
    );
  }
}
