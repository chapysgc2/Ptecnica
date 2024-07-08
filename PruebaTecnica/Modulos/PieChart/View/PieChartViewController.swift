//
//  PieChartViewController.swift
//  PruebaTecnica
//
//  Created by Hazel Alain on 07/07/24.
//

import UIKit
import Charts
import DGCharts

class PieChartViewController: UIViewController, PieChartViewProtocol {
    var presenter: PieChartPresenterProtocol?

    var pieChartView: PieChartView = {
        let chartView = PieChartView()
        // Personaliza las propiedades del gráfico si es necesario
        return chartView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Agrega pieChartView como subvista y establece las restricciones
        view.addSubview(pieChartView)
        pieChartView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pieChartView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pieChartView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            pieChartView.widthAnchor.constraint(equalToConstant: 300),
            pieChartView.heightAnchor.constraint(equalToConstant: 300)
        ])

        presenter?.viewDidLoad() // Llama al método del presenter para cargar los datos
    }

    func showPieChart(with data: [PieChartDataEntry]) {
        print("Data entries received: \(data)")
        print("entro aqui")

        let chartDataEntries = data.map { entry -> ChartDataEntry in
            return ChartDataEntry(x: Double(entry.label) ?? 0.0, y: entry.value, data: entry)
        }

        let dataSet = PieChartDataSet(entries: chartDataEntries, label: "Prospects")
        let chartData = PieChartData(dataSet: dataSet)
        pieChartView.data = chartData

        // Notifica al gráfico que los datos han cambiado
        pieChartView.notifyDataSetChanged()
    }



}



