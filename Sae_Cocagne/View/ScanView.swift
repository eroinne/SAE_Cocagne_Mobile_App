//
//  ScanView.swift
//  Sae_Cocagne
//
//  Created by Ero on 01/03/2024.
//

import SwiftUI
import CodeScanner

struct ScanView: View {
    @State private var qrContent: String = ""
    @State private var textScan: String = ""
    @State private var isDepotScanned: Bool = false
    @State private var isPaniersControlled: Bool = false
    @State private var isReturnScanned: Bool = false

    // Ajouter une instance de ApiModel
    @ObservedObject var apiModel = ApiModel()

    var body: some View {
        VStack {
            Text("Scanner")
            Text(self.textScan)
            CodeScannerView(codeTypes: [.qr], simulatedData: "DEPOT:1") { result in
                switch result {
                case .success(let scannedResult):
                    self.textScan = "Scan réussi"
                    self.qrContent = scannedResult.string

                    // Vérifier le contenu du QR code pour déterminer l'action
                    let content = self.qrContent
                        if content.hasPrefix("DEPOT:") {
                            // L'utilisateur a scanné le QR code du dépôt
                            self.isDepotScanned = true
                            textScan = "Depot n° " + content.split(separator: ":")[1] + "Scanee"
                            // Appeler la fonction de l'API pour enregistrer l'heure d'arrivée
                            self.apiModel.saveDepotArrival(depot_id: Int(content.split(separator: ":")[1]) ?? 1)
                        } else if content == "PANIER_LIVRE" {
                            textScan = "Panier scanné"
                            // L'utilisateur a scanné un panier livré
                            self.isPaniersControlled = true
                        } else if content == "RETOUR_JARDINS" {
                            // L'utilisateur a scanné le QR code pour retourner aux jardins
                            self.isReturnScanned = true
                            textScan = "Retour au jardin scanné"
                            }
                    

                case .failure(let error):
                    print(error.localizedDescription)
                    self.textScan = "Scan échoué"
                }
            }
        }
        .onDisappear {
            // Réinitialiser les états lorsque la vue disparaît
            self.resetStates()
        }
    }

    // Réinitialiser les états
    private func resetStates() {
        self.textScan=""
        self.isDepotScanned = false
        self.isPaniersControlled = false
        self.isReturnScanned = false
        self.apiModel.resetArival()
    }
}


#Preview {
    ScanView()
}
