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
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Double] {
                    let pieChartDataEntries = json.map { PieChartDataEntry(value: $0.value, label: $0.key) }
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



