import { App } from "astal/gtk4";
import main from "./src/main";
import css from "./src/main.scss";
// const css = (await import("./src/main.scss")).default;

App.start({
	css,
	main: () => {
		main();
	},
});
