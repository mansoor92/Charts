//
//  LineChart1ViewController.swift
//  ChartsDemo-iOS
//
//  Created by Jacob Christie on 2017-07-09.
//  Copyright © 2017 jc. All rights reserved.
//

import UIKit
import Charts

class LineChart1ViewController: DemoBaseViewController {

    @IBOutlet var chartView: LineChartView!
    @IBOutlet var sliderX: UISlider!
    @IBOutlet var sliderY: UISlider!
    @IBOutlet var sliderTextX: UITextField!
    @IBOutlet var sliderTextY: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

		self.view.backgroundColor = UIColor.black

		// Do any additional setup after loading the view.
        self.title = "Line Chart 1"
		configureChart()
        self.options = [.toggleValues,
                        .toggleFilled,
                        .toggleCircles,
                        .toggleCubic,
                        .toggleHorizontalCubic,
                        .toggleIcons,
                        .toggleStepped,
                        .toggleHighlight,
                        .animateX,
                        .animateY,
                        .animateXY,
                        .saveToGallery,
                        .togglePinchZoom,
                        .toggleAutoScaleMinMax,
                        .toggleData]

		chartView.clipsToBounds = false
        /*
        chartView.delegate = self

		chartView.layer.masksToBounds = false
		chartView.layer.borderWidth = 1
		chartView.layer.borderColor = UIColor.red.cgColor
		
        chartView.chartDescription?.enabled = false
        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        chartView.pinchZoomEnabled = true
		chartView.zoom(scaleX: 2.5, scaleY: 0.2, x: 0, y: 0)
        
        // x-axis limit line
        let llXAxis = ChartLimitLine(limit: 10, label: "Index 10")
        llXAxis.lineWidth = 4
        llXAxis.lineDashLengths = [10, 10, 0]
        llXAxis.labelPosition = .bottomRight
        llXAxis.valueFont = .systemFont(ofSize: 10)
        
        chartView.xAxis.gridLineDashLengths = [10, 10]
        chartView.xAxis.gridLineDashPhase = 0
        
        let ll1 = ChartLimitLine(limit: 150, label: "Upper Limit")
        ll1.lineWidth = 4
        ll1.lineDashLengths = [5, 5]
        ll1.labelPosition = .topRight
        ll1.valueFont = .systemFont(ofSize: 10)
        
        let ll2 = ChartLimitLine(limit: -30, label: "Lower Limit")
        ll2.lineWidth = 4
        ll2.lineDashLengths = [5,5]
        ll2.labelPosition = .bottomRight
        ll2.valueFont = .systemFont(ofSize: 10)
        
        let leftAxis = chartView.leftAxis
        leftAxis.removeAllLimitLines()
        leftAxis.addLimitLine(ll1)
        leftAxis.addLimitLine(ll2)
        leftAxis.axisMaximum = 200
        leftAxis.axisMinimum = -50
        leftAxis.gridLineDashLengths = [5, 5]
        leftAxis.drawLimitLinesBehindDataEnabled = true
        
        chartView.rightAxis.enabled = false
        
        //[_chartView.viewPortHandler setMaximumScaleY: 2.f];
        //[_chartView.viewPortHandler setMaximumScaleX: 2.f];

        let marker = BalloonMarker(color: UIColor(white: 180/255, alpha: 1),
                                   font: .systemFont(ofSize: 12),
                                   textColor: .white,
                                   insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8))
        marker.chartView = chartView
        marker.minimumSize = CGSize(width: 80, height: 40)
        chartView.marker = marker
        
        chartView.legend.form = .line
		chartView.zoom(scaleX: 2.5, scaleY: 0.2, x: 0, y: 0)
        
        sliderX.value = 45
        sliderY.value = 100
        slidersValueChanged(nil)
        
        chartView.animate(xAxisDuration: 2.5)
		chartView.leftAxis.enabled = false // disable horizontal lines of grid behind graph
		chartView.xAxis.enabled = false // disable verticle line of grid behind graph*/
    }

    override func updateChartData() {
        if self.shouldHideData {
            chartView.data = nil
            return
        }


		let set1 = dataSet(values: dummyData(from: 1997, to: 2016))
		let set2 = dataSet(values: dummyData(from: 2000, to: 2016))

		let data = LineChartData(dataSets: [set1, set2])
		//		data.setValueTextColor(.white)
		//		data.setValueFont(.systemFont(ofSize: 9))

		chartView.data = data

		let marker:BalloonMarker = BalloonMarker(color: UIColor.black, font: UIFont(name: "Helvetica", size: 12)!, textColor: UIColor.white, insets: UIEdgeInsets(top: 7.0, left: 7.0, bottom: 7.0, right: 7.0))
		marker.minimumSize = CGSize(width: 75.0, height: 35.0)
		chartView.marker = marker
		chartView.drawMarkers = true
		chartView.data?.highlightEnabled = true

//		chartView.marker?.offsetForDrawing(atPoint: <#T##CGPoint#>)
//		chartView.highlightValues([Highlight])
    }


	private func configureChart() {
		chartView.delegate = self

		chartView.chartDescription?.enabled = false
		chartView.dragEnabled = true
		chartView.pinchZoomEnabled = false
		chartView.rightAxis.enabled = false

		chartView.legend.form = .square
		chartView.zoom(scaleX: 2.5, scaleY: 0.2, x: 0, y: 0)
		//		chartView.scaleY = 0.2
		chartView.setScaleEnabled(false)
		chartView.leftAxis.axisMinimum = 0
		chartView.leftAxis.axisMaximum = 10
		chartView.leftAxis.labelTextColor = .white

		chartView.animate(xAxisDuration: 2.5)
		chartView.leftAxis.enabled = true // disable horizontal lines of grid behind graph
		chartView.xAxis.enabled = true // disable verticle line of grid behind graph
		chartView.xAxis.axisLineColor = .clear
//		chartView.xAxis.gridColor = .clear
//		chartView.y
		chartView.xAxis.labelTextColor = UIColor.white
		chartView.xAxis.labelPosition = .bottom
//		chartView.xAxis.labelFont =


		chartView.clipDataToContentEnabled = false

		chartView.layer.masksToBounds = false
		chartView.layer.borderWidth = 1
		chartView.layer.borderColor = UIColor.red.cgColor

		let set1 = dataSet(values: dummyData(from: 1997, to: 2016))
		let set2 = dataSet(values: dummyData(from: 2000, to: 2016))
		let data = LineChartData(dataSets: [set1, set2])
//		data.setValueTextColor(.white)
//		data.setValueFont(.systemFont(ofSize: 9))
		chartView.legend.enabled = false
		chartView.data = data

	}


	func dummyData(from: Int, to: Int) -> [ChartDataEntry] {
		let values = (from..<to).map { (i) -> ChartDataEntry in
			let val = Double(arc4random_uniform(5) + 3)
			return ChartDataEntry(x: Double(i), y: val, icon: UIImage())
		}
		return values
	}

    func dataSet(values: [ChartDataEntry]) -> ILineRadarChartDataSet{

        let set1 = LineChartDataSet(entries: values, label: "DataSet 1")
        set1.drawIconsEnabled = false
        
//        set1.lineDashLengths = [5, 2.5]
//        set1.highlightLineDashLengths = [5, 2.5]
        set1.setColor(.white)
        set1.setCircleColor(.clear)
        set1.lineWidth = 3
        set1.circleRadius = 0
        set1.drawCircleHoleEnabled = true
        set1.valueFont = .systemFont(ofSize: 9)
        set1.valueColors = [UIColor.white]
		set1.valueOffset = CGPoint(x: 0, y: 25)
//		set1.drawIconsEnabled = false
//        set1.formLineDashLengths = [5, 2.5]
//        set1.formLineWidth = 1
        set1.formSize = 15
        
//        let gradientColors = [UIColor.clear.cgColor,
//                              UIColor.white.withAlphaComponent(0.5).cgColor]
//        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
//		set1.fillAlpha = 1
//		set1.fill = Fill(linearGradient: gradient, angle: 90) //.linearGradient(gradient, angle: 90)
//		set1.drawFilledEnabled = true


		let higlightColors = [ UIColor.white.cgColor,UIColor.red.withAlphaComponent(0.5).cgColor]
		let highlightGradient = CGGradient(colorsSpace: nil, colors: higlightColors as CFArray, locations: nil)!
		set1.highlightFillAlpha = 0.5
		set1.highlightFill = Fill(linearGradient: highlightGradient, angle: 90)
		set1.highlightWidth = 90
		set1.highlightPointImage = UIImage(named: "point")
		set1.highlightFootImage = UIImage(named: "Line")

		if let patternImg = UIImage(named: "lineChartBg") {

			set1.secondaryFill = Fill(CGColor: UIColor(patternImage: patternImg).cgColor)
//			set1.secondaryFill = Fill(CGImage: patternImg, tiled: true)
			set1.secondaryFillAlpha = 1
		}

		return set1
    }
    
    override func optionTapped(_ option: Option) {
        switch option {
        case .toggleFilled:
            for set in chartView.data!.dataSets as! [LineChartDataSet] {
                set.drawFilledEnabled = !set.drawFilledEnabled
            }
            chartView.setNeedsDisplay()
            
        case .toggleCircles:
            for set in chartView.data!.dataSets as! [LineChartDataSet] {
                set.drawCirclesEnabled = !set.drawCirclesEnabled
            }
            chartView.setNeedsDisplay()
            
        case .toggleCubic:
            for set in chartView.data!.dataSets as! [LineChartDataSet] {
                set.mode = (set.mode == .cubicBezier) ? .linear : .cubicBezier
            }
            chartView.setNeedsDisplay()
            
        case .toggleStepped:
            for set in chartView.data!.dataSets as! [LineChartDataSet] {
                set.mode = (set.mode == .stepped) ? .linear : .stepped
            }
            chartView.setNeedsDisplay()
            
        case .toggleHorizontalCubic:
            for set in chartView.data!.dataSets as! [LineChartDataSet] {
                set.mode = (set.mode == .cubicBezier) ? .horizontalBezier : .cubicBezier
            }
            chartView.setNeedsDisplay()
            
        default:
            super.handleOption(option, forChartView: chartView)
        }
    }

    @IBAction func slidersValueChanged(_ sender: Any?) {
        sliderTextX.text = "\(Int(sliderX.value))"
        sliderTextY.text = "\(Int(sliderY.value))"
        
        self.updateChartData()
    }
}
