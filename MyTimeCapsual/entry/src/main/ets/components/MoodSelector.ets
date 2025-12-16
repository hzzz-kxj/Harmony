import { MoodType } from '../model/DataModel';

/**
 * 心情选择器组件
 */
@Component
export struct MoodSelector {
  @State selectedMood: MoodType = MoodType.HAPPY;
  onMoodChange?: (mood: MoodType) => void;

  build() {
    Row() {
      this.createMoodButton(MoodType.HAPPY, '😊')
      this.createMoodButton(MoodType.SAD, '😢')
      this.createMoodButton(MoodType.PEACEFUL, '😌')
      this.createMoodButton(MoodType.EXCITED, '🤩')
      this.createMoodButton(MoodType.NOSTALGIC, '🥺')
      this.createMoodButton(MoodType.LOVE, '❤️')
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceAround)
    .padding(12)
  }

  @Builder
  createMoodButton(mood: MoodType, emoji: string) {
    Button(emoji)
      .type(this.selectedMood === mood ? ButtonType.Normal : ButtonType.Normal)
      .backgroundColor(this.selectedMood === mood ? '#4A90E2' : '#F5F5F5')
      .fontSize(20)
      .width(48)
      .height(48)
      .borderRadius(24)
      .onClick(() => {
        this.selectedMood = mood;
        if (this.onMoodChange) {
          this.onMoodChange(mood);
        }
      })
  }
}

