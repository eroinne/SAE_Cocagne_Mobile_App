//
//  HomeView.swift
//  Sae_Cocagne
//
//  Created by Ero on 01/03/2024.
//

import SwiftUI

struct HomeView: View {
    //api
    var apiModel = ApiModel()
    
    @State private var tourner: [TourneeLivraison] = []
    
    var body: some View {
        VStack {
            //ajouter le logo contenu dans le dossier image est nomer jardin
            if let logoImage = UIImage(named: "logo", in: Bundle.main, with: nil) {
                                Image(uiImage: logoImage)
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                                    .shadow(radius: 10)
                                    .padding(.bottom, -50)
                            }

          
            Button(action: {
                self.apiModel.getAllTournee()
                self.tourner = self.apiModel.tourneeLivraison
            }) {
                Text("Actualiser")
            }.offset(y: 50)
            
            NavigationStack {
                VStack(spacing:0){
                    Text("Tournee de livraison : \n ")
                    
                    List(self.tourner, id: \.id) { tournee in
                        NavigationLink(destination: TourneeDetailView(tournee)) {
                            Text("tournee : \(tournee.tournee)")
                        }
                    }
                }.onAppear {
                        self.apiModel.getAllTournee()
                        self.tourner = self.apiModel.tourneeLivraison
                    }
            }.offset(y: 50)
            }
        }
    }




#Preview {
    HomeView()
}
