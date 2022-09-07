//
//  ViewControllerImgWow.swift
//  ex00
//
//  Created by Vitaliy Plaschenkov on 14.08.2022.
//

import UIKit

class ViewControllerImgWow: UIViewController {
    var image: UIImage!
    var imageScrollView: UIScrollViewImagesWow!

    override func viewDidLoad() {
        super.viewDidLoad()
        imageScrollView = UIScrollViewImagesWow(frame: view.bounds)
        view.addSubview(imageScrollView)
        if image == nil{
            image = UIImage(systemName: "trash.slash")
            self.imageScrollView.set(image: image)
        } else {
            self.imageScrollView.set(image: image) }
    
    }
    
    func setupImageScrollView(){
        imageScrollView.translatesAutoresizingMaskIntoConstraints = false
        imageScrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        imageScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true

    }

}
