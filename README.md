# Logchain

The Binance-based crypto monitoring & comparing **Flutter** application.

---

### Features
1. **Trending tokens**. App shows grid of tokens sorted by their daily price change. The most growing tokens appears at the top of the grid.
2. **Favourite tokens**. You can add any token you like to the Favourites.
3. **Search**. Search line at the top can help you find token that you are looking for.
4. **Token info**. Select a token to see detailed information: price, change and volume.
5. **Charts**. The app can draw charts for any token that will display the history of value changes.
6. **Compare tokens**. Once you selected a token, you can compare it with a different one. On the new screen, you'll be able to see side by side compare of those two tokens.
7. **Exchange**. On the same screen, you can see how much one token contains another one.
8. **Night mode**. Switch between light and dark theme without restart.

### API
Our app uses two APIs:
1. https://cryptologos.cc - Cryptocurrency Logo Files.
2. https://coingecko.com - Cryptocurrency Prices by Market Cap.

### Build
1. Get dependencies: `flutter packages pub get`
2. Generate models: `flutter packages pub run build_runner build`
3. Build an Android app: `flutter build apk`

### Tests
You can run tests to ensure everything is working correctly via command: `flutter test`.  
If it is you'll see: `+2: All tests passed!`.


