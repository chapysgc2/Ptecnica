//
//  PieChartInteractor.swift
//  PruebaTecnica
//
//  Created by Hazel Alain on 07/07/24.
//

import Foundation

// Enum para las categorías de estado de prospectos
enum ProspectStatus: String {
    case abiertos = "Abiertos"
    case cerrados = "Cerrados"
    case noInteresados = "No Interesados"
}

// Interactor para obtener datos del gráfico de pastel

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
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                    // Caso para arreglo de objetos JSON
                    print("Processing JSON as array of dictionaries")
                    
                    guard let firstEntry = json.first else {
                        print("Error: Empty JSON array")
                        return
                    }
                    
                    if let abiertos = firstEntry["abiertos"] as? Double,
                       let cerrados = firstEntry["cerrados"] as? Double,
                       let noInteresados = firstEntry["nO_INTERESADOS"] as? Double {
                        
                        let pieChartDataEntries = [
                            PieChartDataEntry(value: abiertos, label: ProspectStatus.abiertos.rawValue),
                            PieChartDataEntry(value: cerrados, label: ProspectStatus.cerrados.rawValue),
                            PieChartDataEntry(value: noInteresados, label: ProspectStatus.noInteresados.rawValue)
                        ]
                        
                        DispatchQueue.main.async {
                            self.presenter?.didFetchPieChartData(pieChartDataEntries)
                        }
                    } else {
                        print("Error: Missing or invalid fields in JSON object")
                    }
                    
                } else if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    // Caso para objeto JSON único
                    print("Processing JSON as a single dictionary")
                    
                    if let abiertos = json["abiertos"] as? Double,
                       let cerrados = json["cerrados"] as? Double,
                       let noInteresados = json["nO_INTERESADOS"] as? Double {
                        
                        let pieChartDataEntries = [
                            PieChartDataEntry(value: abiertos, label: ProspectStatus.abiertos.rawValue),
                            PieChartDataEntry(value: cerrados, label: ProspectStatus.cerrados.rawValue),
                            PieChartDataEntry(value: noInteresados, label: ProspectStatus.noInteresados.rawValue)
                        ]
                        
                        DispatchQueue.main.async {
                            self.presenter?.didFetchPieChartData(pieChartDataEntries)
                        }
                    } else {
                        print("Error: Missing or invalid fields in JSON object")
                    }
                } else {
                    // Manejar otros formatos de JSON no esperados
                    print("Error: Unexpected JSON format")
                }
            } catch {
                // Manejar el error de parsing JSON
                print("Error parsing JSON: \(error.localizedDescription)")
            }
        }.resume()
    }
}

