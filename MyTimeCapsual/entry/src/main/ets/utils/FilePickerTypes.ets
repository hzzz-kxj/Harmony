/**
 * FilePicker 类型定义
 */

export interface PhotoViewPicker {
  select(options: PhotoSelectOptions): Promise<PhotoSelectResult>;
}

export interface VideoViewPicker {
  select(options: VideoSelectOptions): Promise<VideoSelectResult>;
}

export interface AudioViewPicker {
  select(options: AudioSelectOptions): Promise<AudioSelectResult>;
}

export class PhotoSelectOptions {
  MIMEType?: string;
  maxSelectNumber?: number;
}

export class VideoSelectOptions {
  maxSelectNumber?: number;
}

export class AudioSelectOptions {
  maxSelectNumber?: number;
}

export enum PhotoViewMIMETypes {
  IMAGE_TYPE = 'image/*'
}

export interface PhotoSelectResult {
  photoUris?: string[];
  photoNames?: string[];
  uris?: string[];
  names?: string[];
}

export interface VideoSelectResult {
  videoUris?: string[];
  videoNames?: string[];
  uris?: string[];
  names?: string[];
}

export interface AudioSelectResult {
  audioUris?: string[];
  audioNames?: string[];
  uris?: string[];
  names?: string[];
}

export interface PhotoViewMIMETypesObject {
  IMAGE_TYPE: string;
}

// FilePickerModule 接口 - 简化定义，使用对象类型
export interface FilePickerModule {
  PhotoViewPicker: object;
  VideoViewPicker: object;
  AudioViewPicker: object;
  PhotoSelectOptions: object;
  VideoSelectOptions: object;
  AudioSelectOptions: object;
  PhotoViewMIMETypes: PhotoViewMIMETypesObject;
}

