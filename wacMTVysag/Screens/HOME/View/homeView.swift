//
//  contentView2.swift
//  wacMTVysag
//
//  Created by vysag k on 19/02/23.
//

//
//  ContentView.swift
//  wacMTVysag
//
//  Created by vysag k on 17/02/23.
//

import SwiftUI
import Kingfisher

struct homeView: View {
    @StateObject private var viewModel = homeViewModel()
    @State private var searchText:String = ""
    @State private var isFav:Bool = false
    @State private var bgColor = [Color(hex: "FAE7E7"),Color(hex: "F7F3C9"),Color(hex: "FCF0F0"),Color(hex: "802EBE",alpha: 0.17),Color(hex: "FFF2D9")]
    var body: some View {
        
        ZStack(alignment: .center){
            indictorView
                .opacity(viewModel.isLoading ? 1 : 0)
            if !viewModel.isLoading{
                productHome
                    .opacity(!viewModel.isLoading ? 1 : 0)
            }
        }.frame(maxWidth:.infinity,maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
        
            .task{
                await viewModel.getProducts()
                
            }
        
    }
}
extension homeView{
    private var indictorView : some View{
        HStack{
            ProgressView("Loading")
                .scaleEffect(1.5)
                .progressViewStyle(CircularProgressViewStyle(tint: .green))
        }
    }
}
extension homeView{
    private var productHome:some View{
        VStack( spacing: 0){
            HStack{
                Image("Glass").resizable().scaledToFit()
                    .frame(width: 19,height: 19).padding(.leading,14)
                TextField("Search", text: $searchText)
                    .padding(.leading,7)
                // .textFieldStyle(.roundedBorder)
                Image("barcode").resizable().renderingMode(.template).foregroundColor(Color(hex: "727272",alpha: 0.7)).scaledToFit().frame(width: 22,height: 19).padding(.trailing,15)
            }.frame(width: getRect().width - 14,height: 47)
                .background(Color(hex: "FAFAFA"))
            
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color(hex: "E5E5E5"), lineWidth: 1)
                )
            ScrollView(.horizontal, showsIndicators: false) {
                HStack( spacing: 16){
                    
                    ForEach(0 ..< viewModel.data[0].values.count, id: \.self) { i in
                        VStack{
                            HStack{
                                KFImage(URL(string: viewModel.data[0].values[i].imageURL! ))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 48,height: 48)
                            }
                            .frame(width: 70,height: 70)
                            .background(bgColor[i])
                            .clipShape(Circle())
                            
                            
                            Text(viewModel.data[0].values[i].name!)
                        }
                    }
                    
                }.padding(.top,16)
                    .padding(.leading,7)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack{
                    ForEach(0 ..< viewModel.data[1].values.count, id: \.self) { i in
                        
                        HStack{
                            KFImage(URL(string: viewModel.data[1].values[i].bannerURL! ))
                                .resizable()
                                .scaledToFit()
                        }
                        .frame(width: 330,height: 181)
                        
                        
                    }
                }.padding(.top,15)
                    .padding(.leading,10)
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack{
                    ForEach(0 ..< viewModel.data[2].values.count, id: \.self) { i in
                        
                        VStack( spacing: 0){
                            HStack{
                                HStack{
                                    Text("\(viewModel.data[2].values[i].offer!)% OFF").foregroundColor(.white).font(.system(size: 10)).fontWeight(.bold).padding(.leading,4)
                                }.frame(height: 16,alignment: .leading).background(Color(hex: "E8393A"))
                                    .opacity(viewModel.data[2].values[i].offer! > 0 ? 1 : 0 )
                                Spacer()
                                Button(action: {
                                    //isFav.toggle()
                                    
                                }, label: {
                                    Image("favourite").resizable().scaledToFit()
                                        .frame(width: 18,height: 16).padding(.trailing,10)
                                    
                                })
                                
                            }.frame( maxWidth: .infinity)
                                .frame( height: 12)
                                .padding(.top,18)
                            HStack{
                                KFImage(URL(string: viewModel.data[2].values[i].image! ))
                                    .resizable()
                                    .scaledToFit()
                            }.frame(width: 134,height: 105,alignment: .center)
                                .padding(.top,7)
                            HStack{
                                HStack{
                                    Image("truck").resizable().scaledToFit()
                                    //.frame(width: 19,height: 12)
                                }.frame(width: 25,height: 15).background(Color(hex: "FFCB01"))
                                    .padding(.top,8)
                                    .padding(.leading,15)
                                    .cornerRadius(4)
                                    .opacity(viewModel.data[2].values[i].isExpress! ? 1 : 0)
                                Spacer()
                            }.frame( maxWidth: .infinity)
                                .frame( height: 12)
                            HStack{
                                Text("\(viewModel.data[2].values[i].actualPrice!)")
                                    .font(.system(size: 12))
                                    .strikethrough(viewModel.data[2].values[i].offerPrice! != viewModel.data[2].values[i].actualPrice!)
                                    .frame(height: 14)
                                    .foregroundColor(Color(hex: "727272"))
                                Spacer()
                            }.padding(.top,10).padding(.leading,15)
                            HStack{
                                Text("\(viewModel.data[2].values[i].offerPrice!)")
                                    .font(.system(size: 15))
                                    .fontWeight(.bold)
                                
                                    .frame(height: 14)
                                    .foregroundColor(Color(hex: "1D211E"))
                                Spacer()
                            }.padding(.top,2).padding(.leading,15)
                                .opacity(viewModel.data[2].values[i].offerPrice! != viewModel.data[2].values[i].actualPrice! ? 1 : 0)
                            HStack{
                                Text("\(viewModel.data[2].values[i].name!)")
                                    .font(.system(size: 14))
                                    .multilineTextAlignment(.leading)
                                    .frame(alignment: .leading)
                                    .foregroundColor(Color(hex: "1D211E"))
                                    .padding(.leading,15)
                                    .padding(.trailing,12)
                                    .padding(.top,10)
                                Spacer()
                            }.frame(maxWidth:.infinity)
                            Spacer()
                        }
                        .frame(width: 158,height: 285)
                        .border(Color(hex: "EDEDED"),width: 1)
                        
                    }
                    Spacer().frame(width: 6)
                }.padding(.top,20)
                    .padding(.leading,10)
                // .shadow(color: .gray.opacity(0.2), radius: 0.005, x: 0, y: -1)
            }
            
        }.frame(maxWidth:.infinity,maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
        
    }
}

extension View {
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
}
