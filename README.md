# react-native-gif

Performant component for GIFs (significant performance increase and better memory usage on iOS). 
Caching is a available for iOS.

## v3.x.x

Updating from v2.x.x to v3.x.x might have some breaking changes due to migration from `FLAnimatedImage` to `SDWebImage`. Please create a issue or pull request if you notice any bugs.


## Installation

```sh
npm install @lowkey/react-native-gif
```

or

```sh
yarn add @lowkey/react-native-gif
```

Then 

```sh
npx pod-install
```

## Usage

```js
import GifImage from '@lowkey/react-native-gif';

// ...

<GifImage
  source={{
    uri:
      'https://media.tenor.com/images/1c39f2d94b02d8c9366de265d0fba8a0/tenor.gif',
  }}
  style={{
    width: 100,
    height: 100,
  }}
  resizeMode={'cover'}
/>;
```

## Props
### `style`
ImageResizeMode is an Enum for different image resizing modes, set via the `resizeMode` style property on Image components. For now the values are `contain` and `cover`. Please make an issue if any other (`stretch`, `center`, `repeat`) is needed.

| Type  | Required |
| ---------------- |:----------------:|
| ViewStyle      | false     |

### `resizeMode`
Determines how to resize the image when the frame doesn't match the raw image dimensions. Defaults to `cover` as a standard react-native's Image component.

* `cover`: Scale the image uniformly (maintain the image's aspect ratio) so that both dimensions (width and height) of the image will be equal to or larger than the corresponding dimension of the view (minus padding).
* `contain`: Scale the image uniformly (maintain the image's aspect ratio) so that both dimensions (width and height) of the image will be equal to or less than the corresponding dimension of the view (minus padding).

Please make a Github issue if any other (`stretch`, `center`, `repeat`) is needed.

| Type  | Required |
| ---------------- |:----------------:|
| enum('cover', 'contain')      | false     |

### `source`
The image source (either a remote URL or a local file resource).

| Type  | Required |
| ---------------- |:----------------:|
| ImageSourcePropType      | true     |

### `paused`
Determines if GIF should be paused

 | Type  | Required | Default |
 | ---------------- |:----------------:|:----------------:|
 | boolean      | false     |false     |

### `quality`
Determines quality (pixel size) of the GIF. Value between 0 - 1, where 1 is the best quality.

 | Type  | Required | Default |
 | ---------------- |:----------------:|:----------------:|
 | number      | false     |1     |

 ### `useCPU`
Defaults to false. Which automatically adjust decoding between memory and CPU, by calculating current memory usage.
If set to true, means without any buffer cache each of frames will be decoded and then be freed after rendering. Lowest memory usage, highest CPU usage.

 | Type  | Required | Default |
 | ---------------- |:----------------:|:----------------:|
 | boolean      | false     |false     |

## Feature Requests

Additional image props and methods can be exposed if needed. Please make required feature requests in Github issues.

Additional image props and methods can be exposed if needed. Please make required feature requests in Github issues.

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT
