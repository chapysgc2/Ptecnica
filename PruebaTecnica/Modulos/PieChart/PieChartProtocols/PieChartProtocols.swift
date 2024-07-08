//
//  PieChartProtocols.swift
//  PruebaTecnica
//
//  Created by Hazel Alain on 07/07/24.
//

import Foundation
import UIKit

// MARK: - View Protocol

protocol PieChartViewProtocol: AnyObject {
    var presenter: PieChartPresenterProtocol? { get set }
    func showPieChart(with data: [PieChartDataEntry])
}


// MARK: - Interactor Protocols

protocol PieChartInteractorInputProtocol: AnyObject {
    func fetchPieChartData()
}

protocol PieChartInteractorOutputProtocol: AnyObject {
    func didFetchPieChartData(_ data: [PieChartDataEntry])
}

// MARK: - Presenter Protocol

protocol PieChartPresenterProtocol: AnyObject {
    func viewDidLoad()
}

// MARK: - Entity (Optional)
// No se requiere una entidad específica si solo estamos tratando con datos de gráficos.

// MARK: - Router Protocol (Optional)
// En este caso, puede no necesitarse un Router si no hay navegación compleja.

protocol PieChartRouterProtocol: AnyObject {
    // Función para crear el módulo
    static func createModule() -> UIViewController
}


