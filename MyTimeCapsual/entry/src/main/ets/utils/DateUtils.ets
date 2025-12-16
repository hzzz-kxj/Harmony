import { TimeCapsule, CapsuleStatus } from '../model/DataModel';

/**
 * 日期工具类
 */
export class DateUtils {
  /**
   * 格式化时间
   */
  static formatDateTime(timestamp: number): string {
    const date = new Date(timestamp);
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');
    const hours = String(date.getHours()).padStart(2, '0');
    const minutes = String(date.getMinutes()).padStart(2, '0');
    return `${year}-${month}-${day} ${hours}:${minutes}`;
  }

  /**
   * 格式化日期
   */
  static formatDate(timestamp: number): string {
    const date = new Date(timestamp);
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');
    return `${year}-${month}-${day}`;
  }

  /**
   * 计算剩余时间
   */
  static getRemainingTime(capsule: TimeCapsule): string {
    const now = Date.now();
    
    if (capsule.status === CapsuleStatus.OPENED) {
      return '已开启';
    }
    
    if (capsule.openTime === 0) {
      return '未设置';
    }
    
    if (capsule.openTime <= now) {
      return '可开启';
    }
    
    const diff = capsule.openTime - now;
    const days = Math.floor(diff / (1000 * 60 * 60 * 24));
    const hours = Math.floor((diff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
    const minutes = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));
    
    if (days > 0) {
      return `还有 ${days} 天`;
    } else if (hours > 0) {
      return `还有 ${hours} 小时`;
    } else if (minutes > 0) {
      return `还有 ${minutes} 分钟`;
    } else {
      return '可开启';
    }
  }

  /**
   * 获取时间差描述
   */
  static getTimeDiffDescription(timestamp: number): string {
    const now = Date.now();
    const diff = now - timestamp;
    
    if (diff < 60000) {
      return '刚刚';
    } else if (diff < 3600000) {
      const minutes = Math.floor(diff / 60000);
      return `${minutes}分钟前`;
    } else if (diff < 86400000) {
      const hours = Math.floor(diff / 3600000);
      return `${hours}小时前`;
    } else if (diff < 604800000) {
      const days = Math.floor(diff / 86400000);
      return `${days}天前`;
    } else {
      return DateUtils.formatDate(timestamp);
    }
  }
}

