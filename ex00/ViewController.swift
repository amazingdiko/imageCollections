//
//  ViewController.swift
//  ex00
//
//  Created by Vitaliy Plaschenkov on 13.08.2022.
//UICollectionView
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var imgUrl = [
        URL(string: "sadasdasasdadshttps://3dnews.ru/assets/external/illustrations/2021/03/26/1035841/xkWsLGFb5BcHoERUDMtZ9"),
                  URL(string: "https://3dnews.ru/assets/external/illustrations/2021/03/26/1035841/xkWsLGFb5BcHoERUDMtZ9b.jpg"), URL(string: "https://images.wallpapersden.com/image/download/world-of-warcraft-the-lich-king-4k_bWdubGaUmZqaraWkpJRma21lrWZlamVnZWZubGZs.jpg"),
        URL(string: "https://images7.alphacoders.com/117/1176255.jpg"),
        URL(string: "https://images4.alphacoders.com/765/765805.jpg"),
        URL(string: "https://images7.alphacoders.com/969/969784.jpg"),
        URL(string: "https://images4.alphacoders.com/969/969693.jpg"),
        URL(string: "https://i.gyazo.com/3dbd9d5b6ca401bac38317c6ced608f9.png")]

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgUrl.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCellImgCell
        let viewWowImage = self.storyboard?.instantiateViewController(withIdentifier: "ViewControllerImgWow") as! ViewControllerImgWow
        viewWowImage.image = cell.imgView.image
        self.navigationController?.pushViewController(viewWowImage, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCellImgCell", for: indexPath) as! CollectionViewCellImgCell
        URLSession.shared.dataTask(with: imgUrl[indexPath.item]!) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    self.addAlert(self.imgUrl[indexPath.item]!)
                }
                print (error)
                return
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    self.addAlert(self.imgUrl[indexPath.item]!)
                }
                return
            }
            let releaseImg = UIImage(data: data)
            DispatchQueue.main.async {
                cell.activityLoad.stopAnimating()
                cell.activityLoad.isHidden = true
                cell.imgView.image = releaseImg
            }
        }.resume()
        return cell
    }
    

    private func addAlert(_ imgUrl: URL){
        let alert = UIAlertController(title: "Warning", message: "Cannot access to \(imgUrl)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    @IBOutlet weak var collectImages: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectImages?.register(UINib(nibName: "CollectionViewCellImgCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCellImgCell")
        self.collectImages.dataSource = self
        self.collectImages.delegate = self
    }
}
