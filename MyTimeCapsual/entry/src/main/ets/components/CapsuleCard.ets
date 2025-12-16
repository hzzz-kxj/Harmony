import { TimeCapsule, MoodType } from '../model/DataModel';
import { DateUtils } from '../utils/DateUtils';

/**
 * 胶囊卡片组件
 */
@Component
export struct CapsuleCard {
  capsule: TimeCapsule = new TimeCapsule();
  onTap?: () => void;

  build() {
    Column() {
      // 标题区域
      Row() {
        Text(this.capsule.title || '无标题')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
        Blank()
        Column() {
          this.getMoodIcon(this.capsule.mood)
        }
        .width(24)
        .height(24)
      }
      .width('100%')
      .padding(12)

      // 内容预览
      Row() {
        Text(this.getContentPreview())
          .fontSize(14)
          .fontColor('#666666')
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .textAlign(TextAlign.Start)
      }
      .width('100%')
      .padding({ left: 12, right: 12, bottom: 8 })

      // 底部信息
      Row() {
        Text(DateUtils.formatDateTime(this.capsule.createTime))
          .fontSize(12)
          .fontColor('#999999')
        Blank()
        Text(DateUtils.getRemainingTime(this.capsule))
          .fontSize(12)
          .fontColor('#4A90E2')
      }
      .width('100%')
      .padding({ left: 12, right: 12, bottom: 12 })
    }
    .width('100%')
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .padding(0)
    .margin({ bottom: 12 })
    .shadow({
      radius: 8,
      color: '#20000000',
      offsetX: 0,
      offsetY: 2
    })
    .onClick(() => {
      if (this.onTap) {
        this.onTap();
      }
    })
  }

  // 获取心情图标
  @Builder
  getMoodIcon(mood: MoodType) {
    if (mood === MoodType.HAPPY) {
      Text('😊')
    } else if (mood === MoodType.SAD) {
      Text('😢')
    } else if (mood === MoodType.PEACEFUL) {
      Text('😌')
    } else if (mood === MoodType.EXCITED) {
      Text('🤩')
    } else if (mood === MoodType.NOSTALGIC) {
      Text('🥺')
    } else if (mood === MoodType.LOVE) {
      Text('❤️')
    } else {
      Text('😊')
    }
  }

  getContentPreview(): string {
    if (this.capsule.content && this.capsule.content.trim().length > 0) {
      return this.capsule.content;
    }
    if (this.capsule.mediaList && this.capsule.mediaList.length > 0) {
      return `包含 ${this.capsule.mediaList.length} 个多媒体附件`;
    }
    return '点击查看详情';
  }
}