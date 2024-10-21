import SwiftUI

struct Recipe: Identifiable, Codable {
    let id: UUID
    var name: String
    var description: String
    var ingredients: [Ingredient]
    var instructions: String
    var imageData: Data?
    var categories: [String]

    init(name: String, description: String, ingredients: [Ingredient], instructions: String, imageData: Data?, categories: [String]) {
        self.id = UUID()
        self.name = name
        self.description = description
        self.ingredients = ingredients
        self.instructions = instructions
        self.imageData = imageData
        self.categories = categories
    }
}

struct Ingredient: Identifiable, Codable {
    let id = UUID()
    var name: String
    var quantity: String
    var unit: String
}

struct RecipeView: View {
    @State private var recipeName: String = ""
    @State private var recipeDescription: String = ""
    @State private var ingredients: [Ingredient] = []
    @State private var instructions: String = ""
    @State private var recipeImage: Image?
    @State private var recipeImageData: Data?
    @State private var selectedCategories: [String] = []
    @State private var showingSaveConfirmation = false
    @State private var showingImagePicker = false
    @State private var recipes: [Recipe] = []

    private func saveRecipe() {
        let newRecipe = Recipe(
            name: recipeName,
            description: recipeDescription,
            ingredients: ingredients,
            instructions: instructions,
            imageData: recipeImageData,
            categories: selectedCategories
        )
        recipes.append(newRecipe)

       
        if let encodedData = try? JSONEncoder().encode(recipes) {
            UserDefaults.standard.set(encodedData, forKey: "savedRecipes")
        }

        clearForm()
        showingSaveConfirmation = true
    }

    private func clearForm() {
        recipeName = ""
        recipeDescription = ""
        ingredients = []
        instructions = ""
        recipeImage = nil
        recipeImageData = nil
        selectedCategories = []
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Recipe Details")) {
                    TextField("Recipe Name", text: $recipeName)
                    TextField("Description", text: $recipeDescription)
                    TextEditor(text: $instructions)
                        .frame(height: 150)
                    Button("Select Image") {
                        showingImagePicker.toggle()
                    }
                    if let image = recipeImage {
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                    }
                }

                Section(header: Text("Ingredients")) {
                    ForEach(ingredients) { ingredient in
                        HStack {
                            Text(ingredient.name)
                            Spacer()
                            Text("\(ingredient.quantity) \(ingredient.unit)")
                        }
                    }
                    Button("Add Ingredient") {

                    }
                }

                Section {
                    Button("Save Recipe") {
                        saveRecipe()
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                }
            }
            .navigationTitle("Add Recipe")
            .onAppear {
                if let savedData = UserDefaults.standard.data(forKey: "savedRecipes"),
                   let savedRecipes = try? JSONDecoder().decode([Recipe].self, from: savedData) {
                    recipes = savedRecipes
                }
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $recipeImage, imageData: $recipeImageData)
            }
            .alert(isPresented: $showingSaveConfirmation) {
                Alert(
                    title: Text("Recipe Saved"),
                    message: Text("Your recipe has been successfully saved."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}
