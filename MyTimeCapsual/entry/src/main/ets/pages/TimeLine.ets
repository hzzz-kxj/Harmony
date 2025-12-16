import { TimeCapsule, CapsuleStatus } from '../model/DataModel';
import { StorageManager } from '../model/StorageManager';
import { TimeLineItem } from '../components/TimeLineItem';
import { BottomNavBar } from '../components/BottomNavBar';
import { router } from '@kit.ArkUI';

/**
 * 时间线页面
 */
@Entry
@Component
struct TimeLine {
  @State capsules: TimeCapsule[] = [];
  @State loading: boolean = true;
  private storageManager = StorageManager.getInstance();

  async aboutToAppear() {
    await this.loadCapsules();
  }

  onPageShow() {
    this.loadCapsules();
  }

  async loadCapsules() {
    this.loading = true;
    this.capsules = await this.storageManager.getAllCapsules();
    // 按创建时间倒序排列
    this.capsules.sort((a, b) => b.createTime - a.createTime);
    this.loading = false;
  }

  build() {
    Column() {
      // 标题栏
      Row() {
        Text('时间线')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFF')
        Blank()
        Button({ type: ButtonType.Circle }) {
          Text('+')
            .fontSize(24)
            .fontColor('#4A90E2')
        }
        .width(40)
        .height(40)
        .backgroundColor('#FFF')
        .padding(0)
        .margin({ right: -4 })
        .onClick(() => {
          router.pushUrl({
            url: 'pages/CreateCapsule'
          });
        })
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 20 })
      .backgroundColor('#4A90E2')

      // 内容区域
      if (this.loading) {
        Column() {
          LoadingProgress()
            .width(60)
            .height(60)
            .color('#4A90E2')
          Text('加载中...')
            .margin({ top: 12 })
            .fontSize(14)
            .fontColor('#999999')
        }
        .width('100%')
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
      } else if (this.capsules.length === 0) {
        Column() {
          Text('⏰')
            .fontSize(80)
            .opacity(0.3)
          Text('还没有时间记录')
            .fontSize(16)
            .fontColor('#999999')
            .margin({ top: 16 })
        }
        .width('100%')
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
      } else {
        Scroll() {
          Column() {
            ForEach(this.capsules, (capsule: TimeCapsule, index: number) => {
              TimeLineItem({
                capsule: capsule,
                onTap: () => {
                  router.pushUrl({
                    url: 'pages/CapsuleDetail',
                    params: {
                      capsuleId: capsule.id
                    }
                  });
                }
              })
            })
          }
          .width('100%')
          .padding({ left: 16, right: 16, top: 16, bottom: 16 })
        }
        .layoutWeight(1)
      }

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
    .backgroundColor('#FFF')
  }
}

