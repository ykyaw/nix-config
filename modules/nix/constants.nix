{ lib, ... }:
{
  options = {
    username = lib.mkOption {
      type = lib.types.singleLineStr;
      readOnly = true;
      default = "thatoe";
    };
    fullName = lib.mkOption {
      type = lib.types.singleLineStr;
      readOnly = true;
      default = "Ye Thatoe Kyaw";
    };
    monospace = lib.mkOption {
      type = lib.types.singleLineStr;
      readOnly = true;
      default = "Berkeley Mono";
    };
  };
}
