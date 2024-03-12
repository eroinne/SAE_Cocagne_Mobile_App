//
//  ApiModel.swift
//  Sae_Cocagne
//
//  Created by Ero on 01/03/2024.
//

import Foundation

class ApiModel: ObservableObject {
    
    //list des tourner
    var tourneeLivraison: [TourneeLivraison] = []
    
    //list des Depots
    var depots: [Depot] = []
    
    var depotDetails: Depot?
    
    @Published var detailTournee: [DetailTourneeLivraison] = []
    
    //dict pour les heur d'arriver, id depot/ heur
    var heureArriver: [Int: String] = [:]
    
    
    
    
    //le paramètre apikey TOUJOURS en entête de toutes les requêtes http
    
    
    //1. Récupérer tous les dépôts
    
    //GET https://ytpaqpikqarnveticqhl.supabase.co/rest/v1/depots
    //apikey: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl0cGFxcGlrcWFybnZldGljcWhsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDQwNDQ3MzUsImV4cCI6MjAxOTYyMDczNX0.4glNGKdXcHAXUyWuO5fpvcmg4oRyH9TvtTZ7OYMkcfc
    func getAllDepots() {
        let url = URL(string: "https://ytpaqpikqarnveticqhl.supabase.co/rest/v1/depots")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl0cGFxcGlrcWFybnZldGljcWhsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDQwNDQ3MzUsImV4cCI6MjAxOTYyMDczNX0.4glNGKdXcHAXUyWuO5fpvcmg4oRyH9TvtTZ7OYMkcfc", forHTTPHeaderField: "apikey")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print("Erreur lors de la récupération des dépôts")
            }
            else {
                if let data = data {
                    // ajouter les données dans le tableau des dépôts
                    let decoder = JSONDecoder()
                    do {
                        let depots = try decoder.decode([Depot].self, from: data)
                        self.depots = depots
                    }
                    catch {
                        print("Erreur lors de la conversion du JSON en tableau de dépôts")
                    }
                    print(data)
                }
            }
        }
        task.resume()
    }
    
    
    
    //3. Détail d'un dépôt
    //Utilisation d'une vue prédéfinie
    //GET https://ytpaqpikqarnveticqhl.supabase.co/rest/v1/view_depots_details?depot_id=eq.65
    
    func getDepotDetails(depotId: Int) {
        let url = URL(string: "https://ytpaqpikqarnveticqhl.supabase.co/rest/v1/view_depots_details?depot_id=eq.\(depotId)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl0cGFxcGlrcWFybnZldGljcWhsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDQwNDQ3MzUsImV4cCI6MjAxOTYyMDczNX0.4glNGKdXcHAXUyWuO5fpvcmg4oRyH9TvtTZ7OYMkcfc", forHTTPHeaderField: "apikey")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print("Erreur lors de la récupération des détails du dépôt")
            }
            else {
                if let data = data {
                    //ajout du détail du dépôt
                    let decoder = JSONDecoder()
                    do {
                        let depotDetails = try decoder.decode([Depot].self, from: data)
                        self.depotDetails = depotDetails[0]
                    }
                    catch {
                        print("Erreur lors de la conversion du JSON en détail du dépôt")
                    }
                }
            }
        }
        task.resume()
    }
    
    //4. Appel de la fonction preparer pour connaitre le nombre de panier à préparer pour une semaine donnée
    //POST https://ytpaqpikqarnveticqhl.supabase.co/rest/v1/rpc/preparer
    //apikey: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl0cGFxcGlrcWFybnZldGljcWhsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDQwNDQ3MzUsImV4cCI6MjAxOTYyMDczNX0.4glNGKdXcHAXUyWuO5fpvcmg4oRyH9TvtTZ7OYMkcfc
    //content-type: application/json
    //{ "_semaine": "11" }
    //Les paramètres sont envoyé dans le body de la requête http. Ils sont encodés en json. Ne pas oublier de spécifier le content type de la requête !
    
    //4. Préparer une semaine
    
    func preparerSemaine(semaine: String) {
        let url = URL(string: "https://ytpaqpikqarnveticqhl.supabase.co/rest/v1/rpc/preparer")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl0cGFxcGlrcWFybnZldGljcWhsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDQwNDQ3MzUsImV4cCI6MjAxOTYyMDczNX0.4glNGKdXcHAXUyWuO5fpvcmg4oRyH9TvtTZ7OYMkcfc", forHTTPHeaderField: "apikey")
        
        let parameters = ["_semaine": semaine]
        request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print("Erreur lors de la préparation de la semaine")
            }
            else {
                if let data = data {
                    print(data)
                }
            }
        }
        task.resume()
    }
    
    // 5. Liste des tournées
    
    //Suivant le même principe que les dépôts
    
    //GET https://ytpaqpikqarnveticqhl.supabase.co/rest/v1/tournees?jardin_id=eq.2
    
    func getTournees(jardinId: Int) {
        let url = URL(string: "https://ytpaqpikqarnveticqhl.supabase.co/rest/v1/tournees?jardin_id=eq.\(jardinId)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl0cGFxcGlrcWFybnZldGljcWhsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDQwNDQ3MzUsImV4cCI6MjAxOTYyMDczNX0.4glNGKdXcHAXUyWuO5fpvcmg4oRyH9TvtTZ7OYMkcfc", forHTTPHeaderField: "apikey")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print("Erreur lors de la récupération des tournées")
            }
            else {
                if let data = data {
                }
            }
        }
        task.resume()
    }
    
    
    // 6. Détail des tournées
    
    //Pour le détail des tournées j'ai écrit une fonction qui affiche le détail
    //POST https://ytpaqpikqarnveticqhl.supabase.co/functions/v1/tournees
    //apikey: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl0cGFxcGlrcWFybnZldGljcWhsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDQwNDQ3MzUsImV4cCI6MjAxOTYyMDczNX0.4glNGKdXcHAXUyWuO5fpvcmg4oRyH9TvtTZ7OYMkcfc
    //content-type: application/json
    //{ "tournee_id": 3, "semaine": 9 }
    // En paramètre l'identifiant de la tournée et la semaine de livraison

    func getDetailTournee(tournee_id: Int, semaine: Int) {
        print("tourner_id : \(tournee_id)")
        print("semaine :  \(semaine)")
        let url = URL(string: "https://ytpaqpikqarnveticqhl.supabase.co/functions/v1/tournees")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl0cGFxcGlrcWFybnZldGljcWhsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDQwNDQ3MzUsImV4cCI6MjAxOTYyMDczNX0.4glNGKdXcHAXUyWuO5fpvcmg4oRyH9TvtTZ7OYMkcfc", forHTTPHeaderField: "apikey")
        
        let parameters = ["tournee_id": tournee_id, "semaine": semaine] as [String : Any]
        request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Erreur lors de la récupération des détails de la tournée: \(error)")
            } else {
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let tourneeDetails = try decoder.decode([DetailTourneeLivraison].self, from: data)
                        
                        print(tourneeDetails)
                            self.detailTournee = tourneeDetails
                        
                        
                    } catch {
                        print("Erreur lors de la conversion du JSON en détail de la tournée: \(error)")
                    }
                }
            }
        }
            task.resume()
        
    }

    
    
    
    //get all tourner
    //https://ytpaqpikqarnveticqhl.supabase.co/rest/v1/tournees
    func getAllTournee() {
        let url = URL(string: "https://ytpaqpikqarnveticqhl.supabase.co/rest/v1/tournees")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl0cGFxcGlrcWFybnZldGljcWhsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDQwNDQ3MzUsImV4cCI6MjAxOTYyMDczNX0.4glNGKdXcHAXUyWuO5fpvcmg4oRyH9TvtTZ7OYMkcfc", forHTTPHeaderField: "apikey")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print("Erreur lors de la récupération des tournées")
            }
            else {
                if let data = data {
                    //recupere tout les tournees
                    let decoder = JSONDecoder()
                    do {
                        
                        let tournees = try decoder.decode([TourneeLivraison].self, from: data)
                        print(tournees)
                        self.tourneeLivraison = tournees
                        print("----------------")
                    }
                    catch {
                        print("Erreur lors de la conversion du JSON en tournées")
                    }
                }
            }
        }
        task.resume()
    }
    
    func saveDepotArrival(depot_id : Int){
        //ajotu dans le dictionaire heurArriver de l'id en paramentre, est de la date actuelle
        let heure = Date()
        let heureFormatter = DateFormatter()
        
        heureFormatter.dateFormat = "HH:mm"
        
        let heureResult = heureFormatter.string(from: heure)
        let heureArriver = heureResult

        self.heureArriver = [depot_id:heureArriver] as [Int : String]
    }
    
    func resetArival(){
        //vider le dict
        heureArriver = [:]
        
    }

}
