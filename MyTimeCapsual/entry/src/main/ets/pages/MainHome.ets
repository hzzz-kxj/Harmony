import { TimeCapsule, CapsuleStatus } from '../model/DataModel';
import { StorageManager } from '../model/StorageManager';
import { DateUtils } from '../utils/DateUtils';
import { CapsuleCard } from '../components/CapsuleCard';
import { BottomNavBar } from '../components/BottomNavBar';
import { router } from '@kit.ArkUI';

/**
 * 主页
 */
@Entry
@Component
struct MainHome {
  @State capsules: TimeCapsule[] = [];
  @State loading: boolean = true;
  private storageManager = StorageManager.getInstance();
  openedCount: number = 0;

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
    // 计算已开启的胶囊数量
    this.openedCount = this.capsules.filter(c => c.status === CapsuleStatus.OPENED).length;
    this.loading = false;
  }

  build() {
    Column() {
      // 标题栏
      Row() {
        Text('时空胶囊')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
        Blank()
        Button({ type: ButtonType.Circle }) {
          Text('+')
            .fontSize(24)
            .fontColor('#4A90E2')
        }
        .width(40)
        .height(40)
        .backgroundColor('#FFFFFF')
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
        .height('100%')
        .justifyContent(FlexAlign.Center)
      } else if (this.capsules.length === 0) {
        Column() {
          Image($r('app.media.startIcon'))
            .width(120)
            .height(120)
            .opacity(0.3)
          Text('还没有胶囊')
            .fontSize(16)
            .fontColor('#999999')
            .margin({ top: 16 })
          Text('点击右上角 + 创建你的第一个时空胶囊')
            .fontSize(14)
            .fontColor('#CCCCCC')
            .margin({ top: 8 })
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
      } else {
        Scroll() {
          Column() {
            ForEach(this.capsules, (capsule: TimeCapsule) => {
              CapsuleCard({
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
        .scrollBar(BarState.Auto)
      }

      // 底部统计
      if (!this.loading && this.capsules.length > 0) {
        Row() {
          Text(`共 ${this.capsules.length} 个胶囊`)
            .fontSize(12)
            .fontColor('#999999')
          Blank()
          Text(`已开启 ${this.openedCount} 个`)
            .fontSize(12)
            .fontColor('#4A90E2')
        }
        .width('100%')
        .height(40)
        .padding({ left: 16, right: 16 })
        .backgroundColor('#F5F5F5')
      }

      // 底部导航栏
      BottomNavBar({
        currentIndex: 0,
        onTabChange: (index: number, url: string) => {
          if (index !== 0) {
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

