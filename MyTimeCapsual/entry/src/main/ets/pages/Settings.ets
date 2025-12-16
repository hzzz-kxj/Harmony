import { router } from '@kit.ArkUI';

/**
 * 设置页面
 */
@Entry
@Component
struct Settings {
  @State darkMode: boolean = false;
  @State notifications: boolean = true;

  build() {
    Column() {
      // 标题栏
      Row() {
        Button('←')
          .fontSize(20)
          .fontColor('#FFFFFF')
          .backgroundColor(Color.Transparent)
          .onClick(() => {
            router.back();
          })
        Blank()
        Text('设置')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
        Blank()
        Text('  ')
          .fontSize(20)
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#4A90E2')

      Scroll() {
        Column() {
          // 通知设置
          Row() {
            Text('🔔 开启通知')
              .fontSize(16)
              .fontColor('#333333')
            Blank()
            Toggle({ type: ToggleType.Switch, isOn: this.notifications })
              .onChange((isOn: boolean) => {
                this.notifications = isOn;
              })
          }
          .width('100%')
          .height(56)
          .padding({ left: 16, right: 16 })
          .backgroundColor('#FFFFFF')

          Divider()
            .color('#F0F0F0')

          // 暗色模式
          Row() {
            Text('🌙 深色模式')
              .fontSize(16)
              .fontColor('#333333')
            Blank()
            Toggle({ type: ToggleType.Switch, isOn: this.darkMode })
              .onChange((isOn: boolean) => {
                this.darkMode = isOn;
              })
          }
          .width('100%')
          .height(56)
          .padding({ left: 16, right: 16 })
          .backgroundColor('#FFFFFF')

          Divider()
            .color('#F0F0F0')

          // 其他设置
          this.settingItem('📱 版本信息', 'v1.0.0', () => {})
          this.settingItem('🗑️ 清除缓存', '', () => {})
          this.settingItem('📧 联系我们', 'support@example.com', () => {})
        }
        .width('100%')
        .margin({ top: 8 })
      }
      .layoutWeight(1)
      .backgroundColor('#F5F5F5')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }

  @Builder
  settingItem(title: string, subtitle: string, onClick: () => void) {
    Column() {
      Row() {
        Text(title)
          .fontSize(16)
          .fontColor('#333333')
        Blank()
        if (subtitle) {
          Text(subtitle)
            .fontSize(14)
            .fontColor('#999999')
            .margin({ right: 4 })
        }
        Text('>')
          .fontSize(16)
          .fontColor('#CCCCCC')
      }
      .width('100%')
      .onClick(onClick)
    }
    .width('100%')
    .height(56)
    .padding({ left: 16, right: 16 })
    .backgroundColor('#FFFFFF')
  }
}

