//
//  UIScrollViewImagesWow.swift
//  ex00
//
//  Created by Vitaliy Plaschenkov on 14.08.2022.
//

import UIKit

class UIScrollViewImagesWow: UIScrollView, UIScrollViewDelegate {

    var imageZoomView: UIImageView!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        self.delegate = self
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.decelerationRate = UIScrollView.DecelerationRate.fast
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(image: UIImage){
        imageZoomView?.removeFromSuperview()
        imageZoomView = nil
        
        imageZoomView = UIImageView(image: image)
        self.addSubview(imageZoomView)
        
        configurateFor(imageSize: image.size)
        
    }
    
    func configurateFor(imageSize: CGSize){
        self.contentSize = imageSize
        setCurrentMaxAndMinZoomScale()
        self.zoomScale = self.minimumZoomScale
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.centerImage()
    }
    
    func setCurrentMaxAndMinZoomScale(){
        let boundSize = self.bounds.size
        let imageSize = imageZoomView.bounds.size
        
        let xScale = boundSize.width / imageSize.width
        let yScale = boundSize.height / imageSize.height
        let minScale = min(xScale, yScale)
        
        var maxScale: CGFloat = 1.0
        if minScale < 0.1 {
            maxScale = 0.3
        }
        if minScale >= 0.1 && minScale < 0.5{
            maxScale = 0.7
        }
        if minScale >= 0.5{
            maxScale = max(1.0, minScale)
        }
        
        self.minimumZoomScale = minScale
        self.maximumZoomScale = maxScale
    }
    
    func centerImage(){
        let boundSize = self.bounds.size
        var frameToCenter = imageZoomView.frame
        
        if frameToCenter.size.width < boundSize.width {
            frameToCenter.origin.x = (boundSize.width - frameToCenter.size.width) / 2
        }
        else {
            frameToCenter.origin.x = 0
        }
        if frameToCenter.size.height < boundSize.height {
            frameToCenter.origin.y = (boundSize.height - frameToCenter.size.height) / 3.5
        }
        else {
            frameToCenter.origin.y = 0
        }
        imageZoomView.frame = frameToCenter
    }
    // MARK: UISCOLLVIEWDELEGATE
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageZoomView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.centerImage()
    }
}
