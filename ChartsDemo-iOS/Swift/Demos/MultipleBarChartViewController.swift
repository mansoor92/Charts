//
//  MultipleBarChartViewController.swift
//  ChartsDemo-iOS
//
//  Created by Jacob Christie on 2017-07-09.
//  Copyright © 2017 jc. All rights reserved.
//

import UIKit
import Charts

class MultipleBarChartViewController: DemoBaseViewController {

    @IBOutlet var chartView: BarChartView!
    @IBOutlet var sliderX: UISlider!
    @IBOutlet var sliderY: UISlider!
    @IBOutlet var sliderTextX: UITextField!
    @IBOutlet var sliderTextY: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Multiple Bar Chart"
        
        self.options = [.toggleValues,
                        .toggleHighlight,
                        .animateX,
                        .animateY,
                        .animateXY,
                        .saveToGallery,
                        .togglePinchZoom,
                        .toggleAutoScaleMinMax,
                        .toggleData,
                        .toggleBarBorders]
        
        chartView.delegate = self
        
        chartView.chartDescription?.enabled =  false
        
        chartView.pinchZoomEnabled = false
        chartView.drawBarShadowEnabled = false
//		chartView.minOffset = 0
		chartView.extraBottomOffset = 0
        
        let marker = BalloonMarker(color: UIColor(white: 180/255, alpha: 1), font: .systemFont(ofSize: 12), textColor: .white, insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8))
        marker.chartView = chartView
        marker.minimumSize = CGSize(width: 80, height: 40)
//        chartView.marker = marker
		chartView.drawMarkers = false
        
        let l = chartView.legend
        l.horizontalAlignment = .right
        l.verticalAlignment = .top
        l.orientation = .vertical
        l.drawInside = true
        l.font = .systemFont(ofSize: 8, weight: .light)
        l.yOffset = 10
        l.xOffset = 10
        l.yEntrySpace = 0
//        chartView.legend = l

        let xAxis = chartView.xAxis
        xAxis.labelFont = .systemFont(ofSize: 10, weight: .light)
        xAxis.granularity = 1
        xAxis.centerAxisLabelsEnabled = true
		xAxis.labelPosition = .bottom
        xAxis.valueFormatter = IntAxisValueFormatter()
		xAxis.drawGridLinesEnabled = false
		xAxis.yOffset = 8
		xAxis.axisLineColor = UIColor.red
		xAxis.axisLineWidth = 1
        
//        let leftAxisFormatter = NumberFormatter()
//        leftAxisFormatter.maximumFractionDigits = 1
//
//        let leftAxis = chartView.leftAxis
//        leftAxis.labelFont = .systemFont(ofSize: 10, weight: .light)
//        leftAxis.valueFormatter = LargeValueFormatter()
//        leftAxis.spaceTop = 0.35
//        leftAxis.axisMinimum = 0
        
        chartView.rightAxis.enabled = false
		chartView.leftAxis.enabled = false
        
        sliderX.value = 10
        sliderY.value = 100
        slidersValueChanged(nil)
    }
    
    override func updateChartData() {
        if self.shouldHideData {
            chartView.data = nil
            return
        }
        
        self.setDataCount(Int(sliderX.value), range: UInt32(sliderY.value))
    }
    
    func setDataCount(_ count: Int, range: UInt32) {
        let groupSpace = 0.08
        let barSpace = 0.03
		let barWidth = 10.0
        // (0.2 + 0.03) * 4 + 0.08 = 1.00 -> interval per "group"

        let randomMultiplier = range * 100000
        let groupCount = count + 1
        let startYear = 1980
        let endYear = startYear + groupCount
        
        let block: (Int) -> BarChartDataEntry = { (i) -> BarChartDataEntry in
            let entry = BarChartDataEntry(x: Double(i), y: Double(arc4random_uniform(randomMultiplier)))
			entry.category = "UAE"
			if i == 1980 {
				entry.specialEntry = BarChartDataEntry.SpecialEntry(fillColor: .green, enableHighlight: false)
			}
			return entry
        }
        let yVals1 = (startYear ..< endYear).map(block)
        let yVals2 = (startYear ..< endYear).map(block)
        let yVals3 = (startYear ..< endYear).map(block)
        let yVals4 = (startYear ..< endYear-1).map(block)
        
        let set1 = BarChartDataSet(entries: yVals1, label: "Company A")
		set1.setColor(UIColor.red)
		set1.isRoundCorners = true
		set1.highlightColor = UIColor.yellow
		set1.highlightAlpha = 1
		set1.roundingCorners = [.topLeft, .topRight]
		set1.isDrawValuesAtBottom = true
		set1.drawValuesEnabled = true
		set1.barBorderColor = .blue
		set1.barBorderWidth = 2

        let set2 = BarChartDataSet(entries: yVals2, label: "Company B")
		set2.setColor(UIColor.blue)
		set2.highlightEnabled = false
		set2.drawValuesEnabled = false
		set2.barBorderColor = .red
		set2.barBorderWidth = 2
        
        let set3 = BarChartDataSet(entries: yVals3, label: "Company C")
        set3.setColor(UIColor(red: 242/255, green: 247/255, blue: 158/255, alpha: 1))
        
        let set4 = BarChartDataSet(entries: yVals4, label: "Company D")
        set4.setColor(UIColor(red: 255/255, green: 102/255, blue: 0/255, alpha: 1))

//		set4.isDra
        
        let data = BarChartData(dataSets: [set1,set2])
        data.setValueFont(.systemFont(ofSize: 10, weight: .light))
        data.setValueFormatter(LargeValueFormatter())
        
        // specify the width each bar should have
        data.barWidth = barWidth

        // restrict the x-axis range
        chartView.xAxis.axisMinimum = Double(startYear)
        
        // groupWidthWithGroupSpace(...) is a helper that calculates the width each group needs based on the provided parameters
        chartView.xAxis.axisMaximum = Double(startYear) + data.groupWidth(groupSpace: groupSpace, barSpace: barSpace) * Double(groupCount)
        
        data.groupBars(fromX: Double(startYear), groupSpace: groupSpace, barSpace: barSpace)

        chartView.data = data
    }
    
    override func optionTapped(_ option: Option) {
        super.handleOption(option, forChartView: chartView)
    }
    
    // MARK: - Actions
    @IBAction func slidersValueChanged(_ sender: Any?) {
        let startYear = 1980
        let endYear = startYear + Int(sliderX.value)

        sliderTextX.text = "\(startYear)-\(endYear)"
        sliderTextY.text = "\(Int(sliderY.value))"
        
        self.updateChartData()
    }
}
