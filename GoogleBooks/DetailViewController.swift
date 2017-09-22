//
//  DetailViewController.swift
//  GoogleBooks
//
//  Created by mac on 19/09/17.
//  Copyright © 2017 Sarfaraz. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController,UIWebViewDelegate {
    @IBOutlet weak var _imageBook: UIImageView!
    @IBOutlet weak var _labelTitle: UILabel!
    @IBOutlet weak var _labelSubtitle: UILabel!
    @IBOutlet weak var _labelAuthor: UILabel!
    @IBOutlet weak var _labelRating: UILabel!
    @IBOutlet weak var _imageRating: UIImageView!
    @IBOutlet weak var _labelStaticRating: UILabel!
    
    @IBOutlet weak var _buttonPreviewBook: UIButton!
    @IBOutlet weak var _parentViewForPreview: UIView!
    @IBOutlet weak var _webView: UIWebView!
    @IBOutlet weak var _btnClosePreview: UIButton!
    
    @IBOutlet weak var _indicator: UIActivityIndicatorView!
    var info :VolumeInfo!
    var webReaderLink : String?
    var arrayForValues = [UIView]()
    override func viewDidLoad() {
        super.viewDidLoad()
        arrayForValues.append(_labelTitle)
        arrayForValues.append(_labelSubtitle)
        arrayForValues.append(_labelAuthor)
        arrayForValues.append(_labelRating)
        arrayForValues.append(_imageRating)
        arrayForValues.append(_labelStaticRating)
        arrayForValues.append(_buttonPreviewBook)
    }
    
    func setDetailsForBook(){
        _labelTitle.text = "\(String(describing: info!.title!)) (\(String(describing: info!.publishedData!))) (\(String(describing: info!.pageCount)) pages)"
        if(info.authors != nil){
            _labelAuthor.text = "Author : \(String(describing: info.authors!.authors!))"
        }
        _labelSubtitle.text = info.subtitle
        _imageBook.layer.cornerRadius = 20
        _imageBook.layer.masksToBounds = true
        if(info.averageRating > 0){
            _labelRating.text = String(info.averageRating)
            _labelRating.isHidden = false
            _imageRating.isHidden = false
            _labelStaticRating.isHidden = false
        }else{
            _labelRating.isHidden = true
            _imageRating.isHidden = true
            _labelStaticRating.isHidden = true
        }
        if(webReaderLink != nil){
            _buttonPreviewBook.isHidden = false
        }else{
            _buttonPreviewBook.isHidden = true
        }
        
        for obj in self.arrayForValues{
            HHBounceAnimator.unfadeAll(obj: obj)
        }
        
    }
    @IBAction func btnCloseDetailClicked(_ sender: Any) {
        ViewDesign.sharedInstance.closeDetailView(detailView: self.view) { (fin) in
            self.view.removeFromSuperview()
            self.view = nil
        }
        
    }
    @IBAction func btnPreviewClicked(_ sender: Any) {
        _parentViewForPreview.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        _parentViewForPreview.isHidden = false
        HHBounceAnimator.zoomView(view: _parentViewForPreview)
        let url = URL(string: webReaderLink!)
        let req = URLRequest(url: url!)
        _webView.loadRequest(req)
    }
    @IBAction func btnClosePreview(_ sender: Any) {
        _parentViewForPreview.isHidden = true
    }
    func webViewDidStartLoad(_ webView: UIWebView) {
        _indicator.startAnimating()
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        _indicator.stopAnimating()
    }
}
