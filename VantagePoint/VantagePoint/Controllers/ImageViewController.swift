//
//  ImageViewController.swift
//  VantagePoint
//
//  Created by Juan Manuel Tome on 15/06/2020.
//  Copyright © 2020 Juan Manuel Tome. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {

    var imageView: UIImageView? = nil
    
    let scrollView = UIScrollView(frame: .zero)

    lazy var aMultiplier: CGFloat = {
           return (imageView?.image?.size.width)! / (imageView?.image?.size.height)!
       }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let imageView = imageView else { fatalError() }
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .center
        let gstr = UITapGestureRecognizer(target: self, action: #selector(doubleTap))
        gstr.numberOfTouchesRequired = 1
        gstr.delaysTouchesBegan = true
        
        
        //esto me da problemas con el scrollview, 
        imageView.widthAnchor.constraint(equalToConstant: screenWidth / 1).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1 / aMultiplier).isActive = true
        
        
        
        scrollView.addGestureRecognizer(gstr)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 5
        scrollView.zoomScale = 1

        imageView.backgroundColor = .red
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        //scrollView.backgroundColor = .red
        
        imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true
        //imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        //imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        //imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        //imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        view.backgroundColor = .white
        //navigationController?.hidesBarsOnTap = true
       

    }
    @objc private func doubleTap(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            if scrollView.zoomScale == scrollView.minimumZoomScale {
                scrollView.zoom(to: { [weak self] in
                    var zoomRect = CGRect.zero
                    zoomRect.size.height = (self?.imageView?.frame.size.height)! / scrollView.maximumZoomScale
                    zoomRect.size.width = (self?.imageView?.frame.size.width)! / scrollView.maximumZoomScale
                    let x = sender.location(in: sender.view).x
                    let y = sender.location(in: sender.view).y
                    zoomRect.origin.x = x
                    zoomRect.origin.y = y
                    return zoomRect
                    }(),
                    animated: true)
            } else {
                scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
            }
        }
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
//    func scrollViewDidZoom(_ scrollView: UIScrollView) {
//        centerImage()
//    }
//    func centerImage(){
//        
//    }
    
//    override var prefersStatusBarHidden: Bool {
//           return navigationController?.isNavigationBarHidden == true
//       }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }

   

    
    
    init(image: UIImage?) {
        let imgView: UIImageView = {
            let view = UIImageView(frame: .zero)

            view.image = image
            //view.widthAnchor.constraint(equalToConstant: 200).isActive = true
            //view.heightAnchor.constraint(equalToConstant: 200).isActive = true
            view.contentMode = .scaleAspectFill
            return view
        }()
        self.imageView = imgView
        super.init(nibName: nil, bundle: nil)
    }
    convenience init() {
        self.init(image: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
