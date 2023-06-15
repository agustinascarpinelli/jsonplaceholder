# README - Aplicación Flutter de jsonplaceholder

Esta es una aplicación Flutter desarrollada con el fin de consumir la API de jsonplaceholder. La aplicación tiene las siguientes características básicas:

- Muestra una lista de usuarios obtenidos de la API.
- Muestra una lista de publicaciones obtenidas de la API.
- Permite realizar publicaciones en la API.
- Detecta la conectividad del dispositivo.

## Requisitos de la aplicación

- Flutter SDK: >=2.18.5 <3.0.0

## Dependencias

El proyecto utiliza las siguientes dependencias:

- [bloc](https://pub.dev/packages/bloc): ^8.1.2
- [connectivity_plus](https://pub.dev/packages/connectivity_plus): ^4.0.1
- [cupertino_icons](https://pub.dev/packages/cupertino_icons): ^1.0.2
- [flutter](https://flutter.dev/): sdk: flutter
- [flutter_bloc](https://pub.dev/packages/flutter_bloc): ^8.1.3
- [get_it](https://pub.dev/packages/get_it): ^7.2.0
- [http](https://pub.dev/packages/http): ^0.13.5
- [provider](https://pub.dev/packages/provider): ^6.0.5
- [rxdart](https://pub.dev/packages/rxdart): ^0.27.7
- [shared_preferences](https://pub.dev/packages/shared_preferences): ^2.1.1
- [timer_builder](https://pub.dev/packages/timer_builder): ^2.0.0

## Configuración

Asegúrate de tener Flutter SDK instalado en tu entorno de desarrollo. Puedes obtener más información sobre cómo instalar Flutter en [flutter.dev](https://flutter.dev/docs/get-started/install).

## Instalación de dependencias

Antes de ejecutar la aplicación, asegúrate de instalar todas las dependencias requeridas. Para hacerlo, sigue estos pasos:

1. Abre una terminal en el directorio raíz del proyecto.
2. Ejecuta el siguiente comando:

   ```bash
   flutter pub get
   ```

Este comando descargará e instalará todas las dependencias necesarias para la aplicación.

## Ejecución de la aplicación

Para ejecutar la aplicación en un dispositivo o emulador, sigue estos pasos:

1. Conecta tu dispositivo o inicia un emulador.
2. Abre una terminal en el directorio raíz del proyecto.
3. Ejecuta el siguiente comando:

   ```bash
   flutter run
   ```

La aplicación se compilará y se ejecutará en el dispositivo/emulador seleccionado.

## Estructura del proyecto

El proyecto sigue una estructura común para las aplicaciones Flutter. Aquí se presenta una descripción de los principales directorios y archivos:

- `lib/`: Contiene el código fuente de la aplicación.
  - `data/`: Contiene las clases y lógica relacionada con la obtención y manipulación de datos.
  - `models/`: Contiene las definiciones de los modelos de datos utilizados en la aplicación.
  - `pages/`: Contiene las pantallas principales de la aplicación.
  - `widgets/`: Contiene los widgets reutilizables utilizados en la aplicación.
- `pubspec.yaml`: Archivo de configuración del proyecto donde se especifican las dependencias y otros metadatos.

## Contribuciones

Las contribuciones son bienvenidas. Si deseas colaborar con este proyecto, por favor sigue los siguientes pasos

:

1. Realiza un fork de este repositorio.
2. Crea una rama nueva para tus cambios.
3. Realiza los cambios y commitea tus modificaciones.
4. Envía un pull request con tus cambios.

## Licencia

Este proyecto está bajo la [Licencia MIT](LICENSE).
