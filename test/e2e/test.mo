import Assets "../../src/lib";
import Iter "mo:base/Iter";
import Array "mo:base/Array";

shared ({ caller = creator }) actor class () {
  stable var authorized : [Principal] = [creator];
  stable var stableAssets : [(Assets.Key, Assets.StableAsset)] = [];
  let assets = Assets.Assets({authorized; stableAssets; setAuthorized = func (p : [Principal]) { authorized := p }; setStableAssets = func (a : [(Assets.Key, Assets.StableAsset)]) { stableAssets := a }});

  public func authorize = assets.authorize();

  public func example = Assets.example;

  system func preupgrade() {
    stableAssets := assets.entries();
  };

  system func postupgrade() {
    stableAssets := [];
  };

};
