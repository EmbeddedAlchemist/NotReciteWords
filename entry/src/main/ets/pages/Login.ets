import router from '@ohos.router'
import prompt from '@system.prompt';


@Styles function myInputStyle() {
  .width("90%")
  .height(50)
  .margin({
    top: 30
  })
}

@Styles function  myTextStyle(){
  .width("30%")
  .height(60)
}


@Entry
@Component
struct Login{
  @State username : string =  ""
  @State password : string =  ""
  @State isSelected : boolean = false
  @State isCorrect : boolean = false
  @State parmas_is_Enroll : Object = router.getParams()
  @State parmas_is_MainPage : Object = router.getParams()


  build() {
    Column(){

      Text("不背单词")
        .fontSize(40)
        .margin({
          top : 80
        })

      Column() {
        TextInput(
          { placeholder: "请输入账号" })
          .type(InputType.Normal)
          .myInputStyle()
          .onChange((username: string) => {
            if (this.parmas_is_MainPage?.['Rusername'] == undefined) {
              this.username = username
            }else {
              this.username = this.parmas_is_MainPage?.['Rusername']
              prompt.showDialog({message : this.username})
            }
          })

        TextInput({ placeholder: "请输入密码" })
          .type(InputType.Password)
          .myInputStyle()
          .onChange((password: string) => {
            if (this.parmas_is_MainPage?.['Rpassword'] == undefined) {
              this.password = password
            }else {
              this.password = this.parmas_is_MainPage?.['Rpassword']
              prompt.showDialog({message : this.password})
            }

          })
      }.margin({
        top : 20
      })

    Column() {
      Row() {
        Checkbox()
          .onChange((isSelect: boolean) => {
            this.isSelected = isSelect
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
      }
      .padding({
        top: 20
      })

      Row() {
          Checkbox()
            .onChange((isCorrect: boolean) => {
              if (this.parmas_is_MainPage?.['IsCorrecT'] == undefined) {
                this.isCorrect = isCorrect
              }else {
                this.isCorrect = this.parmas_is_MainPage?.['IsCorrecT']
              }
            })

            .onClick(() => {
              if (this.isCorrect && (this.username == "" || this.password == "")) {
                prompt.showToast({message : "账号或密码未输入"})
                return;
              }

              if (this.isCorrect && this.username != "" && this.password != ""){
                prompt.showToast({message : "已记住账号和密码"})
                return;
              }
            })

        Text("记住")
          .fontSize(20)
          .fontWeight(600)

        Text("账号")
          .fontSize(18)
          .fontWeight(400)

        Text("和")
          .fontSize(18)
          .fontWeight(400)

        Text("密码")
          .fontSize(18)
          .fontWeight(400)

      }.width("95%")
      .margin({
        top : 15
      })


    }

      Row({space : 40}){
        Button("登录")
          .fontSize(35)
          .myTextStyle()
          .onClick(() => {
            if (!this.isSelected) {
              prompt.showToast({ message: "请勾选《用户协议》和《隐私政策》" })
              return;
            }//未勾选隐私

            if (this.isSelected && this.isCorrect == false && this.parmas_is_Enroll?.['Success'] == true && this.parmas_is_Enroll?.['Newname'] == this.username && this.parmas_is_Enroll?.['Newpassword'] == this.password) {
              router.pushUrl({
                url: "pages/Progress_Page",
                params : {
                    iscorrect : this.isCorrect,
                    username : this.username,
                    password : this.password
                }
              })
            }//全部格式都正确，不记住密码

            if (this.isSelected && this.parmas_is_Enroll?.['Success'] == true && (this.username == "" || this.password == "")) {
              prompt.showToast({message : "请输入账号和密码"})
              return;
            }//勾选了隐私，注册了账号，但没输入账号或密码的

            if (this.parmas_is_Enroll?.['Success'] == false) {
              prompt.showToast({message : "请注册账号"})
              return;
            }//账号没注册的

            if (this.parmas_is_Enroll?.['Success'] == true && (this.parmas_is_Enroll?.['Newname'] != this.username || this.parmas_is_Enroll?.['Newpassword'] != this.password)) {
              console.info(this.username)
              console.info(this.password)
              prompt.showToast({message : "账号或密码错误"})
              return;
            }//注册账号后却输错账号密码的

            if (this.isCorrect && this.isSelected && this.parmas_is_Enroll?.['Success'] == true && this.parmas_is_Enroll?.['Newname'] == this.username && this.parmas_is_Enroll?.['Newpassword'] == this.password) {
              router.pushUrl({
                url: "pages/Progress_Page",
                params : {
                  iscorrect : this.isCorrect,
                  username : this.username,
                  password : this.password
                }
              })
            }//全部格式都正确，记住密码
          })
          .backgroundColor('100000000')
          .fontColor(Color.Green)




        Button("注册")
          .fontSize(35)
          .myTextStyle()
          .onClick(() => {
            router.pushUrl({
              url : "pages/Enroll_Page"
            })
          })
          .fontColor(Color.Green)
          .backgroundColor('100000000')
      }.margin({
        top : 35
      })


    }.width("100%")
    .height("100%")
    .backgroundImage($r("app.media.LgionbackImage"))
    .backgroundImageSize({
        width : "100%",
        height : "100%"
      })

  }
}

