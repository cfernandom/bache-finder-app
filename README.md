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

En el archivo `.env` de este proyecto, configure la variable de entorno `GOOGLE_MAPS_API_PROXY_URL` para configurar la URL del proxy.
