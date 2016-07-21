package net.wg.gui.lobby.vehiclePreview.interfaces {
import net.wg.gui.components.advanced.interfaces.IBackButton;
import net.wg.gui.interfaces.ISoundButtonEx;
import net.wg.gui.interfaces.IUpdatableComponent;

public interface IVehPreviewHeader extends IUpdatableComponent {

    function get backBtn():IBackButton;

    function get closeBtn():ISoundButtonEx;
}
}
