/* eslint-disable react-native/no-inline-styles */
import * as React from 'react';

import {
  Dimensions,
  FlatList,
  StyleSheet,
  Text,
  TouchableOpacity,
  View,
} from 'react-native';
import GifImage from '@lowkey/react-native-gif';

export default function App() {
  const [shown, setShown] = React.useState(false);
  return (
    <View style={{ justifyContent: 'center' }}>
      {shown && (
        <FlatList
          style={styles.container}
          data={[
            0,
            1,
            2,
            3,
            4,
            5,
            6,
            7,
            8,
            9,
            10,
            11,
            12,
            13,
            14,
            15,
            16,
            17,
            18,
            19,
          ]}
          keyExtractor={(item) => item.toString()}
          contentContainerStyle={{
            justifyContent: 'center',
            alignItems: 'center',
            padding: 10,
          }}
          numColumns={3}
          renderItem={() => (
            <GifImage
              source={{
                uri:
                  'https://media.tenor.com/images/4599e80442e2f39f5a030d43f928899b/tenor.gif',
              }}
              style={styles.box}
              resizeMode={'cover'}
            />
          )}
        />
      )}
      <TouchableOpacity
        style={{
          paddingHorizontal: 50,
          paddingVertical: 15,
          borderRadius: 30,
          backgroundColor: 'pink',
          marginTop: 100,
          alignSelf: 'center',
        }}
        onPress={() => setShown(!shown)}
      >
        <Text style={{ color: '#333' }}>Toggle</Text>
      </TouchableOpacity>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    backgroundColor: 'pink',
    marginTop: 50,
    maxHeight: 400,
  },
  box: {
    width: Dimensions.get('window').width * 0.25,
    height: Dimensions.get('window').width * 0.25,
    marginVertical: 20,
    backgroundColor: 'rgba(255,0,0,0.5)',
    margin: 15,
    borderRadius: 30,
    overflow: 'hidden',
  },
});
