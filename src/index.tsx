import React from 'react';
import {
  Image,
  ImageResizeMode,
  Platform,
  requireNativeComponent,
} from 'react-native';

type GifProps = {
  source: string;
  style: any;
  resizeMode: ImageResizeMode;
};

export const GifViewManager = requireNativeComponent<GifProps>('GifImage');

const GifImage = (props: {
  source: { uri: string };
  style: any;
  resizeMode: ImageResizeMode;
}) => {
  const { style, source, resizeMode } = props;
  return Platform.OS === 'ios' ? (
    <GifViewManager style={style} source={source.uri} resizeMode={resizeMode} />
  ) : (
    <Image {...props} />
  );
};

export default GifImage;
