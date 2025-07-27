# CookTok 🍳

A smart grocery management app with AI-powered recipe recommendations.

## 🎥 Demo Video
[![CookTok Demo](https://img.youtube.com/vi/MVAb56EylyI/0.jpg)](https://youtube.com/shorts/MVAb56EylyI)

*Click the image above to watch the demo video*

## About

The CookTokApp helps users manage their groceries with intelligent features. When you're food shopping, you can create a list. Once you've purchased items, clicking on them in the shopping list automatically saves them to your refrigerator inventory. This refrigerator list displays all the ingredients currently in your fridge. To help you keep track, items whose expiration date has passed will automatically turn red.

**New Feature**: AI-powered recipe recommendations using Google's Gemini AI! Get personalized recipe suggestions based on the ingredients in your refrigerator.

## Features

### 🛒 Grocery Management
- Create and manage shopping lists
- Track expiration dates with visual indicators
- Categorize items (Produce, Meat, Seafood, Sauce, Dry, Dairy, Junk, Etc.)
- Automatic inventory management

### 🤖 AI Recipe Recommendations
- **Smart Recipe Generation**: Get recipe suggestions based on available ingredients
- **Diverse Cooking Styles**: Korean, Western, Chinese, Japanese, Fusion, Healthy, Simple, and High-end cuisine
- **Bilingual Support**: Korean and English language support
- **Personalized Experience**: AI learns from your preferences and suggests varied recipes

### 🌍 Multi-language Support
- Korean and English interface
- Language preference saved per user
- Seamless language switching

## Pages

### OnBoardingPage
- Welcome screen with app introduction
- Language toggle (Korean/English)
- Navigation to main shopping interface

### ShoppingListPage
- **Form Section**: Fill out item details and press "Save" to add items to your shopping list
- **List Section**: View all items in your shopping list
- **Navigation**: Tapping the refrigerator button on the top right navigates to the "ItemListPage"
- **Purchase Action**: Clicking on a purchased item deletes it from the shopping list and moves it to the "ItemListPage"
- **Language Toggle**: Switch between Korean and English interface

### ItemListPage
- **Inventory Display**: Shows all items currently in your refrigerator
- **Category Filtering**: Select categories to filter items (Produce, Meat, Seafood, etc.)
- **Item Management**: Click on items to modify expiration date and category, with delete option
- **AI Recipe Button**: "GET RECIPE" button to generate AI-powered recipe suggestions
- **Expiration Tracking**: Items past expiration date turn red for easy identification

### AI Recipe View
- **Ingredient Selection**: Choose from available ingredients in your refrigerator
- **Recipe Generation**: AI creates personalized recipes based on selected ingredients
- **Formatted Display**: Beautifully formatted recipe cards with:
  - Recipe name
  - Ingredients and amounts
  - Cooking time
  - Step-by-step instructions
  - Cooking tips
- **Diverse Suggestions**: Multiple recipe options with different cooking styles

## Technical Features

### AI Integration
- **Google Gemini AI**: Powered by Google's latest AI model
- **Smart Prompting**: Optimized prompts for faster and more diverse responses
- **Error Handling**: Robust error handling for network issues
- **Response Formatting**: Structured recipe display with proper formatting

### Data Management
- **SwiftData**: Modern data persistence framework
- **Real-time Updates**: Instant UI updates when data changes
- **Category Management**: Efficient item categorization system

### User Experience
- **Responsive Design**: Optimized for different screen sizes
- **Smooth Animations**: Fluid transitions and interactions
- **Intuitive Navigation**: Easy-to-use interface with clear navigation

## Setup

1. Clone the repository
2. Open `CookTok.xcworkspace` in Xcode
3. Configure Firebase settings (add your `GoogleService-Info.plist`)
4. Enable Vertex AI API in Google Cloud Console
5. Build and run the project

## Requirements

- iOS 17.0+
- Xcode 15.0+
- Swift 5.9+
- Firebase AI SDK
- Google Cloud Vertex AI API access

## Dependencies

- Firebase AI
- Firebase Vertex AI
- SwiftData
- SwiftUI

## Contributing

Feel free to submit issues and enhancement requests!

## License

This project is licensed under the MIT License. 