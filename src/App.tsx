import direct from "./assets/direct.png";
import indirect from "./assets/indirect.png";
import swatch from "./assets/swatch.png";
import BiomeTest from "./BiomeTest";

export default function App() {
	return (
		<div className="grid gap-8 bg-slate-600 text-center">
			{/* tailwind custom properties in-editor visual feedback */}
			<div className="space-y-4">
				<p className="text-green-500">default</p>
				<p className="text-custom-direct">direct</p>
				<p className="text-custom-indirect">indirect :root</p>
			</div>

			<div className="dark space-y-4">
				<p className="text-green-500">default</p>
				<p className="text-custom-direct">direct</p>
				<p className="text-custom-indirect">indirect .dark override</p>
			</div>

			<div className="grid place-items-center gap-4">
				<img src={direct} alt="directly setting a custom color" />
				<img src={indirect} alt="indirectly setting a custom color" />
				<img src={swatch} alt="a colorswatch before classes" />
			</div>

			<BiomeTest />
		</div>
	);
}
