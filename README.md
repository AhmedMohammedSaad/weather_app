# Weather App — Production-Grade Flutter Application

A production-grade, highly scalable Flutter application built following **Clean Architecture**, **Feature-First Project Structure**, **SOLID Principles**, and **Production Best Practices**.

---

## 🌟 Key Highlights & Architectural Decisions

### 🏗️ 1. Clean Architecture & Feature-First Structure
The codebase follows a strict separation of concerns divided into **Core** and **Features**:

```text
lib/
├── core/                         # Shared core modules & utilities across the app
│   ├── api/                      # ApiConsumer interface & ApiConstants
│   ├── constants/                # Centralized AppStrings & AppImages tokens
│   ├── errors/                   # Unified Error Handling & Failure hierarchy
│   ├── helpers/                  # Decoupled WeatherIconMapper & helpers
│   ├── local_data/               # Smart City-Based Offline Caching System
│   ├── networking/               # DioConsumer & NetworkInfo implementations
│   ├── router/                   # Named Routing Configuration
│   ├── theme/                    # AppColors, AppTextStyle design system tokens
│   └── widgets/                  # Shared Reusable Widgets (AppToast, AppCard, AppButton, AppEmptyStateWidget)
└── features/
    └── weather/                  # Isolated Weather Feature Module
        ├── data/
        │   ├── datasources/      # Remote Data Sources with Offline Cache Fallback
        │   ├── models/           # Data Models with JSON deserialization
        │   └── repositories/     # Repository Implementations
        ├── domain/
        │   ├── entities/         # Pure Business Entities
        │   ├── repositories/     # Abstract Repository Contracts
        │   └── usecases/         # Business Use Cases (GetCurrentWeatherUseCase)
        └── presentation/
            ├── cubit/            # WeatherCubit & Single WeatherState
            ├── view/             # Screen Views (WeatherView)
            ├── sections/         # Connecting Cubit State to UI (WeatherHeaderSection, WeatherDetailSection)
            └── widgets/          # Pure Modular UI Widgets (WeatherIconWidget, WeatherTemperatureWidget, etc.)
```

#### Why Feature-First & Clean Architecture?
- **Domain Independence**: The `domain` layer has zero dependencies on Flutter UI frameworks or third-party packages, making business logic 100% pure and testable.
- **Maintainability & Scalability**: Adding new features (e.g. 7-Day Forecast or Saved Cities) can be done inside `features/` without touching existing business logic or breaking core modules.
- **Strict UI Layering (View ➔ Section ➔ Widget)**:
  - **View**: Represents full screens without direct business decisions.
  - **Section**: Listens to state changes from Cubit, transforms state data, and builds modular widgets.
  - **Widget**: Pure, decoupled presentation components receiving data purely via parameters.

---

### 🧠 2. Advanced State Management (Cubit with Single State Pattern)
State management is handled using **Flutter BLoC / Cubit**. Instead of multiple scattered subclassed states, a **Single Immutably-Copied State (`WeatherState`)** with a explicit `WeatherStatus` enum is utilized:

```dart
enum WeatherStatus { initial, loading, success, error, empty }
```

#### Why Single State Pattern with `copyWith`?
- **Unidirectional Data Flow**: Guarantees predictable state transitions and eliminates race conditions.
- **Immutability & Safety**: Preserves transient flags (e.g. `isOnline`, `errorMessage`) across re-renders without losing current data.
- **Cleaner UI Integration**: UI sections only react to specific property changes using `listenWhen` and `buildWhen`.

---

### 📡 3. Networking, Error Handling & Failure Pipeline
All network requests pass through an abstract `ApiConsumer` contract powered by `DioConsumer`:

```text
DioException ➔ ErrorHandler.handle(error) ➔ Failure (ServerFailure, NetworkFailure, InvalidCityFailure) ➔ UI Friendly Message
```

#### Highlights:
- **No Raw Exceptions in UI**: The UI layer receives sanitized `Failure` objects with localized error messages.
- **Input Validation**: City inputs are validated via regex to catch empty queries or invalid characters before hitting the remote API.

---

