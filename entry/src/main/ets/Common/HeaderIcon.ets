import { getTheme } from './Theme'

@Component
export struct HeaderIcon {
  src: string | PixelMap | Resource

  build() {
    Button({type:ButtonType.Circle}) {
      Image(this.src)
        .fillColor(getTheme().colorScheme.onSurfaceContainer)
        .size({width:'100%', height:'100%'})
    }
    .size({ width: '36vp', height: '36vp' })
    .padding('8vp')
    .alignSelf(ItemAlign.Center)
    .backgroundColor(Color.Transparent)
  }
}