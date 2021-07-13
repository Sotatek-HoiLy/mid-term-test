pragma solidity ^0.8.0;

contract Action {
    bool private _paused;

    constructor() {
        _paused = false;
    }

    function isPaused() public view virtual returns (bool) {
        return _paused;
    }

    function setPause() internal {
        _paused = true;
    }

    function setUnpause() internal {
        _paused = false;
    }
}
