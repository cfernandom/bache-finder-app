# bache_finder_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Configuration

### Google Maps API Key

Configure una variable de entorno en su sistema operativo de la siguiente manera:

```bash
export GOOGLE_MAPS_API_KEY=<YOUR_API_KEY>
```
Warning: Despite using a proxy to avoid exposing the API key, the Google Maps script makes requests that may expose the key. It is recommended to configure restrictions for the API key.

Asegúrate de que la variable de entorno `GOOGLE_MAPS_API_KEY` esté exportada en el entorno actual y que el terminal desde el cual estás corriendo el comando de construcción tenga acceso a dicha variable. Si la exportas en un terminal, pero ejecutas el build en otro, la variable no estará disponible.

Si la variable se establece en el terminal pero no es persistente, puedes añadirla al archivo de inicialización de tu shell (`.bashrc`, `.zshrc`, etc.):

En el archivo `.env` de este proyecto, configure la variable de entorno `GOOGLE_MAPS_API_PROXY_URL` para configurar la URL del proxy.


### Cambiar el nombre de la aplicación

```
dart run change_app_package_name:main com.bache_finder.app
```

### Cambiar icono de la app

Ajustar configuraciones de la sección flutter_launcher_icons del archivo pubspec.yaml para cambiar el icono de la app.
Despues de hacer esto, ejecutar el comando:

```
flutter pub run flutter_launcher_icons
```