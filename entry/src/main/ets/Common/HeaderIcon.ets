import { getTheme } from './Theme'

@Component
export  struct HeaderIcon {
  src: string | PixelMap | Resource

  build() {
    Row() {
      Image(this.src)
        .size({ width: '20vp', height: '20vp' })
        .fillColor(getTheme().colorScheme.onSurfaceContainer)

    }
  }
}