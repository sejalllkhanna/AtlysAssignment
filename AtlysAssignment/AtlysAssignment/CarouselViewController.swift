//
//  CarouselViewController.swift
//  AtlysAssignment
//
//  Created by Sejal Khanna on 30/08/24.
//

import Foundation
import UIKit

class CarouselViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private var imageViews = [UIImageView]()
    private let pageControl = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeader()
        setupScrollView()
        setupImages()
        setupPageControl()
        setupMainContent()
    }
    
    private func setupHeader() {
        let headerImageView = UIImageView(image: UIImage(named: "Logo"))
        headerImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerImageView)
        NSLayoutConstraint.activate([
            headerImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            headerImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            headerImageView.widthAnchor.constraint(equalToConstant: 80),
            headerImageView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = false
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 300),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80)
        ])
    }
    
    private func setupImages() {
        let images = [UIImage(named: "Malasiya"), UIImage(named: "USA"), UIImage(named: "Europe"), UIImage(named: "Australia")]
        var previousImageView: UIImageView?
        let imageWidthMultiplier: CGFloat = 0.5
        let spacing: CGFloat = -5
        
        for image in images {
            let imageView = UIImageView(image: image)
            imageView.backgroundColor = .purple
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFill
            imageView.layer.cornerRadius = 15
            imageView.clipsToBounds = true
            scrollView.addSubview(imageView)
            imageViews.append(imageView)
            
            NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: imageWidthMultiplier),
                imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
                imageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                imageView.leadingAnchor.constraint(equalTo: previousImageView?.trailingAnchor ?? scrollView.leadingAnchor, constant: previousImageView == nil ? 5 : spacing)
            ])
            
            previousImageView = imageView
        }
        
        if let lastImageView = imageViews.last {
            lastImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20).isActive = true
        }
        
        let inset = (view.frame.width * (1 - imageWidthMultiplier)) / 2 - spacing
        scrollView.contentInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
    }

    
    private func setupPageControl() {
        pageControl.numberOfPages = imageViews.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .systemPurple
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pageControl)
        NSLayoutConstraint.activate([
            pageControl.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 10),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let middleIndex = imageViews.count / 2
        let imageWidth = scrollView.frame.width * 0.7
        let contentOffsetX = (CGFloat(middleIndex) * (imageWidth - 5)) - (scrollView.contentInset.left)
        scrollView.contentOffset = CGPoint(x: contentOffsetX, y: 0)
        if !imageViews.isEmpty {
            let middleImageView = imageViews[middleIndex]
            middleImageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }
    }
    
    private func setupMainContent() {
        let titleLabel = UILabel()
        titleLabel.text = "On Time"
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        let secondTitleLabel = UILabel()
        secondTitleLabel.text = "Get Visas"
        secondTitleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        secondTitleLabel.textAlignment = .center
        secondTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(secondTitleLabel)
        
        let textField = UITextField()
        textField.placeholder = "Enter mobile number"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        let countryCodeLabel = UILabel()
        countryCodeLabel.text = "🇮🇳 +91"
        countryCodeLabel.font = UIFont.systemFont(ofSize: 16)
        countryCodeLabel.sizeToFit()
        
        textField.leftView = countryCodeLabel
        textField.leftViewMode = .always
        view.addSubview(textField)
        
        let continueButton = UIButton(type: .system)
        continueButton.setTitle("Continue", for: .normal)
        continueButton.backgroundColor = .systemPurple
        continueButton.setTitleColor(.white, for: .normal)
        continueButton.layer.cornerRadius = 8
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(continueButton)
        
        let googleButton = UIButton(type: .custom)
        googleButton.setImage(UIImage(named: "google_icon"), for: .normal)
        googleButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(googleButton)
        
        let appleButton = UIButton(type: .custom)
        appleButton.setImage(UIImage(named: "apple_icon"), for: .normal)
        appleButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(appleButton)
        
        let emailButton = UIButton(type: .custom)
        emailButton.setImage(UIImage(named: "fb_icon"), for: .normal)
        emailButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emailButton)
        
        let termsLabel = UILabel()
        let termsText = "By continuing, you agree to our terms & privacy policy."
        let attributedString = NSMutableAttributedString(string: termsText)
        attributedString.addAttribute(.foregroundColor, value: UIColor.systemPurple, range: (termsText as NSString).range(of: "terms"))
        attributedString.addAttribute(.foregroundColor, value: UIColor.systemPurple, range: (termsText as NSString).range(of: "privacy policy"))
        termsLabel.attributedText = attributedString
        termsLabel.font = UIFont.systemFont(ofSize: 12)
        termsLabel.textAlignment = .center
        termsLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(termsLabel)
        
        NSLayoutConstraint.activate([
            secondTitleLabel.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 20),
            secondTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: secondTitleLabel.bottomAnchor, constant: 5),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textField.heightAnchor.constraint(equalToConstant: 44),
            
            continueButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            continueButton.heightAnchor.constraint(equalToConstant: 44),
            
            googleButton.topAnchor.constraint(equalTo: continueButton.bottomAnchor, constant: 20),
            googleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -80),
            googleButton.widthAnchor.constraint(equalToConstant: 40),
            googleButton.heightAnchor.constraint(equalToConstant: 40),
            
            appleButton.topAnchor.constraint(equalTo: continueButton.bottomAnchor, constant: 20),
            appleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appleButton.widthAnchor.constraint(equalToConstant: 40),
            appleButton.heightAnchor.constraint(equalToConstant: 40),
            
            emailButton.topAnchor.constraint(equalTo: continueButton.bottomAnchor, constant: 20),
            emailButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 80),
            emailButton.widthAnchor.constraint(equalToConstant: 40),
            emailButton.heightAnchor.constraint(equalToConstant: 40),
            
            termsLabel.topAnchor.constraint(equalTo: emailButton.bottomAnchor, constant: 20),
            termsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

extension CarouselViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let centerPoint = view.convert(view.center, to: scrollView)
        
        for imageView in imageViews {
            let distance = abs(centerPoint.x - imageView.center.x)
            let scale = max(1 - distance / scrollView.frame.width, 0.7)
            imageView.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
    }
}
