//
//  HomeViewController.swift
//  DemoScanBeaconsBackground
//
//  Created by Duy Tran N. on 12/9/20.
//  Copyright © 2020 MBA0204. All rights reserved.
//

import UIKit
//import CoreBluetooth
//import AVFoundation
import CoreLocation

struct Define {
    struct UUID {
        static let mba0204Beacon: String = "E57CE779-F24C-4133-AC3A-6C46A7C292CF"
    }
}

final class HomeViewController: UIViewController {

    private var locationManager: CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.startUpdatingLocation()
    }
}

extension HomeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    startLocationServiceScanningBeacons()
                }
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didRange beacons: [CLBeacon], satisfying beaconConstraint: CLBeaconIdentityConstraint) {
        if beacons.count > 0 {
            NSLog("☘️ Beacons detected (\(beacons.count))")
            let firstBeacon = beacons[0]
            NSLog("rssi: \(firstBeacon.rssi)\naccuracy: \(firstBeacon.accuracy)\ntimestamp: \(firstBeacon.timestamp)\nuuid: \(firstBeacon.uuid)\nmajor: \(firstBeacon.major)\nminor: \(firstBeacon.minor)")
            updateDistance(firstBeacon.proximity)
        } else {
            NSLog("🧨 no beacons detected")
            updateDistance(.unknown)
        }
    }
}

extension HomeViewController {
    func startLocationServiceScanningBeacons() {
        if let uuid = UUID(uuidString: Define.UUID.mba0204Beacon) {
            let beaconRegion = CLBeaconRegion(uuid: uuid, identifier: "MBA0204-Beacon")
            locationManager.startMonitoring(for: beaconRegion)
            locationManager.startRangingBeacons(satisfying: CLBeaconIdentityConstraint(uuid: uuid))
        }
    }

    func updateDistance(_ distance: CLProximity) {
        UIView.animate(withDuration: 0.8) {
            switch distance {
            case .unknown:
                NSLog("-- unknown")
                self.view.backgroundColor = .gray
            case .far:
                NSLog("-- far")
                self.view.backgroundColor = .blue
            case .near:
                NSLog("-- near")
                self.view.backgroundColor = .orange
            case .immediate:
                NSLog("-- immediate")
                self.view.backgroundColor = .red
            default:
                NSLog("-- default")
                self.view.backgroundColor = .gray
            }
        }
    }
}

// MARK: Unuse code
//extension HomeViewController: CBCentralManagerDelegate {
//    func centralManagerDidUpdateState(_ central: CBCentralManager) {
//        if central.state == .poweredOn {
//            NSLog("☘️ Bluetooth is On")
////            let xiaomiCBUUID1 = CBUUID(string: "0xFE95")        // Xiaomi Inc. 1/3
////            let xiaomiCBUUID2 = CBUUID(string: "0xFDAB")        // Xiaomi Inc. 2/3
////            let xiaomiCBUUID3 = CBUUID(string: "0xFDAA")        // Xiaomi Inc. 3/3
//            let mba0204BeaconCBUUID = CBUUID(string: "E57CE779-F24C-4133-AC3A-6C46A7C292CF")    // mba0204BeaconUUID
//
//            let dictionaryOfOptions = [CBCentralManagerScanOptionAllowDuplicatesKey: true]
//            centralManager.scanForPeripherals(withServices: [mba0204BeaconCBUUID], options: dictionaryOfOptions)
////            centralManager.scanForPeripherals(withServices: nil, options: dictionaryOfOptions)
//        } else {
//            print("☘️ Bluetooth is not active")
//        }
//    }
//
//    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
//        NSLog("☘️ didDiscover peripheral -> RSSI: \(RSSI)")
////        for item in advertisementData {
////            NSLog("key: \(item.key), value: \(item.value)")
////        }
////        print("RSSI: \(RSSI)")
//
////        AudioServicesPlaySystemSound(systemSoundID)
//
//        let peripheralName = peripheral.name
//        let advName = advertisementData[CBAdvertisementDataLocalNameKey] as? String
//
//        if peripheralName != nil || advName != nil {
//            NSLog("☘️ peripheralName: \(String(describing: peripheralName)), advName: \(String(describing: advName)), RSSI: \(RSSI)")
////            AudioServicesPlaySystemSound(systemSoundID)
//        }
//    }
//}
