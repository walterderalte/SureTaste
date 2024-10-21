import SwiftUI

struct SearchView: View {
    @Binding var recipes: [Recipe]
    @State private var searchText = ""
    @State private var filteredRecipes: [Recipe] = []

    @State private var selectedPreferences: [String] = []
    @State private var selectedIngredients: String?
    @State private var selectedCuisine: String?
    @State private var selectedMealType: String?

    let categoriesPreferences = ["Vegetarian", "Vegan", "Gluten-Free", "Dairy-Free", "Low Carb"]
    let ingredients = ["Salad","Pasta","Rice", "Vegetables", "Meat", "Poultry","Seafood" ]
    let cuisines = ["Asian","Middle East", "Italian", "Mexican", "Indian", "French"]
    let mealTypes = ["Snack", "Condiment","Appetizer", "Main Course", "Dessert"]

    var body: some View {
        NavigationView {
            VStack {
                TextField("Search for a recipe...", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                VStack {
                    DisclosureGroup("Preferences") {
                        VStack {
                            ForEach(categoriesPreferences, id: \.self) { preference in
                                Button(action: {
                                    togglePreference(preference)
                                }) {
                                    HStack {
                                        Text(preference)
                                        Spacer()
                                        if selectedPreferences.contains(preference) {
                                            Image(systemName: "checkmark")
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(8)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    
                    DisclosureGroup("Ingredients") {
                        VStack {
                            ForEach(ingredients, id: \.self) { ingredients in
                                Button(action: {
                                    selectedIngredients = ingredients
                                    filterRecipes()
                                }) {
                                    HStack {
                                        Text(ingredients)
                                        Spacer()
                                        if selectedIngredients == ingredients {
                                            Image(systemName: "checkmark")
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(8)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    
                    DisclosureGroup("International Cuisine") {
                        VStack {
                            ForEach(cuisines, id: \.self) { cuisine in
                                Button(action: {
                                    selectedCuisine = cuisine
                                    filterRecipes()
                                }) {
                                    HStack {
                                        Text(cuisine)
                                        Spacer()
                                        if selectedCuisine == cuisine {
                                            Image(systemName: "checkmark")
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(8)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    
                    DisclosureGroup("Meal Type") {
                        VStack {
                            ForEach(mealTypes, id: \.self) { mealType in
                                Button(action: {
                                    selectedMealType = mealType
                                    filterRecipes()
                                }) {
                                    HStack {
                                        Text(mealType)
                                        Spacer()
                                        if selectedMealType == mealType {
                                            Image(systemName: "checkmark")
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(8)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                }
                .padding(.horizontal)
                
                if filteredRecipes.isEmpty && !searchText.isEmpty {
                    Text("No results found")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List(filteredRecipes) { recipe in
                        NavigationLink(destination: RecipeDetailView_v2(recipe: recipe, recipes: $recipes)) {
                            Text(recipe.name)
                        }
                    }
                }
            }
            .onAppear(perform: filterRecipes)
            .onChange(of: searchText) { _ in
                filterRecipes()
            }
            .navigationTitle("Search Recipes")
        }
    }


    private func togglePreference(_ preference: String) {
        if selectedPreferences.contains(preference) {
            selectedPreferences.removeAll { $0 == preference }
        } else {
            selectedPreferences.append(preference)
        }
        filterRecipes()
    }
    
    private func filterRecipes() {
       
        let initialFilteredRecipes = searchText.isEmpty ? recipes : recipes.filter { recipe in
            recipe.name.localizedCaseInsensitiveContains(searchText) ||
            recipe.ingredients.contains { ingredient in
                ingredient.name.localizedCaseInsensitiveContains(searchText)
            }
        }


        let filteredByPreferences = initialFilteredRecipes.filter { recipe in
            selectedPreferences.isEmpty || !Set(recipe.categories).intersection(selectedPreferences).isEmpty
        }


        let filteredByIngredients = filteredByPreferences.filter { recipe in
            selectedIngredients == nil || recipe.categories.contains(selectedIngredients!)
        }


        let filteredByCuisine = filteredByIngredients.filter { recipe in
            selectedCuisine == nil || recipe.categories.contains(selectedCuisine!)
        }

        let filteredByMealType = filteredByCuisine.filter { recipe in
            selectedMealType == nil || recipe.categories.contains(selectedMealType!)
        }

        filteredRecipes = filteredByMealType
    }

    
    
}


#Preview {
    SearchView(recipes: .constant([]))
}
