//
//  ViewController.swift
//  MapAppSecond
//
//  Created by あまつき on 2020/11/01.
//

import UIKit
import MapKit

class ViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // textFieldのdelegate通知先を設定
        inputText.delegate = self
    }

    @IBOutlet weak var inputText: UITextField!
    
    @IBOutlet weak var dispMap: MKMapView!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // キーボードを閉じる
        textField.resignFirstResponder()
        
        // 入力された文字を取り出す
        if let searchKey = textField.text {
            // 入力された文字をデバッグエリアに表示
            print(searchKey)
            
            // CLGeocoderインスタンスを取得
            let geocoder = CLGeocoder()
            
            // 入力された文字から位置情報を取得
            geocoder.geocodeAddressString(searchKey, completionHandler: { (placemarks, error) in
                
                // 位置情報が存在する場合はunwrapPlacemarksに取り出す
                if let unwrapPlacemarks = placemarks {
                    
                    // 1件目の情報を引き出す
                    if let firstPlacemark = unwrapPlacemarks.first {
                        
                        // 位置情報を取り出す
                        if let location = firstPlacemark.location {
                            
                            // 位置情報から緯度経度をtargetCoordinateに取り出す
                            let targetCoordinate = location.coordinate
                            
                            // 緯度経度をデバッグエリアに表示
                            print(targetCoordinate)
                            
                            // MKPointAnnotationインスタンスを取得し、ピンを生成
                            let pin = MKPointAnnotation()
                            
                            // ピンの置く場所に緯度経度を設定
                            pin.coordinate = targetCoordinate
                            
                            // ピンのタイトルを設定
                            pin.title = searchKey
                            
                            // ピンを地図に置く
                            self.dispMap.addAnnotation(pin)
                            
                            // 緯度経度を中心にして半径500mの範囲を表示
                            self.dispMap.region = MKCoordinateRegion(center: targetCoordinate, latitudinalMeters: 500.0, longitudinalMeters: 500.0)
                        }
                    }
                }
            })
            
        }
        
        // デフォルト動作を行うのでtrue
        return true
    }
}

