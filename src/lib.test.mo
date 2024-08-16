import Lib "./lib";
import { test; suite } "mo:test";

suite(
  "test",
  func() {
    test(
      "test",
      func() {
        assert (1 == 1);
      },
    );
  },
);
