//
//  WeatherViewController.swift
//  Weather App
//
//  Created by Edward Hubbard on 4/7/18.
//  Copyright © 2018 Edward Hubbard. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    var weather: WeatherRequester.JSONInfo?
    let backBtn = UIButton()
    let weatherLabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        getBackground()
        getBackBtn()
        displayWeather()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getBackground(){
        let size = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        let weatherOutput = WeatherDescription(description: self.weather!.currently!.icon!, temp: self.weather!.currently!.temperature!)
        self.view.addSubview(UIImageView(image: weatherOutput.conditionImage(size: size)))
    }
    
    func displayWeather(){
        weatherLabel.center = CGPoint(x: 0, y: self.view.frame.height/2)
        let size = CGSize(width: self.view.frame.width/2, height: self.view.frame.height/2)
        let rect = CGRect(origin: self.view.center, size: size)
        weatherLabel.textRect(forBounds: rect , limitedToNumberOfLines: 10)
        weatherLabel.text = String(describing: self.weather!.currently!.summary!) + ", tempurature:" + String(self.weather!.currently!.temperature!)
        weatherLabel.textColor = .white
        weatherLabel.sizeToFit()
        self.view.addSubview(weatherLabel)
    }
    
    func getBackBtn(){
        
        let btnSize = CGRect(x: 0, y: (self.view.frame.height)/6, width: 300, height: 70)
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        backBtn.frame(forAlignmentRect: btnSize)
        backBtn.bounds = btnSize
        backBtn.center = CGPoint(x: self.view.frame.width/2, y: 5*self.view.frame.height/6)
        backBtn.backgroundColor = .white
        backBtn.alpha = 0.5
        backBtn.setTitle("Go back", for: .normal)
        backBtn.setTitleColor(.black, for: .normal)
        backBtn.addTarget(self, action: #selector(submitPressed), for: .touchUpInside)
        self.view.addSubview(backBtn)
    }
    @objc func submitPressed(){
        let lastView = ViewController(nibName: nil, bundle: nil)
        self.present(lastView, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
