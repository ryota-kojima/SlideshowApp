//
//  ViewController.swift
//  SlideshowApp
//
//  Created by 小嶋暸太 on 2018/08/01.
//  Copyright © 2018年 小嶋暸太. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //メインの画像
    @IBOutlet weak var smallimage: UIImageView!
    //再生ボタン
    @IBOutlet weak var Playbuttons: UIButton!
    
    @IBOutlet weak var buckB: UIButton!
    
    @IBOutlet weak var nextB: UIButton!
    //画像の名前、繰り替え位処理ではめても良いが少ないので宣言
    var imagename:[String]=["1.JPG","2.JPG","3.JPG","4.JPG"]
    //imagenameの要素
    var imagedig:Int=0
    
    //timer用の入れ物
    var timer:Timer!=nil
    //再生が押されているかどうか
    var play:Bool=false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        showimage()
    }
    
    func showimage(){
        let image=UIImage(named: imagename[imagedig])
        
        smallimage.image=image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //画像がタップされた時の反応
    @IBAction func BIgScalesegue(_ sender: Any) {
        performSegue(withIdentifier: "result", sender: nil)
    }
    
    //画面遷移時に呼ばれる処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //遷移先のクラスを取得して、今表示されている画像データの名前を取得
        let resultcontroller:ResultController=segue.destination as! ResultController
        
        resultcontroller.imagename=imagename[imagedig]
        
    }
    
    @IBAction func Playbutton(_ sender: Any) {
        
        if !play{
            //停止中の処理
            if timer==nil{
            timer=Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(updatetimer(_:)), userInfo: nil, repeats: true)
            }
            Playbuttons.setTitle("停止", for: .normal)
            play=true
            buckB.isEnabled=false
            nextB.isEnabled=false
        }else{
            //再生中の処理
            if timer != nil{
                self.timer.invalidate()
                timer=nil
            }
            Playbuttons.setTitle("再生", for: .normal)
            play=false
            buckB.isEnabled=true
            nextB.isEnabled=true
        }
        
    }
    
    @objc func updatetimer(_ timer:Timer){
        if imagedig==imagename.count-1{
            imagedig=0
        }else{
            imagedig+=1
        }
        showimage()
    }
    
    @IBAction func Buckbutton(_ sender: Any) {
        
        //要素が0なら３そうじゃないなら一つ戻るようにして表示
        if imagedig==0{
            imagedig=imagename.count-1
        }else{
            imagedig-=1
        }
        showimage()
        
    }
    
    @IBAction func nextbutton(_ sender: Any) {
        if !play{
        //要素が最大値なら0に、そうじゃないなら、ひとつ進むようにして表示
        if imagedig==imagename.count-1{
            imagedig=0
        }else{
            imagedig+=1
        }
        showimage()
        }
    }
    
    
    @IBAction func unwind(_ segue:UIStoryboardSegue){
        
    }
    
    


}

