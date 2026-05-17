## Student Information
- Name: Fiker Yohannes
- ID: UGR/4617/16
- Section: 2

# Product Store - Flutter CRUD Application

A modern Flutter application that demonstrates complete CRUD (Create, Read, Update, Delete) operations using the **DummyJSON API** with **Provider** state management and clean architecture principles.

## Features

✅ **Complete CRUD Operations**
- **Create**: Add new products with all required details
- **Read**: View all products and detailed product information
- **Update**: Edit existing products
- **Delete**: Remove products from the store

✅ **State Management**
- Provider pattern for reactive state management
- Proper error handling and loading states
- Clean separation of concerns

✅ **Modern UI/UX**
- White background with blue accent colors
- Responsive design for all screen sizes
- Loading indicators and error states
- Smooth navigation between screens
- Search functionality for quick product lookup

✅ **API Integration**
- RESTful API calls using the `http` package
- Real-time data sync with DummyJSON API
- Proper error handling and user feedback
- JSON serialization/deserialization

## Project Structure

```
lib/
├── main.dart                    # App entry point
├── models/
│   └── product.dart            # Product data model
├── services/
│   └── api_service.dart        # API communication layer
├── providers/
│   └── product_provider.dart   # Provider for state management
├── screens/
│   ├── home_screen.dart        # Main product list screen
│   ├── product_detail_screen.dart   # Product details view
│   └── product_form_screen.dart     # Create/Update product
└── widgets/
    └── common_widgets.dart     # Reusable UI components
```



---


## Packages Used
- provider
- http
- intl

---

## API Used
https://dummyjson.com

---


## Screenshots

### Home Screen
![Home](Flutter%20http/Screenshots/Homescreen.png)

### Create Product
![Create](Flutter%20http/Screenshots/CREATE.png)

### Update Product
![Update](Flutter%20http/Screenshots/UPDATE.png)

### Delete Product
![Delete](Flutter%20http/Screenshots/DELETE.png)

---

## How To Run

```bash
flutter pub get
flutter run
```

---

## Notes
- The project uses the DummyJSON API for testing CRUD operations.
- The application follows a clean and maintainable Flutter project structure.
- CRUD operations are handled using Provider state management.

---