### 💾 4. Smart City-Based Offline Caching & Fallback
The app features an offline fallback mechanism (`AppCacheHelper`):
- **Per-City Caching**: Every successful API response is cached locally for that specific city key (e.g. `Cairo`, `Alexandria`).
- **Seamless Offline Fallback**: If internet connectivity is lost or a timeout occurs, the app automatically checks local cache for the requested city and displays cached data seamlessly without crashing or displaying blank error screens.

---

### 🌐 5. Internationalization (Localization - English & Arabic)
Multi-language support (English & Arabic RTL/LTR) is integrated via `easy_localization`:
- **Instant Language Switcher**: Easily toggle between Arabic and English with dynamic locale updates.
- **Localized API Requests**: Language parameter (`lang=ar` / `lang=en`) is passed through the network pipeline to retrieve localized weather condition descriptions directly from the API.
- **Zero Hardcoded Strings**: All UI text keys are centralized in `AppStrings` and translated using `context.tr()`.

---

### 🎨 6. Responsive UI, Design Tokens & Custom High-Res Assets
- **Responsive Layouts**: Scaled across mobile devices using `flutter_screenutil` (`.w`, `.h`, `.sp`, `.r`).
- **Zero Hardcoded Colors**: Strict adherence to design tokens (`AppColors.primary`, `AppColors.glassCardBackground`, `AppColors.error`, `AppColors.success`).
- **Decoupled Asset Mapper (`WeatherIconMapper`)**: Evaluates weather condition texts and day/night state to return high-resolution PNG asset paths (`AppImages.sun`, `AppImages.cloudy`, `AppImages.rain`, `AppImages.cloudyNight`), separating asset decision logic from presentation widgets.
- **Shimmer Skeleton Loading**: `Shimmer` UI replacement for a modern, smooth loading state instead of generic circular spinners.

---

### 🧪 7. Automated Widget Testing
Includes automated widget unit testing (e.g., `WeatherHeaderSectionTest`) validating UI component rendering, state interaction, and localization integration.

---

<img width="421" height="861" alt="Android Emulator - Pixel_5_5554 06_08_2026 01_35_04 ص" src="https://github.com/user-attachments/assets/18e25765-5ad0-4e5a-a960-26e7d7373f32" />

<img width="421" height="861" alt="Android Emulator - Pixel_5_5554 06_08_2026 01_36_20 ص" src="https://github.com/user-attachments/assets/93a7d3eb-5ebd-4424-ad40-165390981356" />

<img width="421" height="861" alt="Android Emulator - Pixel_5_5554 06_08_2026 01_35_36 ص" src="https://github.com/user-attachments/assets/9e4d680d-66dc-43f0-9e46-f9b61b05052e" />

<img width="421" height="861" alt="Android Emulator - Pixel_5_5554 06_08_2026 01_35_53 ص" src="https://github.com/user-attachments/assets/7b7c772f-676a-4026-bf5e-ab116fa02aba" />

<img width="421" height="861" alt="Android Emulator - Pixel_5_5554 06_08_2026 01_35_22 ص" src="https://github.com/user-attachments/assets/4ffc19e5-da61-491e-ba46-5c8d36efcab4" />

## 📦 Packages & Dependencies Rationale

| Package | Purpose & Rationale |
| :--- | :--- |
| `flutter_bloc` | Predictable, event-driven state management separating UI from business logic. |
| `dio` / `pretty_dio_logger` | Powerful HTTP client with interceptors, timeouts, and clean logging. |
| `easy_localization` | Fast, lightweight localization supporting JSON translation files and instant RTL/LTR switching. |
| `flutter_screenutil` | Ensures pixel-perfect responsiveness across various mobile screen sizes. |
| `shimmer` | Provides professional skeleton loading feedback for enhanced UX. |
| `get_it` | High-performance dependency injection (Service Locator) decoupling class instantiations. |
| `nb_utils` | Toast messaging and helper utilities. |

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK `^3.12.0` or higher
- Dart SDK `^3.0.0`

### Installation & Run Steps

1. **Clone the repository:**
   ```bash
   git clone https://github.com/AhmedMohammedSaad/weather_app.git
   cd weather_app
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run automated tests:**
   ```bash
   flutter test
   ```

4. **Run the application:**
   ```bash
   flutter run
   ```

---

## 👨‍💻 Developer
Crafted with ❤️ following **Ahmed Saad**.
