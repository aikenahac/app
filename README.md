# CoinSeek

CoinSeek is a competing [DragonHack](https://dragonhack.si/) 2024 mobile app.

## Project structure

Assets are stored in the `assets` directory in root.

The code we wrote is located in the `lib` directory and is split by modules and features. Each feature can (auth, and home) contain directories holding `providers`, `screens`, `widgets` and `api` code.

## State management
State management is handled with the Flutter [riverpod](https://pub.dev/packages/riverpod) package.

## Routing
Routing is handled via the [go_router](https://pub.dev/packages/go_router) package.

## Firebase
The app uses Firebase as a backend (with cloud functions) so running the app requires a Firebase projet.

To run/build the app you need to have the required configuration files for Firebase, which can be added with the FlutterFire CLI.

If using the FlutterFire CLI you need to run:
```
flutterfire configure --project=<project_id>
```

## Environment
The `.env` file needs to have the API URL defined.

```
API_URL="http://localhost:3000"
```