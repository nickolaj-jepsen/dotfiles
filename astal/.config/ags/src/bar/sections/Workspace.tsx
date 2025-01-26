import Hyprland from "gi://AstalHyprland";
import { Variable, bind, register, GObject, property } from "astal";
import type { Subscribable } from "astal/binding";
import { Gdk, Gtk } from "astal/gtk4";

type WorkspacesProps = {
  monitor: Hyprland.Monitor;
  reverse?: boolean;
  selectedWorkspaces?: number[];
};

const hypr = Hyprland.get_default();

const ICON_MAP = {
  terminal: ["kitty"],
  "firefox-custom": ["firefox", "firefox-developer-edition"],
  "chrome-custom": ["google-chrome", "chromium"],
  python: ["jetbrains-pycharm"],
  "vscode-custom": ["Code", "code-oss"],
  "git-symbolic": ["smerge"],
};

function Workspace(workspace: Hyprland.Workspace) {
  const focused = bind(hypr, "focusedWorkspace").as((fw) => fw === workspace);

  const specialIcon = bind(workspace, "clients").as((clients) => {
    const icons = clients
      .map((client) => {
        for (const [name, classes] of Object.entries(ICON_MAP)) {
          if (classes.includes(client.get_class())) {
            return name;
          }
        }
      })
      .filter(Boolean) as string[];

    const count = icons.reduce(
      (acc, cur) => {
        acc[cur] = (acc[cur] || 0) + 1;
        return acc;
      },
      {} as Record<string, number>,
    );

    // Don't return on a tie
    if (
      Object.values(count).filter((x) => x === count[Object.keys(count)[0]])
        .length > 1
    ) {
      return;
    }

    return Object.keys(count)[0];
  });

  return (
    <button
      cssClasses={focused.as((focused) =>
        focused ? ["workspace", "focused"] : ["workspace"],
      )}
      cursor={Gdk.Cursor.new_from_name("pointer", null)}
      onClicked={() => workspace.focus()}
      valign={Gtk.Align.CENTER}
    >
      <stack
        visibleChildName={bind(specialIcon.as(Boolean)).as((special) =>
          special ? "special" : "circle",
        )}
        transitionType={Gtk.StackTransitionType.CROSSFADE}
        transitionDuration={200}
      >
        <image name={"circle"} iconName={"circle-symbolic"} pixelSize={18} />
        <image
          name={"special"}
          iconName={bind(specialIcon).as((icon) => `${icon}-symbolic`)}
          pixelSize={18}
        />
      </stack>
    </button>
  );
}

export function Workspaces({
  reverse,
  monitor,
  selectedWorkspaces,
}: WorkspacesProps) {
  const workspaces = bind(hypr, "workspaces")
    .as((workspaces) => workspaces.filter((ws) => ws.monitor === monitor))
    .as((workspaces) => {
      if (!selectedWorkspaces) {
        return workspaces;
      }

      return selectedWorkspaces.map((id) => {
        return (
          workspaces.find((ws) => ws.get_id() === id) ??
          Hyprland.Workspace.dummy(id, monitor)
        );
      });
    })
    .as((x) => (reverse ? x.reverse() : x));

  return (
    <box cssClasses={["Workspaces"]} valign={Gtk.Align.CENTER} spacing={10}>
      {workspaces.as((ws) => ws.map(Workspace))}
    </box>
  );
}
