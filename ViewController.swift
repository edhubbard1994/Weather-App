//
//  ViewController.swift
//  Weather App
//
//  Created by Edward Hubbard on 3/24/18.
//  Copyright © 2018 Edward Hubbard. All rights reserved.
//

import UIKit
import CoreLocation

extension UIImage{
    class func scaleImageToSize(img: UIImage, size: CGSize)->UIImage{
       UIGraphicsBeginImageContext(size)
        img.draw(in:  CGRect(origin: CGPoint.zero, size: size))
        let scaledImg = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImg!
    }
}
class ViewController: UIViewController {
    
    var text : String = ""
    
    let enterText = UITextField()
    let submitBtn = UIButton(type: .roundedRect)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getBackground()
        getTextField()
        getSubmitBtn()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getBackground(){
        let toScale = #imageLiteral(resourceName: "questionCloud")
        let size = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        let image = UIImage.scaleImageToSize(img: toScale , size: size)
        
        let defaultBackground = UIImageView(image: image)
        defaultBackground.contentMode = .scaleAspectFit
        defaultBackground.center = self.view.center
        self.view.addSubview(defaultBackground)
    }
    
    func getTextField(){
        
        enterText.frame = CGRect(x: 0, y: (self.view.frame.height/3)+150, width: self.view.frame.width, height: 70)
        enterText.delegate = self as? UITextFieldDelegate
        enterText.placeholder = "Where Are You?"
        enterText.allowsEditingTextAttributes = true
        enterText.backgroundColor = .white
        enterText.borderStyle = .roundedRect
        enterText.textAlignment = .center
        enterText.keyboardType = .default
        enterText.alpha = 0.5
        enterText.textColor = .black
        enterText.isSecureTextEntry = false
        enterText.addTarget(self, action: #selector(getText), for: .editingDidEnd)
        self.view.addSubview(enterText)
    }
    
    func getSubmitBtn(){
        
        let btnSize = CGRect(x: 0, y: (self.view.frame.height)/6, width: 300, height: 70)
        submitBtn.translatesAutoresizingMaskIntoConstraints = false
        submitBtn.frame(forAlignmentRect: btnSize)
        submitBtn.bounds = btnSize
        submitBtn.center = CGPoint(x: self.view.frame.width/2, y: 5*self.view.frame.height/6)
        submitBtn.backgroundColor = .white
        submitBtn.alpha = 0.5
        submitBtn.setTitle("Get Weather", for: .normal)
        submitBtn.setTitleColor(.black, for: .normal)
        submitBtn.addTarget(self, action: #selector(submitPressed), for: .touchUpInside)
        self.view.addSubview(submitBtn)
    }
    
    @objc func submitPressed(){
        let locator = GeoLocator(locationString: enterText.text!)
        locator.getCoordinate(addressString: enterText.text!, completionHandler:{ (places, errors) in
            if errors != nil{
                print(errors)
            }
        
            let request = WeatherRequester(coordinates: (places![0].location?.coordinate)!)
           request.getWeather(){weather in
            DispatchQueue.main.async {
                 self.getNextView(weather: weather)
            }
           
            }
    })
        
        print("location is:",locator)
        
    }
    @objc func getText(){
        text = enterText.text!
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func getNextView(weather: WeatherRequester.JSONInfo){
        let nextView = WeatherViewController(nibName: nil, bundle: nil)
        nextView.weather = weather
        self.present(nextView, animated: true, completion: nil)
    }
}


