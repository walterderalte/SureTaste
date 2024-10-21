import SwiftUI

struct AddView: View {
    @Binding var recipes: [Recipe]
    @State private var recipeImage: Image? = Image(systemName: "photo.circle")
    @State private var recipeImageData: Data?
    @State private var recipeName = ""
    @State private var recipeDescription = ""
    @State private var ingredients: [Ingredient] = []
    @State private var newIngredientName = ""
    @State private var newIngredientQuantity = ""
    @State private var newIngredientUnit = ""
    @State private var instructions = ""
    @State private var showingImagePicker = false
    @State private var showingUnitPicker = false
    @State private var editingIngredientIndex: Int? = nil
    @State private var showingSaveConfirmation = false
    @State private var selectedCategories: [String] = []
    @Environment(\.presentationMode) var presentationMode

    let categories_int = ["Asian","Middle East", "Italian", "Mexican", "Indian", "French"]
    let categories_ing = ["Salad","Pasta","Rice", "Vegetables", "Meat", "Poultry","Seafood" ]
    let categories_meal = ["Snack", "Condiment","Appetizer", "Main Course", "Dessert"]
    let categories_pref = ["Vegetarian", "Vegan", "Gluten-Free", "Dairy-Free", "Low Carb"]

    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        VStack {
                            recipeImage?
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                            Button("Select Image") {
                                showingImagePicker = true
                            }
                            .padding(.top, 5)
                        }
                        .frame(width: 100)
                        .foregroundColor(.blue)

