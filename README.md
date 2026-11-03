# REV Companion

The phone app for [Rev HUD](../bike_hud), a standalone heads-up display for two-wheelers and other vehicles.

The HUD is designed to work without this app: once a phone is paired over Bluetooth, calls and music work through the standard head-unit Bluetooth profiles. The companion app adds the things Bluetooth profiles can't carry:
- sending navigation destinations
- syncing ride history and telemetry
- vehicle details
- HUD settings

> **Status: proof of concept (v1.0.0+1).** The UI is in place, but **the HUD connection is simulated.** `HudConnectionService` fakes connecting, syncing and sending destinations, and nothing is sent to the HUD yet.

## Features

The app has three tabs.

- **Cockpit (home)**
  - HUD connection status, with signal strength, firmware and protocol details
  - HUD battery level and odometer
  - **Send to HUD:** pick a preset destination (Home, Work, favourites) or enter a custom one, then dispatch it to the HUD's navigation, or cancel the active route
  - Toggles for relaying incoming calls and media controls to the HUD
  - Most recent ride, plus manual sync of HUD data
- **Rides:** a logbook of recorded trips synced from the HUD (distance, duration, average and top speed, fuel used and mileage), with totals.
- **Vehicle:**
  - connect to or disconnect from the HUD
  - simulation mode toggle
  - vehicle and fuel details
  - theme (Night Obsidian / Daylight High Contrast) and accent colour (Emerald, Amber, Blue, Purple), kept in sync with the HUD

## Getting started

Requires the Flutter SDK (Dart `^3.13.2`).

```bash
flutter pub get
flutter run            # pick an Android/iOS device or emulator
flutter test
flutter analyze
```

Android and iOS are the target platforms. Windows and web targets are also set up for quick UI checks on a PC.

## Architecture

```text
lib/
 ├─ main.dart                       App entry (RevCompanionApp), bottom tab scaffold
 ├─ models/
 │   ├─ companion_state.dart        Immutable app state (connection, vehicle, rides, relays, theme)
 │   ├─ companion_theme.dart        Dark/light palettes and accent colours
 │   ├─ nav_destination.dart        Destination model and presets
 │   └─ ride_summary.dart           Ride model with JSON encoding
 ├─ screens/                        Home dashboard, rides, vehicle settings
 ├─ services/
 │   └─ hud_connection_service.dart ChangeNotifier holding CompanionState (simulated link)
 └─ widgets/                        Cards, connection pill, quick-nav card, ride card
```

`HudConnectionService` is a `ChangeNotifier`, and the whole app rebuilds from its `CompanionState` through a `ListenableBuilder` in `main.dart`.

## How it fits with the HUD

| Concern | Handled by |
| --- | --- |
| Calls (caller ID, answer/reject, audio) | Bluetooth HFP between the phone and the HUD; no app needed |
| Music (now playing, controls, audio) | Bluetooth A2DP/AVRCP between the phone and the HUD; no app needed |
| Navigation destinations and turn-by-turn steps | Companion app |
| Ride history and telemetry sync | Companion app |
| Vehicle info and HUD settings | Companion app |

On the HUD side, the companion app will be one implementation of the HUD's `PhoneLink` interface, running alongside the Bluetooth-profile link.

## Roadmap

1. **Shared protocol:** a Dart package used by both apps, with message types and JSON codecs for rides, destinations and settings, replacing the separate models each app has today.
2. **Real transport:** BLE GATT, with the HUD as peripheral and the phone as central, replacing the simulated `HudConnectionService`. Wi-Fi may follow for bulk data such as documents and map tiles.
3. **Navigation:** routing done on the phone, with turn-by-turn steps streamed to the HUD.
4. **Persistence:** keep rides and vehicle data on the phone, and sync both ways with the HUD.
