import { getTheme } from './Theme';
import  {emptyBuilder} from './emptyBuilder'
import { HeaderIcon } from './HeaderIcon';

@Component
@Preview
export struct HeaderFrame {
  @BuilderParam
  title: string;
  @BuilderParam
  leftSlot?: () => any = emptyBuilder;
  @BuilderParam
  rightSlot?: () => any = emptyBuilder;


  build() {
    Row() {
      RelativeContainer() {
        Row() {
          this.leftSlot();
        }
        .alignSelf(ItemAlign.Start)
        .id('left-slot')
        .alignRules({
          center: {
            anchor: "__container__",
            align: VerticalAlign.Center
          },
          left: {
            anchor: "__container__",
            align: HorizontalAlign.Start
          }
        })

        Text(this.title)
          .textAlign(TextAlign.Center)
          .fontSize('16fp')
          .fontColor(getTheme().colorScheme.onSurfaceContainer)
          .fontWeight(FontWeight.Medium)
          .id('title')
          .alignRules({
            center: {
              anchor: '__container__',
              align: VerticalAlign.Center
            },
            middle: {
              anchor: '__container__',
              align: HorizontalAlign.Center
            }
          })

        Row() {
          this.rightSlot()
        }
        .alignSelf(ItemAlign.End)
        .id('right-slot')
        .alignRules({
          center: {
            anchor: "__container__",
            align: VerticalAlign.Center
          },
          right: {
            anchor: "__container__",
            align: HorizontalAlign.End
          }
        })
        .id("row2")
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('80vp')
    .padding('20vp')
  }
}