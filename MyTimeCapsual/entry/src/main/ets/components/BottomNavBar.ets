/**
 * 底部导航栏组件
 */
@Component
export struct BottomNavBar {
  @State currentIndex: number = 0;
  onTabChange?: (index: number, url: string) => void;

  build() {
    Row() {
      this.navItem('首页', 'pages/MainHome', 0)
      this.navItem('时间线', 'pages/TimeLine', 1)
      this.navItem('我的', 'pages/Profile', 2)
    }
    .width('100%')
    .height(56)
    .padding({ left: 16, right: 16 })
    .backgroundColor('#FFFFFF')
    .shadow({
      radius: 8,
      color: '#10000000',
      offsetX: 0,
      offsetY: -2
    })
  }

  @Builder
  navItem(name: string, url: string, index: number) {
    Column() {
      if (index === 0) {
        Text('🏠')
      } else if (index === 1) {
        Text('⏰')
      } else if (index === 2) {
        Text('👤')
      }
      Text(name)
        .fontSize(12)
        .fontColor(this.currentIndex === index ? '#4A90E2' : '#999999')
    }
    .layoutWeight(1)
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      this.currentIndex = index;
      if (this.onTabChange) {
        this.onTabChange(index, url);
      }
    })
  }
}

