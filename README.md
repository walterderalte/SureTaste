# SureTaste
### Video Demo:  https://studio.youtube.com/video/0BtmacpIwrw/edit
-------------------------------------------------------------------
## Description

### Introduction
SureTaste is a recipe management app designed to help users store, organize, and access their favorite recipes with ease.
The app’s core functionality revolves around the quick input and display of recipes. To facilitate this, SureTaste includes preset units of measurement to ensure a smooth user experience when entering ingredient details. It’s designed for users who want to save time and have a reliable tool to store and retrieve their recipes with minimal effort.
Beyond just saving recipes, SureTaste allows users to add images to visually complement their entries, input step-by-step instructions, and categorize their recipes under relevant labels like cuisine type or dietary preferences. The app's display has been optimized to showcase these details in a clean and organized layout for easy navigation and reference.

The project was developed using Swift and Xcode. SureTaste is developed for iOS, and it incorporates various SwiftUI views, data binding techniques, and responsive layout adjustments to ensure it runs smoothly on different device screen sizes.

### Project Structure
The SureTaste project is divided into several key components, each represented by a Swift file that defines specific functionalities and user interfaces. Here’s a breakdown of the major files in the project and what they contain:

#### 1. ContentView
The ContentView serves as the main entry point and navigation hub for the SureTaste app. It manages the overall app structure and switches between different sections via a TabView. When the app first launches, a splash screen with the app logo and title, "SureTaste", is displayed for 3 seconds.
Once the splash screen is dismissed, the main app interface appears. It contains three tabs:
- StartView: Displays all stored recipes.
- AddView: Allows users to add new recipes.
- SearchView: Lets users search for specific recipes.

#### 2. StartView
The StartView is designed to display a list of saved recipes, providing users with easy access to their recipe collection. Here’s a breakdown of its functionality:

- Navigation: Wrapped in a NavigationView, StartView allows for easy navigation to recipe detail views. Each recipe is displayed as a navigable item in a list, utilizing NavigationLink to transition to the RecipeDetailView_v2.
- Recipe List: The main component of StartView is a List that iterates over the recipes array, which is passed in as a binding. Each recipe is represented by a RecipeTile, which provides a visual summary of the recipe.
- RecipeTile: The RecipeTile struct displays each recipe’s name, description, and an image (if available). If no image is found, a default refrigerator icon is displayed. This layout ensures that recipes are visually appealing and informative at a glance.
- Loading Recipes: On appearing, StartView attempts to load previously saved recipes from UserDefaults. If successful, the recipes array is populated with the saved data, allowing users to see their stored recipes immediately upon entering the view.

#### 3. AddView
The AddView provides a user-friendly interface for adding new recipes to the SureTaste app. This view allows users to easily input all necessary information about a recipe, including ingredients and preparation steps.
Here are the main functions:
- Recipe Image: Users can select an image for their recipe or use a default graphic. This is done via a "Select Image" button.
- Recipe Name and Description: Input fields enable users to add a recipe name and a short description.
- Ingredients: Users can create a list of ingredients for their recipe. Ingredients can be added with a name, quantity, and unit of measure. The function of being able to enter ingredients in a fixed scheme and select a preset unit of measurement was particularly important to me. The user should be able to add ingredients as quickly as possible.  
- Edit and Delete: Ingredients can be edited or deleted.
- Instructions: A text editor allows users to capture the preparation steps for the recipe.
- Categories: Users can assign their recipe to various categories to enhance discoverability.
- Save Recipe: A "Save Recipe" button allows for saving the recipe. Upon successful saving, a confirmation message is displayed.
User Interface

The recipes are stored locally in UserDefaults. JSON encoding is used to efficiently save and load recipes.

#### 4. Searchview
The SearchView allows users to search and filter recipes within the SureTaste app, providing a user-friendly interface for discovering new dishes.

Key Features

- Search Functionality: Users can input search terms to find recipes by name or ingredient, with results updating dynamically.
- Filter Options: Users can refine their search using various filters, including dietary preferences, specific ingredients, cuisines, and meal types. The filters are presented in expandable sections to keep the interface organized.
- Results Display: Matching recipes are displayed in a list format, where each recipe name is a clickable link that navigates to the RecipeDetailView_v2.
- User Feedback: If no results match the search criteria, a message stating "No results found" is shown.


The view is wrapped in a NavigationView for easy navigation throughout the app.
The filters are organized into DisclosureGroup components, enhancing usability.

The view uses state management with @Binding for the recipes array and @State for user input and filtered results.
The filtering logic is encapsulated in the filterRecipes function, refining the recipe list based on user selections.

#### 5. DetailView
The RecipeDetailView_v2 presents the details of a selected recipe, providing users with comprehensive information in a well-structured layout.

- Image Display: The view displays the recipe's image, showing a placeholder if the image data is unavailable. The image is resized to maintain consistency in the layout.
- Recipe Name and Description: The recipe name is prominently featured with a bold title, followed by a description in a secondary font style.
- Ingredients List: A structured table layout displays the ingredients, including quantity, unit, and name. This section includes headers and dynamically adjusts to fit the screen.
- Instructions: Users can read detailed instructions for preparing the recipe, enhancing the usability of the view.
- Tags: The categories associated with the recipe are presented as tags, allowing users to see relevant dietary or cuisine information.

#### 6. RecipeSchema
The Recipe schema represents a structured model for storing recipe data in a SwiftUI application. It conforms to the Identifiable and Codable protocols, enabling unique identification and easy encoding/decoding for storage. Each recipe includes an id of type UUID, a name, a description, a list of ingredients, instructions, optional imageData for a recipe image, and an array of categories for classification. The Ingredient struct, which is also identifiable and codable, consists of an id, name, quantity, and unit, allowing for detailed ingredient tracking. Together, these models facilitate the creation, storage, and retrieval of recipes within the app.

#### 7. Image Pick
The ImagePicker struct is a SwiftUI component that facilitates the selection of images from the user's photo library. It conforms to the UIViewControllerRepresentable protocol, enabling the integration of a UIKit UIImagePickerController within a SwiftUI view. The ImagePicker has two bindings: image, which holds the selected image as a SwiftUI Image, and imageData, which stores the image data in Data format for potential further processing.

#### 8. Data Storage
The current data management approach uses JSON (JavaScript Object Notation) to store recipes in the app. Recipes are encoded into JSON format and saved to UserDefaults, which allows for easy retrieval and persistence. This method works well for a small number of recipes, as it is straightforward to implement and manage.
However, as the number of recipes increases, this approach may become cumbersome. Storing a large dataset in UserDefaults can lead to performance issues, as it is not designed for extensive data storage. Additionally, searching, filtering, and managing a growing list of recipes could become more complex with JSON files. For scalability, it may be beneficial to consider a more robust data management solution, such as a local database (e.g., Core Data or SQLite) or cloud storage, to handle larger volumes of data efficiently.
