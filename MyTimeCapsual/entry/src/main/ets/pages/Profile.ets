import { router } from '@kit.ArkUI';
import { BottomNavBar } from '../components/BottomNavBar';

/**
 * 个人资料页面
 */
@Entry
@Component
struct Profile {
  build() {
    Column() {
      Row() {
        Text('我的')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFF')
        Blank()
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#4A90E2')

      Scroll() {
        Column() {
          // 头像区域
          Column() {
            Stack() {
              Circle({ width: 80, height: 80 })
                .fill('#4A90E2')
              Text('👤')
                .fontSize(48)
            }
            Text('时空胶囊用户')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#333333')
              .margin({ top: 12 })
          }
          .width('100%')
          .padding(24)
          .backgroundColor('#FFF')
          .justifyContent(FlexAlign.Center)

          Divider()
            .color('#F0F0F0')

          // 设置选项
          Column() {
            this.settingItem('📱 关于时空胶囊', () => {})
            this.settingItem('📊 数据统计', () => {})
            this.settingItem('⚙️ 设置', () => {
              router.pushUrl({
                url: 'pages/Settings'
              });
            })
            this.settingItem('💬 反馈建议', () => {})
          }
          .width('100%')
          .margin({ top: 8 })
        }
        .width('100%')
      }
      .layoutWeight(1)
      .backgroundColor('#F5F5F5')

      // 底部导航栏
      BottomNavBar({
        currentIndex: 2,
        onTabChange: (index: number, url: string) => {
          if (index !== 2) {
            router.pushUrl({ url: url });
          }
        }
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }

  @Builder
  settingItem(title: string, onClick: () => void) {
    Row() {
      Text(title)
        .fontSize(16)
        .fontColor('#333333')
      Blank()
      Text('>')
        .fontSize(16)
        .fontColor('#CCCCCC')
    }
    .width('100%')
    .height(56)
    .padding({ left: 16, right: 16 })
    .backgroundColor('#FFFFFF')
    .onClick(onClick)
  }
}

