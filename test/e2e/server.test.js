import { expect, test, describe, afterAll } from "vitest";
import fetch from "isomorphic-fetch";
import Ids from "../../.dfx/local/canister_ids.json";
import ic from "ic0";

const HOST = `http://localhost:4943`;
const canister_id = Ids["test"]["local"];

test("should handle a call", async () => {
  const res = await ic.local(canister_id).call("echo", "hello");

  expect(res).toBe("hello");
});
