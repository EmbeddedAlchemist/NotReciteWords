import { getTheme } from './Theme'

@Component
export  struct HeaderIcon {
  src: string | PixelMap | Resource

  build() {
    Row() {
      Image(this.src)
        .size({ width: '24vp', height: '24vp' })
        .fillColor(getTheme().colorScheme.onSurfaceContainer)

    }
  }
}