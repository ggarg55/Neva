//
//  ImageExtension.swift
//  Neva
//
//  Created by Gourav  Garg on 31/05/19.
//  Copyright © 2019 Gourav  Garg. All rights reserved.
//

import Foundation
import Kingfisher

extension UIImageView {
    
    func configureImage(_ url: URL?) {
        if let url = url {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let data = data, error == nil,
                    let image = UIImage(data: data)
                    else { return }
                DispatchQueue.main.async() {
                    self.image = image
                }
                }.resume()
        }
    }
    
    func configureImage(_ urlString: String) {
        let url = URL(string: urlString)
        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: url,
            placeholder: UIImage(named: "profile"),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
}

