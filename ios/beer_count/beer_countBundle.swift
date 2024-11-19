//
//  beer_countBundle.swift
//  beer_count
//
//  Created by Paul Krenn on 29.10.24.
//

import WidgetKit
import SwiftUI

@main
struct beer_countBundle: WidgetBundle {
    var body: some Widget {
        BeerCountWidget()
        beer_countControl()
        beer_countLiveActivity()
    }
}
