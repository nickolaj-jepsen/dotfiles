import Hyprland from "gi://AstalHyprland";
import { App } from "astal/gtk4";
import { Astal, type Gdk, Gtk } from "astal/gtk4";
import { getHyprlandMonitor } from "../utils/monitors";
import { Workspaces } from "./sections/Workspace";

const AddWorkspaceButton = () => {
	const hypr = Hyprland.get_default();
	return (
		<button
			cssClasses={["add-workspace"]}
			onClicked={() => {
				hypr.dispatch("workspace", "emptynm");
			}}
			valign={Gtk.Align.CENTER}
		>
			<image iconName="list-add" pixelSize={12} />
		</button>
	);
};

export default function SecondaryBar(
	monitor: Gdk.Monitor,
	relation: "top" | "bottom" | "left" | "right",
) {
	const { TOP, LEFT, RIGHT, BOTTOM } = Astal.WindowAnchor;
	const hyprlandMonitor = getHyprlandMonitor(monitor);

	const anchor = {
		top: BOTTOM | LEFT,
		left: TOP | RIGHT,
		right: TOP | LEFT,
		bottom: TOP | LEFT,
	}[relation];

	const cssClasses = {
		top: ["SecondaryBar", "top"],
		left: ["SecondaryBar", "left"],
		right: ["SecondaryBar", "right"],
		bottom: ["SecondaryBar", "bottom"],
	}[relation];

	const alignment = {
		top: Gtk.Align.START,
		left: Gtk.Align.END,
		right: Gtk.Align.START,
		bottom: Gtk.Align.START,
	}[relation];

	return (
		<window
			visible
			cssClasses={cssClasses}
			gdkmonitor={monitor}
			exclusivity={Astal.Exclusivity.EXCLUSIVE}
			anchor={anchor}
			application={App}
			halign={alignment}
			defaultWidth={1} // Ensure the window shinks when content is removed
			defaultHeight={26}
		>
			<box marginStart={2} marginEnd={2} halign={alignment}>
				{relation === "left" ? <AddWorkspaceButton /> : null}
				<Workspaces monitor={hyprlandMonitor} reverse={relation === "left"} />
				{relation !== "left" ? <AddWorkspaceButton /> : null}
			</box>
		</window>
	);
}
