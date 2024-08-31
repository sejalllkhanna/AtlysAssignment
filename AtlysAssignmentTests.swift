//
//  AtlysAssignmentTests.swift
//  AtlysAssignmentTests
//
//  Created by Sejal Khanna on 30/08/24.
//

import XCTest
@testable import AtlysAssignment

class CarouselViewControllerTests: XCTestCase {
    
    var viewController: CarouselViewController!
    
    override func setUp() {
        super.setUp()
        viewController = CarouselViewController()
        viewController.loadViewIfNeeded()
    }
    
    override func tearDown() {
        viewController = nil
        super.tearDown()
    }
    
    // Test for setting up the header image
    func testHeaderImageSetup() {
        let headerImageView = viewController.view.subviews.compactMap { $0 as? UIImageView }.first(where: { $0.image == UIImage(named: "Logo") })
        XCTAssertNotNil(headerImageView, "Header Image View should be set up with the 'Logo' image")
    }
    
    // Test for setting up the scroll view
    func testScrollViewSetup() {
        XCTAssertNotNil(viewController.scrollView, "Scroll View should be set up")
    }
    
    // Test for setting up the page control
    func testPageControlSetup() {
        XCTAssertEqual(viewController.pageControl.numberOfPages, 4, "Page control should have 4 pages")
        XCTAssertEqual(viewController.pageControl.currentPage, 0, "Current page of page control should be 0 initially")
    }
    
    // Test for the number of images in the scroll view
    func testNumberOfImagesInScrollView() {
        XCTAssertEqual(viewController.imageViews.count, 4, "Scroll View should have 4 images")
    }
    
    // Test for imageView layout and transformation on viewDidLayoutSubviews
    func testImageViewLayoutAndTransformation() {
        viewController.viewDidLayoutSubviews()
        
        // Middle imageView should be scaled up
        let middleIndex = viewController.imageViews.count / 2
        let middleImageView = viewController.imageViews[middleIndex]
        XCTAssertEqual(middleImageView.transform, CGAffineTransform(scaleX: 1.2, y: 1.2), "Middle image view should be scaled up")
        
        // Other imageViews should be at normal scale
        for (index, imageView) in viewController.imageViews.enumerated() where index != middleIndex {
            XCTAssertEqual(imageView.transform, CGAffineTransform(scaleX: 1.0, y: 1.0), "Non-middle image views should have normal scale")
        }
    }
    
    // Test for scrollView delegate method
    func testScrollViewDidScroll() {
        viewController.scrollView.contentOffset = CGPoint(x: 100, y: 0)
        viewController.scrollViewDidScroll(viewController.scrollView)
        
        // Test if the images scale correctly during scrolling
        let centerPoint = viewController.view.convert(viewController.view.center, to: viewController.scrollView)
        for imageView in viewController.imageViews {
            let distance = abs(centerPoint.x - imageView.center.x)
            let scale = max(1 - distance / viewController.scrollView.frame.width, 0.7)
            XCTAssertEqual(imageView.transform, CGAffineTransform(scaleX: scale, y: scale), "Image views should scale according to their distance from the center")
        }
    }
    
    // Test for main content setup
    func testMainContentSetup() {
        let titleLabel = viewController.view.subviews.compactMap { $0 as? UILabel }.first(where: { $0.text == "On Time" })
        XCTAssertNotNil(titleLabel, "Title label should be set up with 'On Time' text")
        
        let secondTitleLabel = viewController.view.subviews.compactMap { $0 as? UILabel }.first(where: { $0.text == "Get Visas" })
        XCTAssertNotNil(secondTitleLabel, "Second title label should be set up with 'Get Visas' text")
        
        let textField = viewController.view.subviews.compactMap { $0 as? UITextField }.first(where: { $0.placeholder == "Enter mobile number" })
        XCTAssertNotNil(textField, "Text field should be set up with placeholder 'Enter mobile number'")
        
        let continueButton = viewController.view.subviews.compactMap { $0 as? UIButton }.first(where: { $0.title(for: .normal) == "Continue" })
        XCTAssertNotNil(continueButton, "Continue button should be set up with 'Continue' text")
        
        let termsLabel = viewController.view.subviews.compactMap { $0 as? UILabel }.first(where: { $0.attributedText?.string.contains("By continuing, you agree to our terms & privacy policy.") ?? false })
        XCTAssertNotNil(termsLabel, "Terms label should be set up with terms & privacy policy text")
    }
}
