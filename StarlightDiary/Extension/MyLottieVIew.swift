//
//  LottieView.swift
//  testLottieDemo1
//
//  Created by lujun on 2022/1/29.
//

//import SwiftUI
//import Lottie
//
//
//struct MyLottieVIew : UIViewRepresentable {
//
//    var animationName:String
//    @Binding var isPlaying : Bool
//    var isLoop:Bool = false
//
//    func makeUIView(context: Context) -> some UIView {
//        let view = UIView(frame: .zero)
//        view.backgroundColor = .clear
//        addLottieView(view: view)
//        return view
//    }
//    func updateUIView(_ uiView: UIViewType, context: Context) {
//        uiView.subviews.forEach { view in
//            if view.tag == 1009,let lottieView = view as? AnimationView{
//                if isPlaying{
//                    lottieView.play()
//                    if isLoop {
//                        lottieView.loopMode = .loop
//                    }
//                }else{
//                    lottieView.pause()
//                }
//            }
//        }
//    }
//    //MARK: - adding Lottie view
//    func addLottieView(view to: UIView) {
//        let lottieVIew = AnimationView(name: animationName,bundle: .main)
//        lottieVIew.backgroundColor = .clear
//        //MARK: for fing it in subview and used for animation
//        lottieVIew.tag = 1009
//        lottieVIew.translatesAutoresizingMaskIntoConstraints = false
//        let constraints = [
//            lottieVIew.widthAnchor.constraint(equalTo: to.widthAnchor),
//            lottieVIew.heightAnchor.constraint(equalTo: to.heightAnchor),
//        ]
//        to.addSubview(lottieVIew)
//        to.addConstraints(constraints)
//    }
//}
