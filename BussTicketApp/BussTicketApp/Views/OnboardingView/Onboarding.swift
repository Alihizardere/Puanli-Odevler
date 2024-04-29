//
//  Onboarding.swift
//  BusTicketApp
//
//  Created by alihizardere on 29.04.2024.
//

import UIKit

class Onboarding: UIViewController{

    // MARK: - Properties
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextLabel: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    var slides = [OnboardingSlide]()
    var currentPage = 0 {
        didSet{
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextLabel.setTitle("Hadi Başlayalım", for: .normal)
            }else{
                nextLabel.setTitle("Sonraki", for: .normal)
            }
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
       
        slides = [
           OnboardingSlide(title: "Yolculuğa Hazır mısınız?", description: "Uygulamamızla kolayca otobüs biletlerinizi alın ve yolculuğa çıkmanın keyfini yaşayın!", image: UIImage(named: "slide1")!),
           OnboardingSlide(title: "Geniş Güzergah Seçenekleri", description: "Binlerce güzergah arasından seçim yapın ve istediğiniz noktaya hızlı ve güvenli bir şekilde ulaşın!", image: UIImage(named: "slide2")!),
           OnboardingSlide(title: "Güvenli ve Kolay Ödeme", description: "Güvenli ödeme yöntemleriyle biletinizi satın alın ve seyahatinizi planlamaya hemen başlayın!", image: UIImage(named: "slide3")!)
       ]
    }
    
    @IBAction func nextButton(_ sender: Any) {
        if currentPage == slides.count - 1 {
            let controller = storyboard?.instantiateViewController(withIdentifier: "homeTB") as! UITabBarController
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .flipHorizontal
            present(controller, animated: true)
        }else{
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
}

// MARK: - CollectionViewDelegate
extension Onboarding: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let slide = slides[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "onboardingCell", for: indexPath) as! OnboardingCell
        cell.setup(slide)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x/width)
    }
}
