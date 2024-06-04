# Club Cash - Flutter Project

## Overview
Club Cash is a Flutter-based mobile application designed to manage club cash transactions. The backend of the application is powered by Firebase. Users can add members directly from their phone contacts, and after every transaction, each user receives a confirmation message displaying the transaction amount and the current net balance.

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
Your Name - appdev.rifathossain@gmail.com  
Project Link: https://github.com/rifathossain82/club-cash.git

***Note:*** You can copy and paste this directly into your `README.md` file.