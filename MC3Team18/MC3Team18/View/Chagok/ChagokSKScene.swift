//
//  ChagokSKScene.swift
//  MC3Team18
//
//  Created by NemoSquare on 7/12/23.
//

import ARKit
import RealityKit
import SpriteKit

enum CupName: String, CaseIterable {
    case BlueCup = "BlueCup"
    case GreenCup = "GreenCup"
    case PinkCup = "PinkCup"
    case RedCup = "RedCup"
    case YellowCup = "YellowCup"
}

enum MouthState{
    case none
    case a
    case e
    case i
    case o
    case u
}

class ChagokSKScene: SKScene, ObservableObject {
    
    var statusChanged: Bool = false
    var mouthState : MouthState = MouthState.none
    
    @Published var boxCount: Int = 0
    @Published var leftCupStack: [CupName] = []
    @Published var rightCupStack: [CupName] = []
    
    @Published var chagokScore: Int = 0
    
    @Published var isLoading = false
    @Published var isTutorial = false
    
    var isShuffleing = false
    var currentIndex = 4
    
    override func update(_ currentTime: TimeInterval) {
        if isTutorial {
            return
        }
        
        if mouthA > 0.5 && mouthI > 0.65 {
            if mouthState != MouthState.a && leftCupStack[self.currentIndex] == CupName.RedCup {
                dropbox(cupname: CupName.RedCup)
                mouthState = MouthState.a
                self.currentIndex = self.currentIndex == 0 ? 4 : self.currentIndex - 1
            }
        }
        
        if mouthA > 0.2 && mouthA < 0.4 && mouthI > 0.5{
            if mouthState != MouthState.e && leftCupStack[self.currentIndex] == CupName.YellowCup {
                dropbox(cupname: CupName.YellowCup)
                mouthState = MouthState.e
                self.currentIndex = self.currentIndex == 0 ? 4 : self.currentIndex - 1
            }
        }
        
        if mouthI > 0.5 && mouthA < 0.15{
            if mouthState != MouthState.i && leftCupStack[self.currentIndex] == CupName.GreenCup {
                dropbox(cupname: CupName.GreenCup)
                mouthState = MouthState.i
                self.currentIndex = self.currentIndex == 0 ? 4 : self.currentIndex - 1
            }
        }
        
        if mouthA > 0.5 && mouthI < 0.15 && leftCupStack[self.currentIndex] == CupName.BlueCup {
            if mouthState != MouthState.o{
                dropbox(cupname: CupName.BlueCup)
                mouthState = MouthState.o
                self.currentIndex = self.currentIndex == 0 ? 4 : self.currentIndex - 1
            }
        }
        
        if mouthU > 0.65 && mouthI < 0.5 && mouthA < 0.25 && leftCupStack[self.currentIndex] == CupName.PinkCup{
            if mouthState != MouthState.u{
                dropbox(cupname: CupName.PinkCup)
                mouthState = MouthState.u
                self.currentIndex = self.currentIndex == 0 ? 4 : self.currentIndex - 1
            }
        }
        
        if boxCount == 5 {
            isLoading = true
            var tempArray = self.rightCupStack.reversed()
            if tempArray.elementsEqual(self.leftCupStack) {
                // 추가 점수를 낸다.
                // 이 부분에 스택 완성 시 추가 스코어 로직 작성하시면 될 듯 합니다.
                chagokScore += 1000
            }
            
            self.leftCupStack.shuffle()
            self.boxCount = 0
            // 애니메이션 이펙트 상의해보기
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.removeAllChildren()
                self.mouthState = MouthState.none
                self.isLoading = false
            }
        }
    }
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = .clear
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        if let skView = view as? SKView {
            skView.allowsTransparency = true
            skView.isOpaque = false
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        removeAllChildren()
//        isMouthA = false
    }
    
    func dropbox(cupname : CupName) {
        
        if isLoading {
            return
        }
        
        print("Drop dropbox()")
        
        let cupNode = SKSpriteNode(imageNamed: cupname.rawValue)
        cupNode.position = CGPoint(x: size.width / 2, y: size.height - 20)
        cupNode.size = CGSize(width: 92, height: 56)
        cupNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 92, height: 56))
        cupNode.physicsBody?.allowsRotation = false
        cupNode.physicsBody?.restitution = 0
        addChild(cupNode)
        rightCupStack.append(cupname)
        boxCount += 1
        // 박스가 떨어질때 마다 스코어가 추가되어야 합니다.
        chagokScore += 100
        
    }
}
