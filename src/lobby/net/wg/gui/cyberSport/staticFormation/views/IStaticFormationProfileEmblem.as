package net.wg.gui.cyberSport.staticFormation.views {
import net.wg.gui.cyberSport.staticFormation.interfaces.ITextClickDelegate;
import net.wg.infrastructure.interfaces.ISpriteEx;

public interface IStaticFormationProfileEmblem extends ISpriteEx {

    function updateFormationEmblem(param1:String):void;

    function setTextClickDelegate(param1:ITextClickDelegate):void;
}
}
