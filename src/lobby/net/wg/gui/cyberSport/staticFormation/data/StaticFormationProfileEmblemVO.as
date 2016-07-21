package net.wg.gui.cyberSport.staticFormation.data {
import net.wg.data.daapi.base.DAAPIDataClass;

public class StaticFormationProfileEmblemVO extends DAAPIDataClass {

    public var isShowLink:Boolean = false;

    public var editLinkText:String = "";

    public var seasonText:String = "";

    public var formationNameText:String = "";

    public function StaticFormationProfileEmblemVO(param1:Object) {
        super(param1);
    }
}
}
