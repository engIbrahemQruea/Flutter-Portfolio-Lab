# 🍕 Pizza Ordering System - Flutter & Provider

A sophisticated, desktop-responsive pizza ordering application built with **Flutter**. This project demonstrates the transition from imperative programming (C# Style) to modern **Declarative State Management**.

## 🏗️ Architectural Highlights

* **State Management:** Implemented using `Provider` and `ChangeNotifier` to ensure a single source of truth.
* **Component-Based UI:** Modularized widgets (Size, Toppings, Crust, Summary) for better maintainability and clean code.
* **Responsive Layout:** Used `Row`, `Expanded`, and `Wrap` to ensure the UI adapts to different window sizes on Windows/Web.
* **Logic Decoupling:** Business logic (pricing, validation) is completely separated from the UI layer in `PizzaProvider`.

## 🛠️ Technical Implementation

* **Enums & Maps:** Leveraged Dart Enums and Map structures for type-safe price calculations.
* **Optimized Rebuilds:** Used `listen: false` and grouped actions to minimize widget rebuild cycles.
* **UI/UX Features:** Added confirmation dialogs, `AbsorbPointer` for flow control, and `RichText` for dynamic summaries.

## 🚀 How to Run
1. Clone the repository.
2. Run `flutter pub get`.
3. Run `flutter run -d windows` (or your preferred platform).