import SwiftUI

struct StartView: View {
    @Binding var recipes: [Recipe]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(recipes) { recipe in
                    NavigationLink(destination: RecipeDetailView_v2(recipe: recipe, recipes: $recipes)) {
                        RecipeTile(recipe: recipe)
                            .listRowInsets(EdgeInsets())
                    }
                }
            }
            .navigationTitle("Your Recipes")
            .onAppear(perform: loadRecipes)
        }
    }
    
    private func loadRecipes() {
        if let savedData = UserDefaults.standard.data(forKey: "savedRecipes"),
           let savedRecipes = try? JSONDecoder().decode([Recipe].self, from: savedData) {
            recipes = savedRecipes
        }
    }
}

struct RecipeTile: View {
    var recipe: Recipe
    
    var body: some View {
        HStack {
            if let imageData = recipe.imageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .cornerRadius(8)
                    .padding(4)
            } else {
 
                Image(systemName: "refrigerator")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .cornerRadius(8)
                    .padding(4)
            }
            
            VStack(alignment: .leading) {
                Text(recipe.name)
                    .font(.headline)
                    .padding(.bottom, 2)
                
                Text(recipe.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
            .padding(.leading, 8)
        }
    }
}

#Preview {
    StartView(recipes: .constant([]))
}
