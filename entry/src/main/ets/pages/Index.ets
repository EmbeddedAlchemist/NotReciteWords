import router from '@ohos.router'

import { YouDaoDict } from '../APIs/YouDaoDict'

YouDaoDict.query("example")
  .then((result: YouDaoDict.QueryResult) => {
    console.log('result', result);
  })

@Entry
@Component
struct Index {
  @State message: string = 'Hello World'

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
        Button("Jump To Signage")
          .onClick(() => {
            router.pushUrl({ url: 'pages/Signage' })
          })

        Button("Test YouDao")
          .onClick(e => {
            YouDaoDict.query('test')
              .then(result => {
                console.log('result', result);
              })
              .catch(e => {
                console.log(e);
              })
          })
      }
      .width('100%')
    }
    .height('100%')

  }
}