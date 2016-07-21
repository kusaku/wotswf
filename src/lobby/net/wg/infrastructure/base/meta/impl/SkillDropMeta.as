package net.wg.infrastructure.base.meta.impl {
import net.wg.data.constants.Errors;
import net.wg.infrastructure.base.AbstractWindowView;

public class SkillDropMeta extends AbstractWindowView {

    public var calcDropSkillsParams:Function;

    public var dropSkills:Function;

    public function SkillDropMeta() {
        super();
    }

    public function calcDropSkillsParamsS(param1:String, param2:Number):Array {
        App.utils.asserter.assertNotNull(this.calcDropSkillsParams, "calcDropSkillsParams" + Errors.CANT_NULL);
        return this.calcDropSkillsParams(param1, param2);
    }

    public function dropSkillsS(param1:Number):void {
        App.utils.asserter.assertNotNull(this.dropSkills, "dropSkills" + Errors.CANT_NULL);
        this.dropSkills(param1);
    }
}
}
