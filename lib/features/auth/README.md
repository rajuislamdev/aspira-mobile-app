# Auth Module - Clean Architecture

This module implements the Authentication feature following clean architecture principles with clear separation of concerns across three layers: Domain, Data, and Presentation.

## Directory Structure

```
lib/features/auth/
├── domain/                          # Business Logic Layer
│   ├── entities/
│   │   └── user_entity.dart        # Core user entity
│   ├── repositories/
│   │   └── auth_repository.dart    # Repository interface (contract)
│   └── usecases/
│       ├── login_usecase.dart
│       ├── register_usecase.dart
│       ├── login_with_google_usecase.dart
│       ├── get_google_id_token_usecase.dart
│       └── update_profile_usecase.dart
│
├── data/                            # Data Access Layer
│   ├── datasources/
│   │   └── auth_remote_data_source.dart  # API calls & Google Sign-In
│   ├── models/
│   │   └── user_response_model.dart      # DTO from API response
│   └── repositories/
│       └── auth_repository_impl.dart     # Repository implementation
│
└── presentation/                    # UI Layer
    ├── providers/
    │   └── auth_providers.dart      # Riverpod dependencies (DI setup)
    ├── screens/
    │   ├── login_screen.dart
    │   └── login_with_email_screen.dart
    └── viewmodels/
        ├── login_view_model.dart
        ├── login_with_google_view_model.dart
        └── update_profile_view_model.dart
```

## Layer Responsibilities

### Domain Layer ✨

- **Entities**: Pure Dart objects representing core business concepts (UserEntity)
- **Repositories**: Abstract interfaces defining what data operations are needed
- **Use Cases**: Encapsulate specific business rules and logic

### Data Layer 🔌

- **Data Sources**: Handle communication with external services (APIs, local storage)
- **Models**: Convert API responses to domain entities (UserResponseModel)
- **Repositories**: Implement the domain repository interfaces, handling error mapping

### Presentation Layer 🎨

- **Providers**: Riverpod setup for dependency injection
- **View Models**: Manage UI state using Riverpod providers
- **Screens**: UI widgets that consume and react to view model state

## Data Flow

```
UI Layer (Screen)
    ↓
View Model (using Use Cases)
    ↓
Use Case (executing business logic)
    ↓
Repository (accessing data)
    ↓
Remote Data Source (API calls)
    ↓
Server
```

## Error Handling

- Server errors are caught and converted to `Failure` objects
- Failures are propagated through the `Result` type (Either from dartz)
- UI layer displays user-friendly error messages from failures

## Key Benefits

1. **Maintainability**: Clear separation of concerns makes code easier to test and modify
2. **Scalability**: Easy to add new features without affecting existing code
3. **Testability**: Each layer can be tested independently
4. **Dependency Inversion**: UI depends on abstractions, not concrete implementations
5. **Reusability**: Use cases can be reused across different UI components

## Backward Compatibility

Old import paths are maintained as re-exports for gradual migration:

- `lib/view_models/auth/` → re-exports from `lib/features/auth/presentation/viewmodels/`
- `lib/screens/login_screen.dart` → re-exports from new location
- `lib/repositories/auth_repo/` → re-exports from new structure

## Migration Guide

When updating existing code:

**Old way:**

```dart
import 'package:aspira/view_models/auth/login_view_model.dart';
import 'package:aspira/repositories/auth_repo/auth_repo_impl.dart';
import 'package:aspira/screens/login_screen.dart';
```

**New way:**

```dart
import 'package:aspira/features/auth/presentation/viewmodels/login_view_model.dart';
import 'package:aspira/features/auth/presentation/providers/auth_providers.dart';
import 'package:aspira/features/auth/presentation/screens/login_screen.dart';
```

## Future Enhancements

- [ ] Add unit tests for use cases
- [ ] Add integration tests for data layer
- [ ] Add widget tests for screens
- [ ] Implement password reset use case
- [ ] Add analytics tracking
- [ ] Implement token refresh logic
- [ ] Add biometric authentication
