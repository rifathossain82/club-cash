# FinTrack - Flutter Project

## Overview
FinTrack is a Flutter-based mobile application designed to manage club cash transactions. The backend of the application is powered by Firebase. Users can add members directly from their phone contacts, and after every transaction, each user receives a confirmation message displaying the transaction amount and the current net balance.

<br>

## Features  
- Add Members: Easily add new members from your phone contacts and customize them.
- Transaction: Manage Cash In and Cash Out transactions.
- Message Template: Customize and manage message templates for transaction notifications.
- Message History: View the history of all sent transaction messages.
- User Authentication:
    - Login: Secure login for user.
    - Logout: Secure logout to ensure account safety.
    - Change Password: Option to change the password for better security.
    - Forgot Password: Reset password functionality to help user regain access to his/her account.
- Settings: Customize app settings as per user preferences.

<br>

## Screenshots

<table>
  <tr>
    <td><img src="https://github.com/olexale/flutter_roadmap/assets/88751768/b1e35fc6-c6bb-45bd-931d-c237402498dd" alt="Screenshot_7" width="200" height="400"></td>
    <td><img src="https://github.com/olexale/flutter_roadmap/assets/88751768/2cf739ab-5f8e-4379-bc35-12335c5aa65d" alt="Screenshot_6" width="200" height="400"></td>
    <td><img src="https://github.com/olexale/flutter_roadmap/assets/88751768/8229e503-1e9e-473e-b2a2-5f1adc5c3bc3" alt="Screenshot_8" width="200" height="400"></td>
  </tr>
  <tr>
    <td><img src="https://github.com/olexale/flutter_roadmap/assets/88751768/3c701265-4645-4859-b073-36e7967e6ded" alt="Screenshot_1" width="200" height="400"></td>
    <td><img src="https://github.com/olexale/flutter_roadmap/assets/88751768/dc0e9eb1-96dc-40b8-b172-4ffc3f3c6947" alt="Screenshot_9" width="200" height="400"></td>
    <td><img src="https://github.com/olexale/flutter_roadmap/assets/88751768/9fbb6a0a-1712-4656-918d-1a7e7aa31f77" alt="Screenshot_2" width="200" height="400"></td>
  </tr>
  <tr>
    <td><img src="https://github.com/olexale/flutter_roadmap/assets/88751768/cb96f33f-0b5f-42ea-a87b-c9c27061d49e" alt="Screenshot_3" width="200" height="400"></td>
    <td><img src="https://github.com/olexale/flutter_roadmap/assets/88751768/583a88cc-544e-492b-a79c-3d93db5df666" alt="Screenshot_4" width="200" height="400"></td>
    <td><img src="https://github.com/olexale/flutter_roadmap/assets/88751768/89a988f4-6217-4a18-b2fa-aa809dabf544" alt="Screenshot_5" width="200" height="400"></td>
  </tr>
</table>

<br>

## Project Structure

```css
club_cash/
├── assets/
│   ├── images/
│   └── icons/
├── lib/
│   ├── src/
│   │   ├── core/
│   │   └── features/
│   └── main.dart
├── test/
│   ├── widget_tests/
│   ├── unit_tests/
│   └── integration_tests/
├── web/
├── desktop/
│   ├── windows/
│   ├── macos/
│   └── linux/
├── pubspec.yaml
└── README.md
```

<br>  

## Getting Started
To get a local copy up and running follow these simple steps.

### Prerequisites
Ensure you have the following installed:
- Flutter SDK 3.3.9
- Dart SDK 2.18.5

### Installation
1. **Clone the repository:**
   ```dart
   git clone https://github.com/rifathossain82/club-cash.git
   cd club-cash
   ``` 

2. **Install dependencies:**
   ```dart
   flutter pub get
   ```

3. **Run the application :**
    ```dart
    flutter run
    ```

<br>

### Contributing
Contributions are not allowed due to company restrictions.

<br>

### License
Distributed under the MIT License. See **LICENSE** for more information.

<br>

### Contact
Name: Rifat Hossain  
E-mail: appdev.rifathossain@gmail.com    