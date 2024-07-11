import router from '@ohos.router';
import prompt from '@system.prompt';

@Styles function myInputStyle() {
  .width("90%")
  .height(50)
  .margin({
    top: 30
  })
}

// @Styles function  myTextStyle(){
//   .width("30%")
//   .height(60)
// }

@Entry
@Component
export  struct Enroll_Page {

  @State Newpassword : string = ""
  @State Newname : string = ""
  @State Success : boolean = false


  build() {
    Column() {
      Text("注册")
        .fontSize(50)
        .fontWeight(600)

      Column({space : 5}) {
        TextInput({ placeholder: "请输入注册账号" })
          .type(InputType.Normal)
          .myInputStyle()
          .onChange((Newname: string) => {
            this.Newname = Newname
          })

        TextInput({ placeholder: "请输入注册密码" })
          .type(InputType.Password)
          .myInputStyle()
          .onChange((Newpassword: string) => {
            this.Newpassword = Newpassword
          })

        Column({space : 25}) {
          Row() {
            Checkbox()
              .onChange((Success: boolean) => {
                this.Success = Success
                console.info(`${this.Success}`)
              })

            Text("请勾选")
              .fontSize(18)
              .fontWeight(400)

            Text("《用户协议》")
              .fontSize(20)
              .fontWeight(600)

            Text("和")
              .fontSize(18)
              .fontWeight(400)

            Text("《隐私政策》")
              .fontSize(20)
              .fontWeight(600)
          }.padding({
            top: 20
          })

          Button("去登录")
            .onClick(() => {
              if (this.Success && this.Newname != "" && this.Newpassword != "") {
                console.info(this.Newname)
                console.info(this.Newpassword)


                router.pushUrl({
                  url: "pages/Login",
                  params: {
                    Success: this.Success,
                    Newname: this.Newname,
                    Newpassword: this.Newpassword
                  }
                })
              }
              if (!this.Success && this.Newname != "" && this.Newpassword != "") {

                prompt.showToast({ message: "请勾选《用户协议》和《隐私政策》" })
                // console.info(this.Newname)
                // console.info(this.Newpassword)
                return;
              }

              if (this.Success && (this.Newname == "" || this.Newpassword == "")) {
                prompt.showToast({ message: "请填写账号和密码" })
                // console.info(this.Newname)
                // console.info(this.Newpassword)
                return;
              }

              if (!this.Success && this.Newname == "" && this.Newpassword == "") {
                prompt.showToast({ message: "请勾选选项并且输入新账号名和密码" })
                return;
              }
            })
            .fontColor('#00CCA9')
            .fontSize(20)
            .backgroundColor('100000000')
        }.margin({
          top: 20
        })
      }
    }.width("100%")
    .height("100%")
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundImage($r("app.media.EnrollbackImage"))
    .backgroundImageSize({
      width : '100%',
      height : '100%'
    })
  }
}



