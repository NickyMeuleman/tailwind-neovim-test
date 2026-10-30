import direct from "./assets/direct.png";
import indirect from "./assets/indirect.png";

export default function App() {
	return (
		<div className="grid gap-8 bg-slate-600 text-center">
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

			<div className="grid gap-4 place-items-center">
				<img src={direct} />
				<img src={indirect} />
			</div>
		</div>
	);
}
