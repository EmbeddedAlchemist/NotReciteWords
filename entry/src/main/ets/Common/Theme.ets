namespace theme {

  declare type ThemeItem = Resource | string | Color;

  /**
   * 命名规则:
   * Surface, Primary, Secondary... 表示颜色作用的元素层级
   *   例如surface表示大块的不强调的背景，primary表示第一强调的元素
   * onXXX 表示在XXX的元素上的文字等图形的颜色
   * XXXContainer 表示同等级的容器颜色
   * Low表示弱化，High表示强调
   */
  // TODO: 按需添加条目
  export interface ThemeColor {
    surface: ThemeItem;
    onSurface: ThemeItem;
    onSurfaceLow: ThemeItem;
    surfaceContainer: ThemeItem;
    onSurfaceContainer: ThemeItem;
    primary: ThemeItem;
    onPrimary: ThemeItem;
    primaryContainer: ThemeItem;
    onPrimaryContainer: ThemeItem;
  }

  // 主题用到的资源在这里添加
  export  interface ThemeResource {

  }

  export interface Theme {
    color: ThemeColor;
    resource: ThemeResource
  }

  class ThemeLight implements Theme{
    color: {
      surface:'#FFFFFF'
      onSurface: '#202020'
      onSurfaceLow: '#777777'
      surfaceContainer: '#F4F4F4'
      onSurfaceContainer: '#202020'
      primary: '#FF6400'
      onPrimary: '#FFFFFF'
      primaryContainer:'#F8E2D5'
      onPrimaryContainer: '#FF6400'
    }
    resource:{

    }
  }

  class ThemeDark implements  Theme{
    color: {
      surface:'#202020'
      onSurface: '#F4F4F4'
      onSurfaceLow: '#999999'
      surfaceContainer: '#000000'
      onSurfaceContainer: '#F4F4F4'
      primary: '#FF6400'
      onPrimary: '#FFFFFF'
      primaryContainer:'#F8E2D5'
      onPrimaryContainer: '#FF6400'
    }
    resource:{

    }
  }

  export enum ThemeType { Light, Dark };

  let currentTheme:Theme = new ThemeLight();

  export function setTheme(themeType:ThemeType): void{
    switch (themeType){
      case ThemeType.Light: currentTheme = new ThemeLight(); break;
      case ThemeType.Dark: currentTheme = new ThemeDark(); break;
    }
  }

  export function getTheme() : Theme { return currentTheme; }

}