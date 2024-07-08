//
//  PieChartInteractor.swift
//  PruebaTecnica
//
//  Created by Hazel Alain on 07/07/24.
//

import Foundation

class PieChartInteractor: PieChartInteractorInputProtocol {
    weak var presenter: PieChartInteractorOutputProtocol?

    func fetchPieChartData() {
        guard let url = URL(string: "http://xignumresearch.com/apicrm/api/Dashboard/getTotalAnualProspects") else {
            // Manejar el error de URL inválida
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                // Manejar el error de red
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            // Print data received for debugging
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Received JSON data: \(jsonString)")
            } else {
                print("Failed to convert data to UTF-8 string")
            }
            
            do {
                if let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                    // Assuming we want to use "abiertos", "cerrados", and "no_interesados" as the pie chart data
                    guard let firstEntry = jsonArray.first else { return }
                    
                    let abiertos = firstEntry["abiertos"] as? Double ?? 0
                    let cerrados = firstEntry["cerrados"] as? Double ?? 0
                    let noInteresados = firstEntry["nO_INTERESADOS"] as? Double ?? 0
                    
                    let pieChartDataEntries = [
                        PieChartDataEntry(value: abiertos, label: "Abiertos"),
                        PieChartDataEntry(value: cerrados, label: "Cerrados"),
                        PieChartDataEntry(value: noInteresados, label: "No Interesados")
                    ]
                    
                    DispatchQueue.main.async {
                        self.presenter?.didFetchPieChartData(pieChartDataEntries)
                    }
                }
            } catch {
                // Manejar el error de parsing JSON
                print("Error parsing JSON: \(error.localizedDescription)")
            }
        }.resume()
    }
}





