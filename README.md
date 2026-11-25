# Graph Neural Network for Fraud Ring Detection

A Flutter application for visualizing and analyzing fraud rings detected using Graph Neural Networks.

## Features

- **Dashboard**: Overview of fraud detection statistics including pending alerts, investigating cases, and resolved alerts
- **Network Graph Visualization**: Interactive visual representation of fraud nodes and their connections
- **Alerts Management**: View and filter fraud alerts by status (pending, investigating, resolved)
- **Transaction Analysis**: Monitor flagged and cleared transactions with detailed information
- **Mock Data Service**: Simulated GNN-based fraud detection with realistic data patterns

## Getting Started

### Prerequisites

- Flutter SDK (3.11.0 or higher)
- Dart SDK
- Android Studio / Xcode (for mobile development)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/Harshithpalan/Graph-Neural-Network-for-Fraud-Ring-Detection.git
cd fraud_ring_detection
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Project Structure

```
lib/
├── models/           # Data models (FraudAlert, FraudRing, FraudNode, Transaction)
├── screens/          # UI screens (Dashboard, Graph, Alerts, Transactions)
├── widgets/          # Reusable UI components
├── services/         # Business logic and data services
└── utils/            # Utility classes (AppState for state management)
```

## Dependencies

- `provider`: State management
- `fl_chart`: Chart visualization
- `cached_network_image`: Image caching

## Technologies

- Flutter
- Dart
- Provider (State Management)
- Material Design 3

## Future Enhancements

- Integration with real GNN backend API
- Real-time fraud detection updates
- Advanced graph visualization with interactive features
- Export functionality for reports
- User authentication and role-based access
