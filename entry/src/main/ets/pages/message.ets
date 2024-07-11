class Contact {
  name1: string;
  name2 : string;
  name3 : string;
  icon: Resource;

  constructor(name1: string, name2: string,name3:string,icon: Resource) {
    this.name1 = name1;
    this.name2 = name2;
    this.name3 = name3;
    this.icon = icon;
  }
}
import router from '@ohos.router'
@Entry
@Component
struct Test03 {
  private contactsGroups: object[] = [
    {
      title: '06月25日  10:14',
      contacts: [
        new Contact('参加春季特卖会','新春促销>>>','#特卖活动', $r('app.media.adv4')),
      ],
    },
    {
      title: '06月28日 13:37',
      contacts: [
        new Contact('重阳佳节福寿安康','民间习俗>>>','#节日活动', $r('app.media.movie_banner2'))
      ],
    },
    {
      title: '07月03日  21:12',
      contacts: [
        new Contact('🎇新品钜惠','全场7折>>>','#特卖活动', $r('app.media.adv2')),
      ],
    },
    {
      title: '07月05日  21:12',
      contacts: [
        new Contact('拼搏成就梦想💦','STRUGGLE~','#励志故事', $r('app.media.adv3')),
      ],
    },
  ]
  @Builder itemHead(text: string) {
    Row(){
      Text("                            ")
    }
    Text(text)
      .fontSize(12)
      .backgroundColor('#fff1f3f5')
      .width('100%')
      .padding(5)
      .fontColor('#AAAAAA')
      .margin({
        top:21,
        bottom:10
      })
  }

  build() {
    Column(){
      Row(){
        Image($r("app.media.return")).width(15).margin({
          right:130,
          top:45,
        }).onClick(() => {
          router.back()
        })
          Text("消息中心").fontSize(15).padding({
            top:45,
            right:130,
            bottom:4
            // right:10
          }).fontWeight(600)
      }

      Scroll(){
        Column() {
          List() {
            ForEach(this.contactsGroups, (item) => {
              ListItemGroup({ header: this.itemHead(item.title) }) {
                ForEach(item.contacts, contact => {
                  ListItem() {
                    Column() {
                      Image(contact.icon)
                        .width("100%")
                        .height(150)
                        .borderRadius({
                          topLeft:15,topRight:15
                        })

                        Text(contact.name1).fontSize(18).height(30).margin({
                          top:12,
                          // right:250,
                          bottom:5
                        }).fontColor(Color.Black).fontWeight(600).padding({
                          left:3,
                          right:176
                        })

                      Text(contact.name2).fontSize(16).height(20).margin({
                        // right:250,
                        // left:17,
                        // right:150,
                        bottom:19
                      }).fontColor("#908989").padding({
                        left:3,
                        right:229
                      })
                      Text(contact.name3).fontSize(11).height(20).margin({
                        // left:230,
                        // right:250,
                        left:200,
                        bottom:9
                      }).fontColor("#2F9AD3").fontWeight(600)
                    }.backgroundColor(Color.White).borderRadius(15)
                    .width('100%')
                    .justifyContent(FlexAlign.Start)


                    // .backgroundColor('#fff1f3f5')
                  }
                }, contact => contact.name)
              }
            },item => item.title)
          }.backgroundColor('#fff1f3f5')
          .margin({
            bottom:100
          })

          // .backgroundColor(Color.White)

          .width("90%")
        }.height('100%').width('100%')
      }

    }.backgroundColor('#fff1f3f5')

  }
}
