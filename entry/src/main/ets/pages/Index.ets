import router from '@ohos.router'
@Entry
@Component
struct Index {
  build() {
    Button("点击进入个人页面").onClick(() =>{
      router.pushUrl({
        url:"pages/MainPage"
      })
    })
  }
}