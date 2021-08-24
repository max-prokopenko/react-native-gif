import * as React from 'react';

import {
  Dimensions,
  StyleSheet,
  Text,
  TouchableOpacity,
  View,
} from 'react-native';
import GifImage from '@lowkey/react-native-gif';

export default function App() {
  const [hide, setHide] = React.useState(true);

  const [gifs, setGifs] = React.useState([]);

  React.useEffect(() => {
    fetch('https://g.tenor.com/v1/trending')
      .then((response) => response.json())
      .then((json) => {
        console.log(json.results);
        setGifs(json.results);
      })
      .catch((error) => {
        console.error(error);
      });
  }, []);

  return (
    <View style={styles.container}>
      {!hide &&
        gifs.slice(0, 12).map(
          (g: { media: { nanogif: { url: string } }[] }): JSX.Element => (
            <GifImage
              source={{
                uri: g.media[0].nanogif.url,
              }}
              style={styles.box}
              resizeMode={'cover'}
              paused={false}
            />
          )
        )}
      <TouchableOpacity onPress={() => setHide(!hide)}>
        <Text>Show or Hide</Text>
      </TouchableOpacity>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    justifyContent: 'center',
    alignItems: 'center',
    flex: 1,
    flexDirection: 'row',
    width: Dimensions.get('window').width,
    flexWrap: 'wrap',
    padding: 20,
    marginTop: 30,
  },
  box: {
    width: Dimensions.get('window').width * 0.2,
    height: Dimensions.get('window').width * 0.2,
    marginVertical: 20,
    backgroundColor: 'rgba(0,255,0,1)',
    margin: 15,
    borderRadius: 30,
    overflow: 'hidden',
  },
});
