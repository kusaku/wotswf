package net.wg.gui.login.impl {
class ErrorStates {

    static const NONE:int = 0;

    static const LOGIN_INVALID:int = 1;

    static const PASSWORD_INVALID:int = 2;

    static const LOGIN_PASSWORD_INVALID:int = LOGIN_INVALID | PASSWORD_INVALID;

    function ErrorStates() {
        super();
    }
}
}
