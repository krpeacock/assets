# Motoko Assets Library

This library provides your canister with the logic required to manage assets according to the asset canister interface used by `dfx` and `@dfinity/assets`.

This library is set up to be used with [mops](https://mops.one). Be sure to edit `mops.toml`, `dfx.json`, and `package.json` to match your project as needed.

## Usage

The process to set up your canister is fairly involved. Start copying all the logic in the `test/e2e/test.mo` interface. You will need to import `assets` from 

```
mops add assets
```

## Testing

To run the unit tests, run `npm run test`.

To run the e2e tests, deploy the test canister with `dfx deploy test` and run `npm run test:e2e`.

This project also includes a GitHub Actions workflow that runs the unit tests on every push.
