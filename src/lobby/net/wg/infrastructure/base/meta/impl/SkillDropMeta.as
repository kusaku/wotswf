package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.gui.lobby.tankman.SkillDropModel;
import net.wg.infrastructure.base.AbstractWindowView;
import net.wg.infrastructure.exceptions.AbstractException;

public class SkillDropMeta extends AbstractWindowView {

    public var calcDropSkillsParams:Function;

    public var dropSkills:Function;

    private var _skillDropModel:SkillDropModel;

    public function SkillDropMeta() {
        super();
    }

    override protected function onDispose():void {
        if (this._skillDropModel) {
            this._skillDropModel.dispose();
            this._skillDropModel = null;
        }
        super.onDispose();
    }

    public function calcDropSkillsParamsS(param1:String, param2:Number):Array {
        App.utils.asserter.assertNotNull(this.calcDropSkillsParams, "calcDropSkillsParams" + Errors.CANT_NULL);
        return this.calcDropSkillsParams(param1, param2);
    }

    public function dropSkillsS(param1:Number):void {
        App.utils.asserter.assertNotNull(this.dropSkills, "dropSkills" + Errors.CANT_NULL);
        this.dropSkills(param1);
    }

    public final function as_setData(param1:Object):void {
        var _loc2_:SkillDropModel = this._skillDropModel;
        this._skillDropModel = new SkillDropModel(param1);
        this.setData(this._skillDropModel);
        if (_loc2_) {
            _loc2_.dispose();
        }
    }

    protected function setData(param1:SkillDropModel):void {
        var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
        DebugUtils.LOG_ERROR(_loc2_);
        throw new AbstractException(_loc2_);
    }
}
}
