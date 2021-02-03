import { requireNativeComponent, ViewStyle } from 'react-native';

type GifProps = {
  color: string;
  style: ViewStyle;
};


export const GifViewManager = requireNativeComponent<GifProps>(
  'GifView'
);

export default GifViewManager;
