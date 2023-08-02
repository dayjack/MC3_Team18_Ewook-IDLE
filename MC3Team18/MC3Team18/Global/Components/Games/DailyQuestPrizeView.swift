//
//  DailyQuestPrizeView.swift
//  MC3Team18
//
//  Created by NemoSquare on 7/31/23.
//

import SwiftUI

struct DailyQuestPrizeView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25,style: .continuous).fill(.black).frame(width: 341,height: 106).opacity(0.5)
            VStack(spacing:8){
                HStack(spacing:4){
                    Text("게임 획득 보상")
                        .pretendardMedium20()
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.GamePrizeGradient1,.GamePrizeGradient2],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                    Spacer()
                    Text("1,000")
                        .postNoBillsJaffnaExtraBold24()
                        .foregroundColor(.white)
                    Image("IconShop")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                }.padding(.horizontal,20)
                    .padding(.top,25)
                HStack(spacing:4){
                    Text("Daily Mission 완료 보상")
                        .pretendardMedium20()
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.GamePrizeGradient1,.GamePrizeGradient2],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                    Spacer()
                    Text("1,000")
                        .postNoBillsJaffnaExtraBold24()
                        .foregroundColor(.white)
                    Image("IconShop")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                }.padding(.horizontal,20).padding(.bottom,25)
            }.frame(width: 341,height: 106)
        }
    }
}

struct DailyQuestPrizeView_Previews: PreviewProvider {
    static var previews: some View {
        DailyQuestPrizeView()
    }
}
