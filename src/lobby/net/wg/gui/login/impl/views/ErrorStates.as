package net.wg.gui.login.impl.views {
public class ErrorStates {

    public static const NONE:int = 0;

    public static const LOGIN_INVALID:int = 1;

    public static const PASSWORD_INVALID:int = 2;

    public static const LOGIN_PASSWORD_INVALID:int = LOGIN_INVALID | PASSWORD_INVALID;

    public function ErrorStates() {
        super();
    }
}
}
