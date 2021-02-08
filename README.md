# react-native-gif

Performant component for GIFs (significant performance increase and better memory usage on iOS). 

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

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT
