import SwiftUI

struct RecipeDetailView_v2: View {
    var recipe: Recipe
    @Binding var recipes: [Recipe]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack(alignment: .top) {
                   
                    if let imageData = recipe.imageData, let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .cornerRadius(8)
                            .padding(.trailing, 8)
                    } else {
                        Rectangle()
                            .fill(Color.gray.opacity(0.5))
                            .frame(width: 100, height: 100)
                            .cornerRadius(8)
                            .padding(.trailing, 8)
                    }
                    
                    VStack(alignment: .leading) {
                        Text(recipe.name)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text(recipe.description)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .padding(.top, 4)
                    }
                }

                Text("Ingredients")
                    .font(.headline)
                
                VStack {
                    HStack {
                        Text("Quantity")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("Unit")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("Ingredient")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    Divider()
                    
                    ForEach(recipe.ingredients) { ingredient in
                        HStack {
                            Text("\(ingredient.quantity)")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(ingredient.unit)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(ingredient.name)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding(.vertical, 4)
                    }
                }
                .frame(maxWidth: UIScreen.main.bounds.width * 0.95) // Verhindert, dass der Inhalt über den Rand hinausragt


                Text("Instructions")
                    .font(.headline)
                    .padding(.top, 8)
                
                Text(recipe.instructions)
                    .padding(.vertical, 4)

                Text("Tags")
                    .font(.headline)
                    .padding(.top, 8)
                
                HStack {
                    ForEach(recipe.categories, id: \.self) { category in
                        Text("#\(category)")
                            .font(.footnote)
                            .padding(4)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(4)
                    }
                }
            }
            .padding()
        }
        .navigationBarItems(
            trailing: Button("Edit") {
                // Edit action here
            }
        )
        .navigationTitle("Recipe Details")
    }
}
