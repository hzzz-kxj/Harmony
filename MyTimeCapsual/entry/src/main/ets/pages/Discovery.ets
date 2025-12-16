import { router } from '@kit.ArkUI';
import { BottomNavBar } from '../components/BottomNavBar';

/**
 * 发现页面
 */
@Entry
@Component
struct Discovery {
  build() {
    Column() {
      Row() {
        Text('发现')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFF')
        Blank()
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#4A90E2')

      Column() {
        Text('🔍')
          .fontSize(80)
          .opacity(0.3)
        Text('探索更多功能')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .margin({ top: 20 })
        Text('未来这里会展示公开的时空胶囊')
          .fontSize(14)
          .fontColor('#999999')
          .margin({ top: 8 })
      }
      .width('100%')
      .layoutWeight(1)
      .justifyContent(FlexAlign.Center)

      // 底部导航栏
      BottomNavBar({
        currentIndex: 1,
        onTabChange: (index: number, url: string) => {
          if (index !== 1) {
            router.pushUrl({ url: url });
          }
        }
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}

