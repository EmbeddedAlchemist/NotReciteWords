import router from '@ohos.router'
import { HeaderFrame } from '../Common/HeaderFrame'
import { HeaderIcon } from '../Common/HeaderIcon'
import { WindowFrame } from '../Common/WindowFrame'



@Entry
@Component
struct WordList {
  @State message: string = 'Hello World'

  @BuilderParam title:string = '词汇表'

  @Builder
  headerLeftSlot() {
    HeaderIcon({ src: $r('app.media.icon_arrow_back') })
      .onClick(event => {
        router.back()
      })
  }

  @Builder
  headerRightSlot() {
  }

  @Builder
  header() {
    HeaderFrame({
      title: this.title,
      leftSlot: this.headerLeftSlot,
      rightSlot: this.headerRightSlot
    })
  }

  @Builder
  content() {
    Column() {

    }
  }

  build() {
    Column() {
      WindowFrame({
        content: this.content.bind(this),
        header: this.header.bind(this)
      })

    }
  }
}