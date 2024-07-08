//
//  PieChartPresenter.swift
//  PruebaTecnica
//
//  Created by Hazel Alain on 07/07/24.
//

import Foundation

class PieChartPresenter: PieChartPresenterProtocol, PieChartInteractorOutputProtocol {
    weak var view: PieChartViewProtocol?
    var interactor: PieChartInteractorInputProtocol?

    func viewDidLoad() {
        interactor?.fetchPieChartData()
    }

    func didFetchPieChartData(_ data: [PieChartDataEntry]) {
        print("entro al did")
        view?.showPieChart(with: data)
    }
}



