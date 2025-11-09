# Movies App

A beautiful, responsive Flutter application for discovering and exploring movies from the Movie Database (TMDB). Built with Retrofit for REST API calls, and Riverpod version 3 for state management.

## Features

    - Popular movies: Browse the latest trending films
    - Top rated: Discover the highest-rated movies
    - Upcoming moviess: Stay updated with upcoming releases
    - Advance search: Find any movie instantly

## Tech stack

    - Framework: Flutter
    - State management: Riverpod 3
    - Rest Client: Retrofit
    - HTTP Client: Dio
    - Data SErialization: JSON Serializable
    - Image Caching: Cached Network Imagee

## Screenshots

![Home Screen](assets/screenshots/screenshot1.png)

![Moview Details Screen](assets/screenshots/screenshot2.png)

![Search Result Screen](assets/screenshots/screenshot3.png)

## Getting Started

### Prerequisites

    - Flutter SDK 3.10+
    - Dart SDK 3.0+
    - TMDb API Key 

### Installation

    1. Clone the repository
    ```
    git clone https://github.com/niyiment/movie_app.git
    cd movies_app
    ```

    2. Install dependencies
    ```
    flutter pub get
    ```
    3. Get your TMDb API
     - Visit [TMDb API](https://www.themoviedb.org/settings/api)
     - Create an account and generate an API key
    4. Configure API key: Create a .env file and configure your API key.
    5. Generate code:
    ```
    dart run build_Runner build --delete-conflicting-outputs
    ```
    6. Run the app
    ``` 
    flutter run
    ```

## Future enhancement

    - Offline caching with Drift
    - Whatchlist functionalit with local storage
    - User reviews and ratings
    - Advanced filtering and sorting
    - Dark/Light mode
    - Share moview details
    
