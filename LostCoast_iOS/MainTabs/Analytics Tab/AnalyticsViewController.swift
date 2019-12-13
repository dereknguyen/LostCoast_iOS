//
//  AnalyticsViewController.swift
//  LostCoast_iOS
//
//  Created by Derek Nguyen on 8/27/18.
//  Copyright © 2018 Lost Coast Surf Tech. All rights reserved.
//

import UIKit
import Segmentio
import RealmSwift

class AnalyticsViewController: UIViewController {

    private var isInitialized = false
    
    private var segmentItems: [SegmentioItem] = {
        return [SegmentioItem(title: "History", image: nil), SegmentioItem(title: "Records", image: nil)]
    }()
    
    private var syncHistoryVC = SyncHistoryTableViewController.create()
    private var recordCollectionVC = RecordCollectionViewController.create()
    private lazy var viewControllers: [UIViewController] =  [syncHistoryVC, recordCollectionVC]
    
    @IBOutlet weak var segmentControl: Segmentio!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentScrollView: UIScrollView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        UIApplication.shared.statusBarView?.backgroundColor = #colorLiteral(red: 0.05999999866, green: 0.05999999866, blue: 0.05999999866, alpha: 1)
        
        setupScrollView()
        
        if isInitialized {
            SegmentControlBuilder.buildSegmentControl(segmentView: segmentControl, content: segmentItems, style: .onlyLabel)
            self.isInitialized = false
        }
        
        segmentControl.valueDidChange = {
            [weak self] _, index in
            
            if let scrollViewWidth = self?.contentScrollView.frame.width {
                let offsetX = scrollViewWidth * CGFloat(index)
                self?.contentScrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.05999999866, green: 0.05999999866, blue: 0.05999999866, alpha: 1)
        UIApplication.shared.statusBarView?.backgroundColor = #colorLiteral(red: 0.05999999866, green: 0.05999999866, blue: 0.05999999866, alpha: 1)
        
        syncHistoryVC.delegate = self
        contentScrollView.delegate = self
        self.isInitialized = true
    }
}

extension AnalyticsViewController {
    
    fileprivate func prepareViewControllers() -> [UIViewController] {
        return [SyncHistoryTableViewController.create(), RecordCollectionViewController.create()]
    }
    
    fileprivate func setupScrollView() {
        contentScrollView.contentSize = CGSize(
            width: UIScreen.main.bounds.width * CGFloat(viewControllers.count),
            height: contentView.frame.height
        )
        
        for (index, viewcontroller) in viewControllers.enumerated() {
            viewcontroller.view.frame = CGRect(x: UIScreen.main.bounds.width * CGFloat(index),
                                               y: 0,
                                               width: contentScrollView.frame.width,
                                               height: contentScrollView.frame.height)
            
            addChildViewController(viewcontroller)
            contentScrollView.addSubview(viewcontroller.view, options: .useAutoresize)
            viewcontroller.didMove(toParentViewController: self)
        }
        
    }
    
    
}

extension AnalyticsViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = floor(scrollView.contentOffset.x / scrollView.frame.width)
        segmentControl.selectedSegmentioIndex = Int(currentPage)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        contentScrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: 0)
    }
}

extension AnalyticsViewController: SyncHistoryDelegate {
    func selected(at indexPath: IndexPath, session: Session) {
        performSegue(withIdentifier: "toAnalysisHighlight", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = sender as? IndexPath else { return }
        if segue.identifier == "toAnalysisHighlight" {
            if let destination = segue.destination as? AnalysisHighlightController {
                let result = RealmServiceAPI.shared.realm.objects(Session.self).sorted(byKeyPath: "syncTime", ascending: false)
                destination.session = result[indexPath.row]
            }
        }
    }
}


