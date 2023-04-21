import Lib "../../src/lib";

actor {
  public query func echo (x: Text): async Text {
  Lib.echo(x);
  }
}
