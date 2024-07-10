import { WindowFrame } from 'ets/Common/WindowFrame';
import { HeaderFrame } from 'ets/Common/HeaderFrame';
import { HeaderIcon } from 'ets/Common/HeaderIcon';
import { getTheme } from 'ets/Common/Theme';
function styleSolidCard() {
    
  
        .backgroundColor(getTheme().colorScheme.surface)
        .borderRadius('10vp');
}
function styleHeader() {
    
  
        .fontColor(getTheme().colorScheme.onSurface)
        .fontSize('20fp')
        .fontWeight(FontWeight.Medium);
}
struct StudyProgressCard extends   {
    constructor() { }
    build() {
            .styleSolidCard()
            .width('100%')
            .padding('20vp');
    }
}
struct DataPreviewCard extends   {
    constructor() { }
    reviewItem(icon, color, title, value, unit) {
            .alignItems(VerticalAlign.Top)
            .width('100%');
    }
    build() {
        //概览
            .width('100%')
            .styleSolidCard()
            .padding('20vp');
    }
}
struct CalendarCard extends  {
    constructor() { }
    build() {
            .width('100%')
            .styleSolidCard()
            .padding('20vp');
    }
}
struct Signage extends   {
    constructor() { }
    headerLeftSlot() {
        HeaderIcon({ src: $r('app.media.icon_keyboard_arrow_down') });
    }
    headerRightSlot() {
        HeaderIcon({ src: $r('app.media.icon_ios_share') });
    }
    header() {
        HeaderFrame({
            title: '仪表盘',
            leftSlot: this.headerLeftSlot,
            rightSlot: this.headerRightSlot
        });
    }
    content() {
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .padding({ left: '20vp', right: '20vp' });
    }
    build() {
        ;
    }
}
//# sourceMappingURL=Signage.js.map