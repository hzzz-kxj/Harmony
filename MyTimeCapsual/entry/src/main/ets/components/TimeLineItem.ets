import { TimeCapsule, MoodType } from '../model/DataModel';
import { DateUtils } from '../utils/DateUtils';

/**
 * 时间线项组件
 */
@Component
export struct TimeLineItem {
  capsule: TimeCapsule = new TimeCapsule();
  onTap?: () => void;

  build() {
    Row() {
      // 左侧时间轴
      Column() {
        Circle({ width: 12, height: 12 })
          .fill('#4A90E2')
        if (this.capsule.id !== this.capsule.id) {
          Line()
            .width(1)
            .height('100%')
            .backgroundColor('#E0E0E0')
            .margin({ top: 4 })
        }
      }
      .width(20)
      .margin({ right: 12 })

      // 右侧内容
      Column() {
        Row() {
          Text(DateUtils.formatDateTime(this.capsule.createTime))
            .fontSize(12)
            .fontColor('#999999')
          Blank()
          this.getMoodIcon(this.capsule.mood)
        }
        .width('100%')
        .margin({ bottom: 4 })

        Text(this.capsule.title || '无标题')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .margin({ bottom: 4 })

        Text(this.getContentPreview())
          .fontSize(14)
          .fontColor('#666666')
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        if (this.capsule.openTime > 0) {
          Text(`将在 ${DateUtils.formatDate(this.capsule.openTime)} 开启`)
            .fontSize(12)
            .fontColor('#4A90E2')
            .margin({ top: 8 })
        }
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding({ top: 12, bottom: 12 })
    .onClick(() => {
      if (this.onTap) {
        this.onTap();
      }
    })
  }

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
      return `包含 ${this.capsule.mediaList.length} 个附件`;
    }
    return '点击查看详情';
  }
}

