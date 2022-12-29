//
//  ViewController.swift
//  DemoImageView
//
//  Created by vu van quang on 12/29/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var contentImageView: UIImageView!
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    
    @IBOutlet weak var progressView: UIProgressView!
    
    
    //MARK: timer
    //vòng lặp, lặp lại 1 khối lệnh, công vc nhiều lần, có thời gian delay
    var abcTimer:Timer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        activity.style = .large
        activity.color = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        activity.isAnimating // check xem có đang chạy hiệu ứng hay k
        activity.startAnimating()
        
        activity.hidesWhenStopped = true // cho ẩn đi khi đã dừng
        
        
        
        
        // Hiển thị ảnh từ access (Local)
       // contentImageView.image = UIImage(named: "background.")
        contentImageView.contentMode = .scaleAspectFill // hiển thị scale ảnh kín khung imageView (dữ nguyên tỷ lệ ảnh, ko bị méo)
        
        let url = URL(string: "https://static.vecteezy.com/system/resources/previews/001/849/553/original/moern-gold-background-free-vector.jpg")
        
        do {
            //Thử làm 1, nhiều hành động ko chắc chắn.
            //Nếu thành công sẽ làm tiếp câu lệnh tiếp theo
            let data = try Data(contentsOf: url!)
            contentImageView.image = UIImage(data: data)
            
            activity.stopAnimating()//dừng hoạt ảnh nếu load/ ko load dc ảnh
        } catch let error {
            //Nếu thất bại, catch sẽ bắt, ko cần thực hiện câu lệnh sau try
            print("something wrong: \(error.localizedDescription)")
        }
        
       /*
        //Hiển thị ảnh từ URL
        
           //B1: Lấy url trả về ảnh
           let url = URL(string: "https://static.vecteezy.com/system/resources/previews/001/849/553/original/modern-gold-background-free-vector.jpg")
        //    //B2: Lấy dữ liệu từ URL đó
          let data = try? Data(contentsOf: url!)
        //B3: convert Data về UIImage sau đó gán vào imageView
        contentImageView.image = UIImage(data: data!)
        
        */
        
        
        
        //progressView
        //thể hiện tiến độ hoàn thành công vc
        progressView.progressTintColor = .cyan// màu tiến độ đã hoàn thành
        progressView.trackTintColor = .white //màu của phần chưa hoàn thành
        progressView.progress = 0 // tiến độ công vc, chạy từ 0->1
        
        
        
        setUpTimer()
    }
    
    
    func setUpTimer() {
        //timeInterval: thời gian delay để lặp lại khối lệnh
        //repeat: có lặp lại hay k
        //block: khối lệnh cần thực hiện
        abcTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { _ in
            self.progressView.progress += 0.1
            
            if self.progressView.progress >= 1 {
                self.abcTimer.invalidate()//cjo Timer dừng lại
                self.activity.stopAnimating()
            }
        })
        
        //test update code in github
    }
}

