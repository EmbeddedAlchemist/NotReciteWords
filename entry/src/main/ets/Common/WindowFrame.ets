import { getTheme } from './Theme';
import { emptyBuilder } from './emptyBuilder'
// @Component
// export struct WindowFrame {
//   @BuilderParam child: () => {};
//   //@BuilderParam headerSlot:  () => any = this.defaultHeaderSlot;
//
//
//   @Builder
//   defaultHeaderSlot(){
//   }
//
//   build(){
//    Flex({direction:FlexDirection.Column}){
//      Row(){
//        //this.headerSlot();
//      }
//      .width('100%')
//      Scroll(){
//        Column(){
//          this.child();
//        }
//        .width('100%')
//      }
//      .size({width:'100%', height:'100%'})
//    }
//    .size({width:'100%', height:'100%'})
//     .backgroundColor(Color.Pink)
//
//   }
// }


@Component
export struct WindowFrame {
  @BuilderParam
  header: () => any = emptyBuilder;
  @BuilderParam
  content: () => any = emptyBuilder;

  build() {
    Flex({ direction: FlexDirection.Column }) {
      Row() {
        this.header();
      }
      .width('100%')

      Column() {
        this.content();
      }
      .width('100%')
      .size({ width: '100%', height: '100%' })
      .align(Alignment.Top)
    }
    .width('100%')
    .backgroundColor(getTheme().colorScheme.surfaceContainer)
  }
}
