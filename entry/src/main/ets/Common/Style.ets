import { getTheme } from 'ets/Common/Theme'

@Styles  function styleSolidCard(){
  .backgroundColor(getTheme().colorScheme.surface)
  .borderRadius('10vp')
}

@Extend(Text)  function styleHeader(){
  .fontColor(getTheme().colorScheme.onSurface)
  .fontSize('20fp')
  .fontWeight(FontWeight.Bold)
}
