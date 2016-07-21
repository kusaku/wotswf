package net.wg.infrastructure.managers.impl {
import net.wg.data.Aliases;

public class LoaderManagerLobby extends LoaderManagerBase {

    private var firstTimeLoadLobby:Boolean = false;

    public function LoaderManagerLobby() {
        super();
    }

    override public function as_loadView(param1:Object, param2:String, param3:String, param4:String = null):void {
        if (param2 == Aliases.LOBBY && !this.firstTimeLoadLobby) {
            loadLibraries(Vector.<String>(["toolTips.swf", "popovers.swf", "IconLibrary.swf"]));
            this.firstTimeLoadLobby = true;
        }
        super.as_loadView(param1, param2, param3, param4);
    }
}
}
