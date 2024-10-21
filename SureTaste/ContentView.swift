import SwiftUI

struct ContentView: View {
    @State private var isActive = false
    @State private var selectedTab = 0
    @State private var recipes: [Recipe] = []

    let backgroundColor = Color(red: 240 / 255.0, green: 240 / 255.0, blue: 240 / 255.0)
    let textColor = Color(red: 18 / 255.0, green: 78 / 255.0, blue: 120 / 255.0)

    var body: some View {
        Group {
            if isActive {
                TabView(selection: $selectedTab) {
                    StartView(recipes: $recipes)
                        .tabItem {
                            Image(systemName: "house.fill")
                            Text("Start")
                        }
                        .tag(0)
                    
                    AddView(recipes: $recipes)
                        .tabItem {
                            Image(systemName: "plus.circle.fill")
                            Text("Add")
                        }
                        .tag(1)
                    
                    SearchView(recipes: $recipes)
                        .tabItem {
                            Image(systemName: "magnifyingglass")
                            Text("Search")
                        }
                        .tag(2)
                }
                .background(backgroundColor.ignoresSafeArea())
            } else {
         
                ZStack {
                    backgroundColor.ignoresSafeArea()

                    VStack {
                        if let image = UIImage(named: "Starting View") {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                        } else {
                     
                            Image(systemName: "refrigerator")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                                .foregroundColor(.gray)
                        }

                        Text("SureTaste")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                            .foregroundColor(textColor)
                            .padding()
                    }
                }
                .onAppear {
          
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation {
                            self.isActive = true
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
