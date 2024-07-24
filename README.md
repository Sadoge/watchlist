# Watchlist

A Flutter application to track TV series you're watching or want to watch. The app allows you to search for TV series using the TMDB API, view detailed information about each series, and see where you can watch them. The app is structured using the MVVM pattern with Riverpod for state management and a clean architecture approach.

## Features

- **Search TV Series**: Search for TV series using the TMDB API.
- **Track Watchlist**: Add TV series to your watchlist and keep track of your progress.
- **View Details**: View detailed information about each TV series, including seasons and episodes.
- **Watch Providers**: See where you can watch the TV series (specific to your region).

## Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/Sadoge/watchlist.git
   cd watchlist
   ```

2. **Install dependencies:**

   ```bash
    flutter pub get
   ```

3. **Setup TMDB API Key:**

- Get your API key from [TMDB](https://www.themoviedb.org/settings/api).
- Pass API key in run

  ```bash
   flutter run --dart-define TMDB_API_KEY=your_api_key
  ```

## License

This project is licensed under the MIT License. See the LICENSE file for details.

## Acknowledgements

[JustWatch](https://www.justwatch.com/) for watch providers
[The Movie Database (TMDB)](https://developer.themoviedb.org/) for the API.
[Flutter](https://flutter.dev/) for the framework.
[Riverpod](https://riverpod.dev/) for state management.
