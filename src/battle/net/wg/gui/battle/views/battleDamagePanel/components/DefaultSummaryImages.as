package net.wg.gui.battle.views.battleDamagePanel.components {
import flash.display.Shape;
import flash.display.Sprite;

import net.wg.data.constants.AtlasConstants;
import net.wg.infrastructure.interfaces.entity.IDisposable;
import net.wg.infrastructure.managers.IAtlasManager;

public class DefaultSummaryImages extends Sprite implements IDisposable {

    private static const IMG_X_POSITION:int = 6;

    private var _bgShape:Shape = null;

    private var _imgShape:Shape = null;

    private var _atlasManager:IAtlasManager = null;

    public function DefaultSummaryImages() {
        super();
        this._atlasManager = App.atlasMgr;
        this.initializeShapes();
    }

    public function dispose():void {
        this._bgShape = null;
        this._imgShape = null;
        this._atlasManager = null;
    }

    public function loadImages(param1:String, param2:String):void {
        this._atlasManager.drawGraphics(AtlasConstants.BATTLE_ATLAS, param1, this._bgShape.graphics, "");
        this._atlasManager.drawGraphics(AtlasConstants.BATTLE_ATLAS, param2, this._imgShape.graphics, "");
        this._bgShape.x = 0;
        this._imgShape.x = IMG_X_POSITION;
        this._imgShape.y = this._bgShape.height - this._imgShape.height >> 1;
    }

    private function initializeShapes():void {
        this._bgShape = new Shape();
        this.addChild(this._bgShape);
        this._imgShape = new Shape();
        this.addChild(this._imgShape);
    }
}
}
