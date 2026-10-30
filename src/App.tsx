export default function App() {
	return (
		<div className="text-center">
			<div className="bg-slate-600 p-8 space-y-4">
				<p className="text-green-500">default</p>
				<p className="text-custom-direct">direct</p>
				<p className="text-custom-indirect">indirect :root</p>
			</div>

			<div className="dark bg-slate-600 p-8 space-y-4">
				<p className="text-green-500">default</p>
				<p className="text-custom-direct">direct</p>
				<p className="text-custom-indirect">indirect .dark override</p>
			</div>
		</div>
	);
}
