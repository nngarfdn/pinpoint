# PinPoint

PinPoint is a Flutter-based mobile application that allows users to manage location data efficiently. With an interactive map powered by Google Maps, users can add, update, delete, and search for saved locations.

## Features

- **Interactive Map**:
  - View all saved locations on a map.
  - Center the map dynamically based on saved locations.
  - Toggle between different map types: Normal, Satellite, Terrain, and Hybrid.
  - Navigate to a fullscreen map view for better visibility.

- **Location Management**:
  - Add new locations with details like name, address, latitude, and longitude.
  - Edit or update existing locations.
  - Delete locations from the list.

- **Search Functionality**:
  - Filter locations by name or address using the search bar.

- **Offline Storage**:
  - All locations are stored locally using Hive, ensuring fast and secure access even without an internet connection.

## Dependencies

- `flutter`
- `google_maps_flutter`: For rendering Google Maps and interacting with markers.
- `hive`: For local database storage.
- `provider`: For state management.
- `get_it`: For dependency injection.


## Demo

### Android
[PinPoint Android Demo](https://drive.google.com/file/d/1jg9W9XZebDXZMgrGz_dZDsLGPdCaoROE/view?usp=sharing)

### iOS
[PinPoint iOS Demo](https://drive.google.com/file/d/1BJmNa31jj6Ve55hU9pokrsiBlS5UrH4J/view?usp=sharing)
