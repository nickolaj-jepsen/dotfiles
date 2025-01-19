import Wp from "gi://AstalWp";
import { Variable, bind } from "astal";
import type { Subscribable } from "astal/binding";
import type { Gdk } from "astal/gtk4";
import { hasIcon } from "../../utils/gtk";
import { FlowBox } from "../../widgets";
import { connectDropdown } from "./Dropdown";

// class PlaybackEndpoints implements Subscribable {
// 	#wp: Wp.Wp;
// 	#endpoints: { [id: number]: Wp.Endpoint } = {};
// 	#subscriptions = new Set<(v: Wp.Endpoint[]) => void>();
// 	active: Variable<Wp.Endpoint | null> = new Variable(null);
//
// 	#update(endpoint: Wp.Endpoint) {
// 		this.#endpoints[endpoint.id] = endpoint;
// 		this.active.set(
// 			Object.values(this.#endpoints).find((d) => d.isDefault) ?? null,
// 		);
// 		this.#notify();
// 	}
//
// 	#connect(endpoint: Wp.Endpoint) {
// 		endpoint.connect("default-changed", () => {
// 			this.active.set(
// 				Object.values(this.#endpoints).find((d) => d.isDefault) ?? null,
// 			);
// 		});
// 	}
//
// 	constructor(wp: Wp.Wp) {
// 		this.#wp = wp;
//
// 		for (const endpoint of wp.get_endpoints() ?? []) {
// 			this.#update(endpoint);
// 		}
//
// 		wp.connect("endpoint-added", (_, endpoint) => {
// 			this.#update(endpoint);
// 		});
// 	}
//
// 	#notify() {
// 		const result = this.get();
// 		for (const sub of this.#subscriptions) {
// 			sub(result);
// 		}
// 	}
//
// 	get() {
// 		return Object.values(this.#endpoints);
// 	}
//
// 	subscribe(callback: (v: Wp.Endpoint[]) => void) {
// 		this.#subscriptions.add(callback);
// 		return () => this.#subscriptions.delete(callback);
// 	}
// }

type EndpointOptions = {
	fallbackIcon: string;
};

function PlaybackDropdown({ audioDevices }: { audioDevices: Wp.Audio }) {
	const speakers = bind(audioDevices, "speakers");
	const microphones = bind(audioDevices, "microphones");

	const renderEndpoint = (endpoint: Wp.Endpoint, options: EndpointOptions) => {
		return (
			<box spacing={5} vertical>
				<box spacing={5}>
					<button
						label={"active"}
						cssClasses={bind(endpoint, "isDefault").as((x) =>
							x ? ["active"] : [],
						)}
						sensitive={false}
					/>
				</box>
				<box spacing={5}>
					<image
						iconName={bind(endpoint, "icon").as((icon) =>
							hasIcon(icon) ? icon : options.fallbackIcon,
						)}
						pixelSize={12}
					/>
					<label
						label={bind(endpoint, "description")}
						maxWidthChars={20}
						wrap
					/>
				</box>
			</box>
		);
	};

	const renderEndpoints = (
		endpoints: Wp.Endpoint[],
		options: EndpointOptions,
	) => {
		return (
			<FlowBox maxChildrenPerLine={3} homogeneous>
				{endpoints.map((endpoint) => (
					<box spacing={5}>{renderEndpoint(endpoint, options)}</box>
				))}
			</FlowBox>
		);
	};

	return (
		<box spacing={10} vertical>
			<box spacing={5} vertical>
				<label label="Speakers" />
				{bind(speakers).as((speakers) =>
					renderEndpoints(speakers, {
						fallbackIcon: "audio-speakers",
					}),
				)}
			</box>
			<box spacing={5} vertical>
				<label label="Microphones" />
				{bind(microphones).as((microphones) =>
					renderEndpoints(microphones, {
						fallbackIcon: "audio-input-microphone",
					}),
				)}
			</box>
		</box>
	);
}

export function Playback({ monitor }: { monitor: Gdk.Monitor }) {
	const audioDevices = Wp.get_default()?.get_audio?.();
	if (!audioDevices) {
		return <label label="No WirePlumber" visible={false} />;
	}
	// const endpoints = new PlaybackEndpoints(WirePlumber);

	// biome-ignore lint/style/noNonNullAssertion: <explanation>
	const speaker = Wp.get_default()?.audio.defaultSpeaker!;
	const volume = Variable.derive(
		[bind(speaker, "volume"), bind(speaker, "mute")],
		(v, m) => {
			return m ? 0 : v;
		},
	);

	return (
		<box
			cssClasses={["PlaybackControl"]}
			spacing={15}
			onDestroy={() => {
				volume.drop();
			}}
			setup={(self) => {
				connectDropdown(
					self,
					<PlaybackDropdown audioDevices={audioDevices} />,
					monitor,
				);
			}}
		>
			{bind(audioDevices, "default_speaker").as((speaker) => {
				const volume = Variable.derive(
					[bind(speaker, "volume"), bind(speaker, "mute")],
					(v, m) => {
						return m ? 0 : v;
					},
				);

				return (
					<>
						<slider
							cssClasses={["Slider"]}
							inverted
							hexpand
							onChangeValue={({ value }) => {
								speaker.volume = value;
								speaker.mute = false;
							}}
							value={bind(volume)}
						/>
						<box
							spacing={10}
							onButtonPressed={() => {
								speaker.mute = !speaker.mute;
							}}
						>
							<image iconName={bind(speaker, "volumeIcon")} pixelSize={12} />
							<label
								label={bind(volume).as((v) =>
									`${Math.floor(v * 100)}%`.padStart(4, " "),
								)}
							/>
						</box>
					</>
				);
			})}
		</box>
	);
}
