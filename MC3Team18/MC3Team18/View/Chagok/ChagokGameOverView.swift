//
//  ChagokGameOverView.swift
//  MC3Team18
//
//  Created by ChoiYujin on 2023/07/11.
//

import SwiftUI
import Foundation

struct ChagokGameOverView: View {
    
    @Binding var gameSelection: GameSelection
    @Binding var chagokStatus: ChagokStatus
    @EnvironmentObject var chagokScene: ChagokSKScene
    @Binding var isBestScore: Bool
    @State var gameoverOpacity: Double = 0
    @Binding var secondsx4: Int
    @Binding var isStarted: Bool
    @Binding var tapToStartOpacity: Double
    @AppStorage("ChagokMissionSuccess") var ChagokMissionSuccess: Bool = false
    @Binding var chagokScore: String
    @AppStorage("totalCoin") var totalCoin: Int = 1000
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.75)
            
            VStack {
                HStack {
                    if isBestScore {
                        Spacer()
                        ShareLink(item: photo, subject: Text(""), message: Text(""), preview: SharePreview(
                            photo.caption,
                            image: photo.image)) {
                                Image(systemName: "square.and.arrow.up")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 24)
                                    .pretendardBold20()
                                    .foregroundColor(.Yellow)
                            }
                    }
                }
                Spacer()
            }
            .padding(.top, 60)
            .padding(.trailing, 26)
            
            
            VStack(spacing: 11) {
                Spacer().frame(height: 157)
                
                if isBestScore {
                    Text("Best Score!")
                        .pretendardBold20()
                        .foregroundColor(.Yellow)
                } else {
                    Text("Your Score")
                        .pretendardLight32()
                }
                
                Text("\(chagokScene.chagokScore)")
                    .postNoBillsJaffnaRegular64()
                HStack {
                    Text("Best Score")
                        .pretendardRegular24()
                        .foregroundColor(.LightGray)
                    // 최고 점수로 교체하기
                    Text(chagokScore)
                        .pretendardSemiBold24()
                        .foregroundColor(.Yellow)
                }
                Spacer()
                
                HStack(spacing: 40){
                    
                    Button {
                        isBestScore = false
                        withAnimation(.easeOut(duration: 0.3)) {
                            gameSelection = .none
                        }
                    } label: {
                        gameOverGlassMorphicButtonLabel(systemName: "house", text: "Home", width: 136, height: 96)
                    }
                    
                    Button {
                        // 게임 상태 초기화 만들기
                        chagokScene.chagokScore = 0
                        chagokScene.leftCupStack.shuffle()
                        chagokScene.rightCupStack.removeAll()
                        chagokScene.currentIndex = 4
                        chagokScene.removeAllChildren()
                        chagokScene.mouthState = .none
                        chagokScene.boxCount = 0
                        secondsx4 = 120
                        chagokScene.isNotUpdate = false
                        isBestScore = false
                        
                        chagokScene.isNotUpdate = true
                        isStarted = true
                        tapToStartOpacity = 1
                        withAnimation(.easeOut(duration: 0.3)) {
                            gameoverOpacity = 0
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            chagokStatus = .game
                        }
                    } label: {
                        GameButtonLabel(width: 136, height: 96, systemName: "arrow.clockwise", buttonText: "Retry")
                    }
                    .buttonStyle(GameOverButtonStyle(gameSelection: .bubble))
                }
                .padding(.bottom, 160)
            }
            .foregroundColor(.white)
            VStack {
                if isBestScore {
                    LottieView(filename: "CelebLottieAnima")
                        .frame(width: 232, height: 66)
                        .padding(.top, 108)
//                        .padding(.top, 80)
                    
                }
                Spacer()
            }
        }
        .ignoresSafeArea()
        .statusBarHidden()
        .opacity(gameoverOpacity)
        .onAppear {
            UIApplication.shared.isIdleTimerDisabled = false
            chagokScene.isNotUpdate = true
            withAnimation(.easeOut(duration: 0.3)) {
                gameoverOpacity = 1
            }
            if chagokScene.boxLineCount >= 5{
                ChagokMissionSuccess = true
            }
            totalCoin = totalCoin + Int(chagokScene.chagokScore / 100)
        }
    }
}

//struct ChagokGameOverView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChagokGameOverView(gameSelection: .constant(.chagok), chagokStatus: .constant(.gameover), isBestScore: .constant(true), secondsx4: .constant(120))
//    }
//}

extension ChagokGameOverView {
    
    @MainActor
    var photo: TransferableUIImage {
        return .init(uiimage: dailyShareUIImage, caption: "SounDrill 기록 공유하기")
    }
    
    @MainActor
    var dailyShareUIImage: UIImage {
        let renderer = ImageRenderer(content: BestScoreShareView(bestScore: chagokScore, gameSelected: gameSelection))
        renderer.scale = 3.0
        return renderer.uiImage ?? .init()
    }
}
