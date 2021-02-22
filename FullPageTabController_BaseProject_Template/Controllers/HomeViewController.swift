//
//  HomeViewController.swift
//  FullPageTabController_BaseProject_Template
//
//  Created by Matthew Lyles on 2/21/21.
//


import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    let horizontalScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        scrollView.backgroundColor = .black
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isDirectionalLockEnabled = true
        return scrollView
    }()
    
    let forYouPageViewController = UIPageViewController(
        transitionStyle: .scroll,
        navigationOrientation: .vertical,
        options: [:]
    )
    
    let followingFeedViewController = UIPageViewController(
        transitionStyle: .scroll,
        navigationOrientation: .vertical,
        options: [:]
    )
    
    private var forYouPosts = PostModel.mockModels()
    private var followingPosts = PostModel.mockModels()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(horizontalScrollView)
        setupFeed()
        horizontalScrollView.contentOffset = CGPoint(x: view.width, y: 0)
        setupHeaderButtons()
    }
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewDidLayoutSubviews() {
        horizontalScrollView.frame = view.bounds
    }

    // MARK: - Methods
    func setupHeaderButtons() {
        let titles = ["Following", "For You"]
        let control = UISegmentedControl(items: titles)
        let titleSelected = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .black)]
        let titleNormal = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .semibold)]
            control.setTitleTextAttributes(titleNormal, for: .normal)
            control.setTitleTextAttributes(titleSelected, for: .selected)
        control.backgroundColor = .clear
        control.selectedSegmentTintColor = .clear
        control.tintColor = .clear
        control.selectedSegmentIndex = 1
        navigationItem.titleView = control
    }
    
    private func setupFeed() {
        horizontalScrollView.contentSize = CGSize(width: view.width * 2, height: view.height)
        setupFollowingFeed()
        setupForYouFeed()
    }
    
    fileprivate func setupFollowingFeed() {
        // set up paging controller
        guard let model = followingPosts.first else {
            return
        }
        let post = PostViewController(model: model)

        followingFeedViewController.setViewControllers(
            [post],
            direction: .forward,
            animated: false,
            completion: nil
        )
        followingFeedViewController.dataSource = self
        
        horizontalScrollView.addSubview(followingFeedViewController.view)
        followingFeedViewController.view.frame = CGRect(x: 0, y: 0, width: horizontalScrollView.width, height: horizontalScrollView.height)
        addChild(followingFeedViewController)
        followingFeedViewController.didMove(toParent: self)
    }
    
    fileprivate func setupForYouFeed() {
        // set up paging controller
        guard let model = forYouPosts.first else {
            return
        }
        let post = PostViewController(model: model)
        
        forYouPageViewController.setViewControllers(
            [post],
            direction: .forward,
            animated: false,
            completion: nil
        )
        forYouPageViewController.dataSource = self
        
        horizontalScrollView.addSubview(forYouPageViewController.view)
        forYouPageViewController.view.frame = CGRect(x: view.width, y: 0, width: horizontalScrollView.width, height: horizontalScrollView.height)
        addChild(forYouPageViewController)
        forYouPageViewController.didMove(toParent: self)
    }

}

// MARK: - Extensions

extension HomeViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let fromPost = (viewController as? PostViewController)?.model else {
            return nil
        }
        guard let index = currentPosts.firstIndex(where: {
            $0.identifier == fromPost.identifier
        }) else { return nil }
        
        if index == 0 {
            return nil
        }
        let priorIndex = index - 1
        let model = currentPosts[priorIndex]
        let vc = PostViewController(model: model)
        return vc
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let fromPost = (viewController as? PostViewController)?.model else {
            return nil
        }
        guard let index = currentPosts.firstIndex(where: {
            $0.identifier == fromPost.identifier
        }) else { return nil }
        
        guard index < (currentPosts.count - 1) else {
            return nil
        }
        let nextIndex = index + 1
        let model = currentPosts[nextIndex]
        let vc = PostViewController(model: model)
        return vc
    }
    
    var currentPosts: [PostModel] {
        if horizontalScrollView.contentOffset.x == 0 {
            //in following
            return followingPosts
        }
        // in for you
        return forYouPosts
    }
    
}