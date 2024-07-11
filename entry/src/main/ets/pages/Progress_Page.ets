import router from '@ohos.router';

@Entry
@Component
struct Progress_Page {

  @State  parmas_is_Login : Object = router.getParams()

  aboutToAppear(){
    setTimeout(() => {
      this.jump()
    },2000)
  }

  jump(){
    router.pushUrl({
      url : "pages/MainPage",
      params : {
        iscorrect : this.parmas_is_Login?.['isCorrect'],
        Username: this.parmas_is_Login?.['username'],
        Password: this.parmas_is_Login?.['password']
      }
    })
  }

  build() {
    Column() {
      Text("正在登录")
        .fontSize(40)
        .fontWeight(600)
      LoadingProgress()
        .width("50%")
        .color(Color.Green)

    }.width("100%")
    .height("100%")
    .margin({
      top : 40
    })

  }
}