import router from '@ohos.router';
import {MySwiper} from './component/MySwiper'
@Entry
@Component
struct MainPage {

  @State  parmas_is_Progress_Page : Object = router.getParams()

  build(){
    Column(){
      Row({space : 10}) {
        Button() {
          Image($r("app.media.return"))
            .height(25)
            .width(25)
        }
        .backgroundColor('100000000')
        .onClick(() => {
          if (this.parmas_is_Progress_Page?.['iscorrect'] == true) {
            router.pushUrl({
              url: "pages/Login",
              params: {
                IsCorrecT: this.parmas_is_Progress_Page?.['iscorrect'],
                Rusername: this.parmas_is_Progress_Page?.['Username'],
                Rpassword: this.parmas_is_Progress_Page?.['Password']
              }
            })
          }else {
            router.pushUrl({
              url: "pages/Login",
            })
          }
        })
        .margin({
          right : 5,
          top: 10
        })

        Text("返回登陆界面")
          .fontSize(20)
          .fontWeight(500)
          .margin({
            right : 150,
            top : 10
          })
      }

      Row({space : 10}) {
        Button() {
          Image($r("app.media.person"))
            .height(30)
            .width(30)
        }
        .onClick(() => {
          router.pushUrl({
            url: ""
          })
        })
        .margin({
          top: 20
        })

        Text("个人中心")
          .fontSize(30)
          .fontWeight(600)
          .margin({
            top : 20,
            right : 140
          })
      }

     MySwiper()

      Row(){
        Button() {
          Column() {
            Text("Learn")
              .fontSize(20)
              .fontWeight(600)

            Text("1452")
              .fontSize(15)
              .fontColor(Color.Orange)
          }
        }
        .width("40%")
        .height("8%")
        .backgroundColor('#F8F8F8')
        .margin({
          right : 20
        })
        .onClick(() => {
          router.pushUrl({
            url : "pages/learnSelectPage"
          })
        })


        Button(){
          Column(){
            Text("Review")
              .fontSize(20)
              .fontWeight(600)

            Text("1452")
              .fontSize(15)
              .fontColor(Color.Orange)
          }
        }
        .width("40%")
        .height("8%")
        .backgroundColor('#F8F8F8')
        .onClick(() => {
          router.pushUrl({
            url : "pages/learnSelectPage"
          })
        })

      }.height("70%")
      .alignItems(VerticalAlign.Bottom)


      Row({space : 90}) {
        Button() {
          Image($r("app.media.class"))
        }.onClick(() => {
          router.pushUrl({
            url : "pages/ReciteSchoolPage"
          })
        })
        .width("12%")
        .height("30%")
        .backgroundColor('100000000')//100000000
        .margin({
          bottom : 15
        })

        Button(){
          Image($r("app.media.bag"))
        }.onClick(() => {
          router.pushUrl({
            url : "pages/PersonPage"
          })
        })
        .width("12%")
        .height("30%")
        .backgroundColor('100000000')//100000000
        .margin({
          bottom : 15
        })

        Button(){
          Image($r("app.media.DataTable"))
        }.onClick(() => {
          router.pushUrl({
            url : "pages/Signage"
          })
        })
        .width("12%")
        .height("30%")
        .backgroundColor('100000000')//100000000
        .margin({
          bottom : 15
        })

      }.height("18%")
      .alignItems(VerticalAlign.Bottom)

    }
    .width("100%")
    .height("100%")
    .backgroundImage($r("app.media.mainbackgroundimage"))
    .backgroundImageSize({
      width : "100%",
      height : "100%"
    })
  }
}