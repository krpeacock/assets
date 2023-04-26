import Assets "../../src/lib";
import A "../../src/Asset";
import B "../../src/Batch";
import C "../../src/Chunk";
import T "../../src/Types";
import U "../../src/Utils";
import Iter "mo:base/Iter";
import Array "mo:base/Array";
import Debug "mo:base/Debug";

shared ({ caller = creator }) actor class () {
  stable var entries : Assets.SerializedEntries = ([], [creator]);
  let assets = Assets.Assets({
    serializedEntries = entries;
  });

  system func preupgrade() {
    entries := assets.entries();
  };

  public shared ({ caller }) func authorize(other : Principal) : async () {
    assets.authorize({
      caller;
      other;
    });
  };

  public query func retrieve(path : Assets.Path) : async Assets.Contents {
    assets.retrieve(path);
  };

  public shared ({ caller }) func store(
    arg : {
      key : Assets.Key;
      content_type : Text;
      content_encoding : Text;
      content : Blob;
      sha256 : ?Blob;
    }
  ) : async () {
    assets.store({
      caller;
      arg;
    });
  };

  public query func list(arg : {}) : async [T.AssetDetails] {
    assets.list(arg);
  };
  public query func get(
    arg : {
      key : T.Key;
      accept_encodings : [Text];
    }
  ) : async ({
    content : Blob;
    content_type : Text;
    content_encoding : Text;
    total_length : Nat;
    sha256 : ?Blob;
  }) {
    assets.get(arg);
  };

  public query func get_chunk(
    arg : {
      key : T.Key;
      content_encoding : Text;
      index : Nat;
      sha256 : ?Blob;
    }
  ) : async ({
    content : Blob;
  }) {
    assets.get_chunk(arg);
  };

  public shared ({ caller }) func create_batch(arg : {}) : async ({
    batch_id : T.BatchId;
  }) {
    assets.create_batch({
      caller;
      arg;
    });
  };

  public shared ({ caller }) func create_chunk(
    arg : {
      batch_id : T.BatchId;
      content : Blob;
    }
  ) : async ({
    chunk_id : T.ChunkId;
  }) {
    assets.create_chunk({
      caller;
      arg;
    });
  };

  public shared ({ caller }) func commit_batch(args : T.CommitBatchArguments) : async () {
    assets.commit_batch({
      caller;
      args;
    });
  };
  public shared ({ caller }) func create_asset(arg : T.CreateAssetArguments) : async () {
    assets.create_asset({
      caller;
      arg;
    });
  };

  public shared ({ caller }) func set_asset_content(arg : T.SetAssetContentArguments) : async () {
    assets.set_asset_content({
      caller;
      arg;
    });
  };

  public shared ({ caller }) func unset_asset_content(args : T.UnsetAssetContentArguments) : async () {
    assets.unset_asset_content({
      caller;
      args;
    });
  };

  public shared ({ caller }) func delete_asset(args : T.DeleteAssetArguments) : async () {
    assets.delete_asset({
      caller;
      args;
    });
  };

  public shared ({ caller }) func clear(args : T.ClearArguments) : async () {
    assets.clear({
      caller;
      args;
    });
  };

  public type StreamingStrategy = {
    #Callback : {
      callback : shared query StreamingCallbackToken -> async StreamingCallbackHttpResponse;
      token : StreamingCallbackToken;
    };
  };

  public type HttpResponse = {
    status_code : Nat16;
    headers : [T.HeaderField];
    body : Blob;

    streaming_strategy : ?StreamingStrategy;
  };
  public type StreamingCallbackToken = {
    key : Text;
    content_encoding : Text;
    index : Nat;
    sha256 : ?Blob;
  };

  public type StreamingCallbackHttpResponse = {
    body : Blob;
    token : ?StreamingCallbackToken;
  };
  public query func http_request(request : T.HttpRequest) : async HttpResponse {
    let response = assets.http_request(request);
    switch (response.streaming_strategy) {
      case (null) {
        return {
          status_code = response.status_code;
          headers = response.headers;
          body = response.body;

          streaming_strategy = null;
        };
      };
      case (? #Callback cb) {
        return {
          status_code = response.status_code;
          headers = response.headers;
          body = response.body;

          streaming_strategy = ? #Callback {
            callback = http_request_streaming_callback;
            token = cb.token;
          };
        };
      };
    };
  };

  public query func http_request_streaming_callback(token : T.StreamingCallbackToken) : async StreamingCallbackHttpResponse {
    assets.http_request_streaming_callback(token);
  };
};
