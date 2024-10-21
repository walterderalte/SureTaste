# SureTaste
### Video Demo:  https://studio.youtube.com/video/0BtmacpIwrw/edit
-------------------------------------------------------------------
### Description

#### Introduction
SureTaste is a recipe management app designed to help users store, organize, and access their favorite recipes with ease.
The app’s core functionality revolves around the quick input and display of recipes. To facilitate this, SureTaste includes preset units of measurement to ensure a smooth user experience when entering ingredient details. It’s designed for users who want to save time and have a reliable tool to store and retrieve their recipes with minimal effort.
Beyond just saving recipes, SureTaste allows users to add images to visually complement their entries, input step-by-step instructions, and categorize their recipes under relevant labels like cuisine type or dietary preferences. The app's display has been optimized to showcase these details in a clean and organized layout for easy navigation and reference.

The project was developed using Swift and Xcode. SureTaste is developed for iOS, and it incorporates various SwiftUI views, data binding techniques, and responsive layout adjustments to ensure it runs smoothly on different device screen sizes.

#### Project Structure
The SureTaste project is divided into several key components, each represented by a Swift file that defines specific functionalities and user interfaces. Here’s a breakdown of the major files in the project and what they contain:

##### 1. ContentView
The ContentView serves as the main entry point and navigation hub for the SureTaste app. It manages the overall app structure and switches between different sections via a TabView. When the app first launches, a splash screen with the app logo and title, "SureTaste", is displayed for 3 seconds.
Once the splash screen is dismissed, the main app interface appears. It contains three tabs:
I.    StartView: Displays all stored recipes.
II.   AddView: Allows users to add new recipes.
III.  SearchView: Lets users search for specific recipes.

##### 2. StartView
The StartView is designed to display a list of saved recipes, providing users with easy access to their recipe collection. Here’s a breakdown of its functionality:

I.   Navigation: Wrapped in a NavigationView, StartView allows for easy navigation to recipe detail views. Each recipe is displayed as a navigable item in a list, utilizing NavigationLink to transition to the RecipeDetailView_v2.
II.  Recipe List: The main component of StartView is a List that iterates over the recipes array, which is passed in as a binding. Each recipe is represented by a RecipeTile, which provides a visual summary of the recipe.
III. RecipeTile: The RecipeTile struct displays each recipe’s name, description, and an image (if available). If no image is found, a default refrigerator icon is displayed. This layout ensures that recipes are visually appealing and informative at a glance.
IV.  Loading Recipes: On appearing, StartView attempts to load previously saved recipes from UserDefaults. If successful, the recipes array is populated with the saved data, allowing users to see their stored recipes immediately upon entering the view.

3. AddView


4. Searchview


5. DetailView


6. RecipeSchema


7. Image Pick

