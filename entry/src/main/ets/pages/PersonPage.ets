import router from '@ohos.router'
@Entry
@Component
struct MainPage {
  build() {
    Scroll(){
      Column(){
        Column(){
          Row(){
            Image($r("app.media.return")).width(24).margin({
              right:285,
              top:5
            })
              .onClick( e=> router.back())
            Image($r("app.media.task")).width(24).onClick(() =>{
              router.pushUrl({
                url:"pages/message"
              })
            })
          }.margin({
            top:32
          })
          Image($r("app.media.head")).width(70).margin({
            top:50
          })
          Text("abcdeff").margin({
            top:10
          }).fontWeight(600)
          Image($r("app.media.vip")).width(80).margin({
            top:8
          })
        }.margin({
          bottom:50
        })
        Row() {

          Grid(){
            GridItem(){
              Column(){
                Row(){
                  Text("酷币").fontWeight(600).fontSize(15).margin({
                    top:10,
                  }).padding(10)
                  Column(){
                    Image($r("app.media.next")).width(13).margin({
                      top:10,
                      left:82
                      // left:115
                    })
                  }
                }
                Row(){
                  Image($r("app.media.coin")).width(20).margin({
                    top:10
                  })
                  Text("5,915").fontWeight(700).margin({
                    top:10,left:9
                  })
                }

              }
            }
          }
          .width(150)
          .height(110)
          .backgroundColor(Color.White)
          .margin({
            right:18,
            left:16
            // left:6
          })
          .padding({
            right:100
          }).borderRadius(10)
          Grid(){
            GridItem(){
              Column(){
                Row(){
                  Text("装备").fontWeight(600).fontSize(15).margin({
                    top:10,
                    left:2
                  }).padding(10)
                  Image($r("app.media.next")).width(13).margin({
                    top:10,
                    left:115
                    // left:105
                  })
                }
                Scroll() {
                  Row() {
                    // Scroll() {
                    Image($r("app.media.word1")).width(25).margin({
                      top: 10,
                      left: 11
                    })
                    Image($r("app.media.word2")).width(27).margin({
                      top: 10,
                      left: 11
                    })
                    Image($r("app.media.word3")).width(25).margin({
                      top: 10,
                      left: 11
                    })
                    Image($r("app.media.word4")).width(25).margin({
                      top: 10,
                      left: 11
                    })
                    Image($r("app.media.word5")).width(27).margin({
                      top: 10,
                      left: 11
                    })
                    Image($r("app.media.word6")).width(25).margin({
                      top: 10,
                      left: 11
                    })
                    Image($r("app.media.word7")).width(25).margin({
                      top: 10,
                      left: 11
                    })
                    // }.scrollable(ScrollDirection.Horizontal)
                  }
                }.scrollable(ScrollDirection.Horizontal).width("100%")
              }

            }
          }
          .width(208)
          // .width(228)
          .height(110)
          .backgroundColor(Color.White)
          .padding({
            right:100
          }).borderRadius(10)
        }
        .width('100%')
        Grid(){
          GridItem(){
            Column(){
              Row(){
                Image($r("app.media.setting1")).width(25).margin({
                  top:30,right:55
                })
                Text("外观&沉浸场景").fontWeight(600).margin({
                  top:30
                })
                Image($r("app.media.next")).width(13).margin({
                  top:30,
                  left:130
                })
              }
              Row(){
                Image($r("app.media.setting2")).width(20).margin({
                  top:30,right:60
                })
                Text("学习设置").fontWeight(600).margin({
                  top:30
                })
                Image($r("app.media.next")).width(13).margin({
                  top:30,
                  left:170
                }).onClick(() => {
                  router.pushUrl({
                    url:"pages/studySetting"
                  })

                })

              }
              Row(){
                Image($r("app.media.setting3")).width(20).margin({
                  top:30,right:60
                })
                Text("更多设置").fontWeight(600).margin({
                  top:30
                })
                Image($r("app.media.next")).width(13).margin({
                  top:30,
                  left:170
                }).onClick(() => {
                  router.pushUrl({
                    url:"pages/MoreSetting"
                  })

                })

              }
            }
          }
        }
        // .width(375)
        .width(375)
        .height(180)
        .backgroundColor(Color.White)
        .margin({
          top:18,
          left:3,
          right:6
        }).borderRadius(10)
      }.backgroundColor("#f1f4f1")
      .height('100%')
    }

  }
}