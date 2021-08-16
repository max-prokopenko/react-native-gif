import * as React from 'react';

import { Dimensions, StyleSheet, TouchableOpacity, View } from 'react-native';
import GifImage from '@lowkey/react-native-gif';

export default function App() {
  const [isPaused, setIsPaused] = React.useState(false);

  const togglePaused = React.useCallback(() => {
    setIsPaused(!isPaused);
  }, [isPaused]);
  return (
    <View style={styles.container}>
      <TouchableOpacity onPress={togglePaused}>
        {/* Remote GIF */}
        <GifImage
          source={{
            uri:
              'https://media1.tenor.com/images/9b38bcdea412e68fb780d88bdaa5a5c2/tenor.gif?itemid=10670068',
          }}
          style={styles.box}
          resizeMode={'cover'}
          paused={isPaused}
          onLoadEnd={() => console.log('onLoadEnd')}
        />
        {/* Local GIF */}
        <GifImage
          source={require('./smile.gif')}
          style={styles.box}
          resizeMode={'cover'}
          paused={isPaused}
        />
      </TouchableOpacity>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    justifyContent: 'center',
    alignItems: 'center',
    flex: 1,
  },
  box: {
    width: Dimensions.get('window').width * 0.8,
    height: Dimensions.get('window').width * 0.9,
    marginVertical: 20,
    backgroundColor: 'rgba(0,255,0,1)',
    margin: 15,
    borderRadius: 30,
    overflow: 'hidden',
  },
});
