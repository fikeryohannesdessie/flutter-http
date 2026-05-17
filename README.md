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

## Installation & Setup

### Prerequisites
- Flutter SDK (latest version)
- Dart 3.0 or higher
- Android emulator or physical device / iOS simulator

### Steps

1. **Navigate to the project directory**
   ```bash
   cd "Flutter http"
   ```

2. **Get dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```

4. **Build for release** (Optional)
   ```bash
   flutter build apk      # For Android
   flutter build ios      # For iOS
   ```

## Dependencies

```yaml
provider: ^6.0.0      # State management
http: ^1.1.0          # HTTP client for API calls
intl: ^0.19.0         # Internationalization utilities
```

## API Reference

The app uses the **DummyJSON API** endpoints:

- **GET** `/products` - Fetch all products (limit: 100)
- **GET** `/products/:id` - Fetch a specific product
- **POST** `/products/add` - Create a new product
- **PUT** `/products/:id` - Update a product
- **DELETE** `/products/:id` - Delete a product

Base URL: `https://dummyjson.com`

## Key Components

### Models
**Product**: Contains product information (id, title, description, price, stock, category, rating)

### Services
**ApiService**: Handles all API communication with proper error handling

### Providers
**ProductProvider**: Manages product state, handles loading/error states, and provides actions for CRUD operations

### Screens
1. **HomeScreen**: Displays product list with search functionality and action menu
2. **ProductDetailScreen**: Shows complete product information
3. **ProductFormScreen**: Form for creating and updating products

### Widgets
- **LoadingWidget**: Reusable loading indicator
- **ErrorWidget**: Error display with retry functionality
- **ProductCard**: Product list item with actions

## Features in Detail

### Search Functionality
- Real-time search by product title and category
- Case-insensitive matching
- Instant results filtering

### Error Handling
- Network error handling
- Validation for form inputs
- User-friendly error messages
- Retry functionality

### Loading States
- Loading indicators during API calls
- Disabled buttons during operations
- Proper state management during async operations

### UI/UX Design
- Clean white background with blue (#2563EB) primary color
- Consistent color scheme throughout the app
- Intuitive navigation and user interactions
- Material Design 3 compliance

## User Guide

### Viewing Products
1. Launch the app to see all products from DummyJSON
2. Use the search bar to filter products by name or category
3. Tap a product card to view full details

### Creating a Product
1. Tap the floating action button (+ icon)
2. Fill in all required fields
3. Tap "Create Product" button
4. New product will be added to the list

### Updating a Product
1. Tap the menu icon (three dots) on a product card
2. Select "Edit"
3. Modify the product details
4. Tap "Update Product" button

### Deleting a Product
1. Tap the menu icon (three dots) on a product card
2. Select "Delete"
3. Confirm deletion in the dialog
4. Product will be removed from the list

## Screenshots

### Home Screen
- Product list with search functionality
- Product cards displaying key information
- Quick access to edit and delete actions

### Product Details
- Complete product information
- Price and stock details
- Product rating and category
- High-quality presentation

### Create/Edit Product
- Clean form layout
- Input validation
- Loading states during submission
- Successful operation feedback

## Best Practices Implemented

✅ Clean Architecture principles
✅ Separation of concerns (Models, Services, Providers, Screens)
✅ Proper error handling and user feedback
✅ Loading states for better UX
✅ Input validation
✅ Responsive design
✅ Code reusability with custom widgets
✅ Effective state management with Provider
✅ API best practices with proper HTTP handling

## Troubleshooting

### App doesn't start
- Ensure Flutter SDK is properly installed: `flutter doctor`
- Run `flutter clean` and `flutter pub get`
- Check internet connection for API calls

### API errors
- Verify your internet connection
- Check DummyJSON API status
- Review error messages in the console

### UI issues
- Ensure you're using the latest Flutter version
- Run `flutter pub upgrade`
- Clear app cache: `flutter clean`

## Future Enhancements

- 🔒 User authentication
- ⭐ Favorites/Wishlist functionality
- 🛒 Shopping cart feature
- 💳 Payment integration
- 📝 Product reviews and ratings
- 🔔 Push notifications
- 🌙 Dark mode support
- 📱 Offline support with local database

## License

This project is open source and available for educational purposes.

## Support

For questions or issues, please check the Flutter documentation or contact the development team.

---

**Happy coding! 🚀**
