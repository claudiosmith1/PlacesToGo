//
//  MockPlace.swift
//  PlacesToGoTests
//
//  Created by Claudio Smith on 14/12/2020.
//  Copyright © 2020 smith.c. All rights reserved.
//

import UIKit
import RxSwift

@testable import PlacesToGo

struct MockPlace {
    
    static func fakePlaces() -> [Place] {
        var places = [Place]()
        let data = Bundle(for: AppDelegate.self).loadData(from: "PlaceMock")
        do {
            let results = try JSONDecoder().decode(Results.self, from: data!)
            places = results.place!
        } catch { print(error)  }
        return places
    }
    
    static func mockImage() -> UIImage {
        
        let image = UIImage(named: "bbbar", in: PlaceViewModelTest().getBundle(), compatibleWith: nil)
        return image!
    }
}

extension PlaceViewData {
    
    static func mockViewData() -> Self {
        let photo = PhotoViewData(height: 205, width: 375, photoReference: "ATtYBwKg-UpjEABTjT3dyFxcCHN4rkn2GWbSh3pI7WFz565s4vn68AnChHvj1VJt-W3uWMVlWkaHHDzye3KesqKXaXOMtulUBimdl_1uLrqZjcU_R6AKNQUKTWY0GWvXMBO8aNvAsDq80YjE3U49KSNkP36L-nF0pKY4_rPFs9qbVVOzOloV")
        
        return self.init("Churrasquinho Miranda", photo, "4.5", PlaceState.open, "10",
                  "https://maps.gstatic.com/mapfiles/place_api/icons/v1/png_71/restaurant-71.png", 4.5)
    }
}
