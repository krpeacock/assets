# Motoko Library Template

This is a template for a Motoko library. It contains a simple library, a unit test and e2e test suite. 

This library is set up to be used with [mops](https://mops.one). Be sure to edit `mops.toml`, `dfx.json`, and `package.json` to match your project as needed.

## Usage


## Testing

To run the unit tests, run `npm run test`.

To run the e2e tests, deploy the test canister with `dfx deploy test` and run `npm run test:e2e`.

This project also includes a GitHub Actions workflow that runs the unit tests on every push.
