import SwiftUI

struct TourneeDetailView: View {
    @ObservedObject var apiModel = ApiModel()
    var item: TourneeLivraison?
    @State private var tourneeDetails: [DetailTourneeLivraison] = []

    init(_ item: TourneeLivraison) {
        self.item = item
    }

    var body: some View {
        ScrollView { // Ajout du ScrollView ici
            VStack {
                Text("Détails de la tournée : \(item?.tournee ?? "")").bold().padding()

                ForEach(tourneeDetails, id: \.self) { detailTournee in
                    // Iterate through all depots
                    ForEach(detailTournee.distribution, id: \.self) { depot in
                        // Display depot information
                        Text("Depot: \(depot.depot)").padding()

                        // Iterate through livraisons in the depot
                        ForEach(depot.livraisons, id: \.self) { livraison in
                            // Display panier information
                            Text("Panier: \(livraison.panier), Count: \(livraison.count)")
                        }
                    }
                }
            }
        }
        .onAppear {
            // Call the function when the view appears
            if let tourneeId = item?.id, let semaine = Optional(9) {
                self.apiModel.getDetailTournee(tournee_id: tourneeId, semaine: semaine)
            }
        }
        .onChange(of: apiModel.detailTournee) { newDetailTournee in
            self.tourneeDetails = newDetailTournee
        }
    }
}

struct TourneeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TourneeDetailView(TourneeLivraison(id: 3, jardin_id: 1, tournee: "Tournee 1", preparation_id: 1, calendrier_id: 1, ordre: 1, couleur: "red"))
    }
}
