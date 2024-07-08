//
//  PieChartRouter.swift
//  PruebaTecnica
//
//  Created by Hazel Alain on 07/07/24.
//

import UIKit

class PieChartRouter: PieChartRouterProtocol {
    static func createModule() -> UIViewController {
        let storyboard = UIStoryboard(name: "PieChartView", bundle: nil)
        guard let view = storyboard.instantiateViewController(withIdentifier: "pieChartViewController") as? PieChartViewController else {
            fatalError("Failed to instantiate PieChartViewController from storyboard.")
        }

        let presenter = PieChartPresenter()
        let interactor = PieChartInteractor()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter


        return view
    }
}
