//
//  GFAvatarImageView.swift
//  GHFollowers
//
//  Created by Kwaku Dapaah on 1/24/24.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    //created instance of the cache
    let cache             = NetworkManager.shared.cache
    
    let placeholderImage  = UIImage(named: "avatar-placeholder")!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false       
    }

    //I will refactor this out later to move this to the network manager
    func downloadImage(from urlString: String) {
        
        let cacheKey = NSString(string: urlString)
        
        //Check cache to see if we have the image stored using the cachekey created from the urlString as the Key
        if let image = cache.object(forKey: cacheKey) {
            self.image = image
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else {return}
            if error != nil {
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            
            guard let image = UIImage(data: data) else { return }
            
            // Store image into cache
            self.cache.setObject(image, forKey: cacheKey)
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
        
        task.resume()
    }

}
