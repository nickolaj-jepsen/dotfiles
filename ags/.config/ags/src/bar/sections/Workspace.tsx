import Hyprland from "gi://AstalHyprland";
import { Variable, bind } from "astal";
import type { Subscribable } from "astal/binding";
import { Gdk, Gtk } from "astal/gtk4";

type WorkspacesProps = {
	monitor: Hyprland.Monitor;
	reverse?: boolean;
	selectedWorkspaces?: number[];
};

const hypr = Hyprland.get_default();

function Workspace(workspace: Hyprland.Workspace) {
	return (
		<button
			cssClasses={[
				"workspace",
				workspace === hypr.get_focused_workspace() ? "focused" : "",
				workspace.get_clients().length === 0 ? "disabled" : "",
			]}
			cursor={Gdk.Cursor.new_from_name("pointer", null)}
			onClicked={() => workspace.focus()}
			valign={Gtk.Align.CENTER}
		/>
	);
}

// 	constructor(monitor: Hyprland.Monitor, selectedWorkspaces?: number[]) {
// 		// load initial data Hyprland.Workspace.dummy(id, monitor)
// 		this.#workspaces = selectedWorkspaces ? Array.from(selectedWorkspaces).reduce((acc, id) => {
// 			const workspace = new Map(
// 			hypr
// 				.get_workspaces()
// 				.filter((ws) => ws.monitor === monitor)
// 				.map((ws) => [ws.get_id(), Workspace(ws)]),
// 		);
// 		if (selectedWorkspaces) {
// 			for (const id of selectedWorkspaces) {
// 				if (!this.#workspaces.has(id)) {
// 					this.#workspaces.set(id, Workspace(Hyprland.Workspace.dummy(id, monitor)));
// 				}
// 			}
// 		}

class WorkspaceMap implements Subscribable {
	#subscriptions = new Set<(v: Gtk.Widget[]) => void>();
	#workspaces = new Map<number, Gtk.Widget>();
	#focusedWorkspace: number | null = null;

	#update(workspace: Hyprland.Workspace) {
		this.#workspaces.set(workspace.get_id(), Workspace(workspace));
		this.#notify();
	}

	constructor(monitor: Hyprland.Monitor, selectedWorkspaces?: number[]) {
		console.log("all workspaces", hypr.get_workspaces());
		// load initial data
		this.#workspaces = new Map(
			hypr
				.get_workspaces()
				.filter((ws) => ws.monitor === monitor)
				.map((ws) => [ws.get_id(), Workspace(ws)]),
		);
		console.log(this.#workspaces);

		if (selectedWorkspaces) {
			for (const id of selectedWorkspaces) {
				if (!this.#workspaces.has(id)) {
					this.#workspaces.set(
						id,
						Workspace(Hyprland.Workspace.dummy(id, monitor)),
					);
				}
			}
		}

		bind(hypr, "focusedWorkspace").subscribe((focusedWorkspace) => {
			// Clean up previous focused workspace
			if (
				this.#focusedWorkspace &&
				this.#focusedWorkspace !== focusedWorkspace.get_id()
			) {
				const workspace = hypr.get_workspace(this.#focusedWorkspace);
				this.#update(workspace);
			}

			if (focusedWorkspace.monitor === monitor) {
				this.#update(focusedWorkspace);
				this.#focusedWorkspace = focusedWorkspace.get_id();
			} else {
				this.#focusedWorkspace = null;
			}
		});

		bind(hypr, "clients").subscribe((clients) => {
			for (const client of clients) {
				if (client.workspace && client.workspace.monitor === monitor) {
					this.#update(client.workspace);
				}
			}
		});

		hypr.connect("workspace-added", (_, workspace) => {
			if (workspace.monitor === monitor) {
				this.#update(workspace);
			}
		});

		hypr.connect("workspace-removed", (_, workspace) => {
			this.#workspaces.delete(workspace);
			if (workspace === this.#focusedWorkspace) {
				this.#focusedWorkspace = null;
			}
			this.#notify();
		});
	}

	#notify() {
		const workspaces = this.get();
		for (const subscription of this.#subscriptions) {
			subscription(workspaces);
		}
	}

	get() {
		return Array.from(this.#workspaces.entries())
			.sort(([a], [b]) => a - b)
			.map(([, workspace]) => workspace);
	}

	subscribe(callback: (value: Gtk.Widget[]) => void) {
		this.#subscriptions.add(callback);
		return () => this.#subscriptions.delete(callback);
	}
}

export function Workspaces({
	reverse,
	monitor,
	selectedWorkspaces,
}: WorkspacesProps) {
	let workspaces = bind(new WorkspaceMap(monitor, selectedWorkspaces));
	if (reverse) {
		workspaces = workspaces.as((workspaces) => workspaces.reverse());
	}

	return (
		<box cssClasses={["Workspaces"]} valign={Gtk.Align.CENTER}>
			{workspaces}
		</box>
	);
}