                        VStack(alignment: .leading) {
                            TextField("Recipe Name", text: $recipeName)
                                .font(.headline)

                            TextField("Description", text: $recipeDescription)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.vertical, 10)
                }

             
                Section(header: Text("Ingredients")) {
                    ForEach(ingredients.indices, id: \.self) { index in
                        HStack {
                            Text(ingredients[index].name)
                                .fontWeight(.medium)
                            Spacer()
                            Text("\(ingredients[index].quantity) \(ingredients[index].unit)")
                                .foregroundColor(.gray)
                        }
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                        .contextMenu {
                            Button("Edit") {
                                editIngredient(at: index)
                            }
                            Button("Delete", role: .destructive) {
                                deleteIngredient(at: index)
                            }
                        }
                    }
                    .onDelete(perform: deleteIngredients)

                    VStack(spacing: 10) {
                        TextField("Ingredient", text: $newIngredientName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())

                        HStack {
                            TextField("Quantity", text: $newIngredientQuantity)
                                .keyboardType(.decimalPad)
                                .textFieldStyle(RoundedBorderTextFieldStyle())

                            Button(action: {
                                showingUnitPicker = true
                            }) {
                                Text(newIngredientUnit.isEmpty ? "Select Unit" : newIngredientUnit)
                                    .padding(8)
                                    .frame(minWidth: 100)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(8)
                            }
                            .sheet(isPresented: $showingUnitPicker) {
                                UnitPicker(selectedUnit: $newIngredientUnit) {
                                    showingUnitPicker = false
                                }
                            }
                        }

                        Button(action: addIngredient) {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                Text(editingIngredientIndex == nil ? "Add Ingredient" : "Update Ingredient")
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(8)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .disabled(newIngredientName.isEmpty || newIngredientQuantity.isEmpty || newIngredientUnit.isEmpty)
                    }
                    .padding(.vertical, 5)
                }

         
                Section(header: Text("Instructions")) {
                    TextEditor(text: $instructions)
                        .frame(height: 150)
                }


                Section(header: Text("International Cuisine")) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(categories_int, id: \.self) { category in
                                Button(action: {
                                    toggleCategorySelection(category)
                                }) {
                                    Text("#\(category)")
                                        .padding(6)
                                        .background(selectedCategories.contains(category) ? Color.blue : Color.gray.opacity(0.2))
                                        .foregroundColor(selectedCategories.contains(category) ? .white : .black)
                                        .cornerRadius(10)
                                }
                            }
                        }
                    }
                    .padding(.vertical, 5)
                }

                Section(header: Text("Meal Type")) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(categories_meal, id: \.self) { category in
                                Button(action: {
                                    toggleCategorySelection(category)
                                }) {
                                    Text("#\(category)")
                                        .padding(6)
                                        .background(selectedCategories.contains(category) ? Color.blue : Color.gray.opacity(0.2))
                                        .foregroundColor(selectedCategories.contains(category) ? .white : .black)
                                        .cornerRadius(10)
                                }
                            }
                        }
                    }
                    .padding(.vertical, 5)
                }

                Section(header: Text("Preferences")) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(categories_pref, id: \.self) { category in
                                Button(action: {
                                    toggleCategorySelection(category)
                                }) {
                                    Text("#\(category)")
                                        .padding(6)
                                        .background(selectedCategories.contains(category) ? Color.blue : Color.gray.opacity(0.2))
                                        .foregroundColor(selectedCategories.contains(category) ? .white : .black)
                                        .cornerRadius(10)
                                }
                            }
                        }
                    }
                    .padding(.vertical, 5)
                }

                Section(header: Text("Ingredients")) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(categories_ing, id: \.self) { category in
                                Button(action: {
                                    toggleCategorySelection(category)
                                }) {
                                    Text("#\(category)")
                                        .padding(6)
                                        .background(selectedCategories.contains(category) ? Color.blue : Color.gray.opacity(0.2))
                                        .foregroundColor(selectedCategories.contains(category) ? .white : .black)
                                        .cornerRadius(10)
                                }
                            }
                        }
                    }
                    .padding(.vertical, 5)
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
                        dismissButton: .default(Text("OK")) {
                            presentationMode.wrappedValue.dismiss()
                        }
                    )
                }
        }
    }

    private func toggleCategorySelection(_ category: String) {
        if let index = selectedCategories.firstIndex(of: category) {
            selectedCategories.remove(at: index)
        } else {
            selectedCategories.append(category)
        }
    }

    private func addIngredient() {
        guard !newIngredientName.isEmpty && !newIngredientQuantity.isEmpty && !newIngredientUnit.isEmpty else { return }

        if let index = editingIngredientIndex {
            ingredients[index] = Ingredient(name: newIngredientName, quantity: newIngredientQuantity, unit: newIngredientUnit)
            editingIngredientIndex = nil
        } else {
            let newIngredient = Ingredient(name: newIngredientName, quantity: newIngredientQuantity, unit: newIngredientUnit)
            ingredients.append(newIngredient)
        }

        clearIngredientFields()
        showingUnitPicker = false
    }

    private func editIngredient(at index: Int) {
        let ingredient = ingredients[index]
        newIngredientName = ingredient.name
        newIngredientQuantity = ingredient.quantity
        newIngredientUnit = ingredient.unit
        editingIngredientIndex = index
    }

    private func deleteIngredient(at index: Int) {
        ingredients.remove(at: index)
    }

    private func deleteIngredients(at offsets: IndexSet) {
        ingredients.remove(atOffsets: offsets)
    }

    private func clearIngredientFields() {
        newIngredientName = ""
        newIngredientQuantity = ""
        newIngredientUnit = ""
    }

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
        newIngredientName = ""
        newIngredientQuantity = ""
        newIngredientUnit = ""
        instructions = ""
        recipeImage = Image(systemName: "photo.circle")
        selectedCategories = []
    }

}

struct UnitPicker: View {
    @Binding var selectedUnit: String
    var onSelect: () -> Void

    let weightUnits = ["g", "kg", "oz", "lb"]
    let volumeUnits = ["ml", "l", "cup", "tsp", "tbsp"]
    let otherUnits = ["package","piece(s)","pinch","stalk(s)","clove(s)"]

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Weight Units")) {
                    ForEach(weightUnits, id: \.self) { unit in
                        Button(action: {
                            selectedUnit = unit
                            onSelect()
                        }) {
                            Text(unit)
                        }
                    }
                }
                Section(header: Text("Volume Units")) {
                    ForEach(volumeUnits, id: \.self) { unit in
                        Button(action: {
                            selectedUnit = unit
                            onSelect()
                        }) {
                            Text(unit)
                        }
                    }
                }
                Section(header: Text("Other Units")) {
                    ForEach(otherUnits, id: \.self) { unit in
                        Button(action: {
                            selectedUnit = unit
                            onSelect()
                        }) {
                            Text(unit)
                        }
                    }
                }
            }
            .navigationTitle("Select Unit")
            .navigationBarItems(trailing: Button("Done") {
                onSelect()
            })
        }
    }
}

#Preview {
    AddView(recipes: .constant([]))
}
