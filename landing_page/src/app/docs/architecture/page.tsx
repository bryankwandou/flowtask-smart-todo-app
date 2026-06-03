import Link from "next/link";

export const metadata = {
  title: "System Architecture | FlowTask",
  description: "Technical overview of the FlowTask offline-first architecture.",
};

export default function ArchitecturePage() {
  return (
    <div className="min-h-screen bg-slate-950 text-slate-100 font-sans selection:bg-indigo-500 selection:text-white pb-24">
      <nav className="p-6 max-w-4xl mx-auto flex items-center justify-between border-b border-white/10 mb-12">
        <Link href="/" className="flex items-center gap-2 group">
          <div className="w-8 h-8 rounded-full bg-indigo-600 flex items-center justify-center text-xs font-bold transition-transform group-hover:scale-110">F</div>
          <span className="font-bold text-lg">FlowTask</span>
        </Link>
        <Link href="/" className="text-slate-400 hover:text-white transition">Back to Home</Link>
      </nav>

      <main className="max-w-4xl mx-auto px-6">
        <h1 className="text-4xl md:text-5xl font-extrabold mb-4 tracking-tight">System Architecture</h1>
        <p className="text-slate-400 mb-12">High-Fidelity Offline-First Engineering</p>

        <section className="space-y-12">
          <div className="prose prose-invert prose-indigo max-w-none">
            <h2 className="text-2xl font-bold text-white mb-4">1. Core Philosophy</h2>
            <p className="text-slate-300 leading-relaxed">
              FlowTask is engineered with a **Zero-Cloud** philosophy. Unlike traditional task managers that rely on centralized servers, FlowTask treats the user's device as the primary and only source of truth.
            </p>

            <h2 className="text-2xl font-bold text-white mt-12 mb-4">2. Technical Stack</h2>
            <div className="grid grid-cols-1 md:grid-cols-2 gap-6 mt-8">
              <div className="bg-slate-900/50 border border-white/5 p-6 rounded-2xl">
                <h3 className="text-lg font-semibold text-indigo-400 mb-2">Frontend</h3>
                <p className="text-slate-400 text-sm">Built with Flutter for high-performance cross-platform rendering and Riverpod for reactive state management.</p>
              </div>
              <div className="bg-slate-900/50 border border-white/5 p-6 rounded-2xl">
                <h3 className="text-lg font-semibold text-emerald-400 mb-2">Local Storage</h3>
                <p className="text-slate-400 text-sm">Utilizes an encrypted SQLite (SQFlite) database for relational data and Secure Storage for sensitive preferences.</p>
              </div>
            </div>

            <h2 className="text-2xl font-bold text-white mt-12 mb-4">3. Data Flow</h2>
            <p className="text-slate-300 leading-relaxed">
              Every interaction is processed locally:
            </p>
            <ul className="list-disc pl-6 space-y-3 text-slate-300 mt-4">
              <li><strong>Input:</strong> User creates a task node.</li>
              <li><strong>Persistence:</strong> Node is immediately committed to the local SQLite WAL (Write-Ahead Logging).</li>
              <li><strong>Intelligence:</strong> The on-device analytics engine recalculates the Productivity IQ in real-time.</li>
              <li><strong>Defense:</strong> Local notification schedulers trigger focus-defense protocols without needing an internet connection.</li>
            </ul>

            <h2 className="text-2xl font-bold text-white mt-12 mb-4">4. Security Infrastructure</h2>
            <p className="text-slate-300 leading-relaxed">
              Data at rest is protected via industry-standard encryption. Since no data is transmitted over the wire, the attack surface is reduced to the physical device itself.
            </p>

            <div className="bg-indigo-950/20 border border-indigo-900/30 rounded-2xl p-8 mt-12">
              <h3 className="text-xl font-bold text-white mb-4">Why Local-First?</h3>
              <p className="text-slate-300 leading-relaxed text-sm">
                In a world of constant surveillance, FlowTask provides a sanctuary for your thoughts and goals. By removing the dependency on external servers, we guarantee speed, privacy, and 100% uptime regardless of connectivity.
              </p>
            </div>
          </div>
        </section>
      </main>

      <footer className="max-w-4xl mx-auto px-6 mt-24 pt-8 border-t border-white/5 text-slate-500 text-sm text-center font-medium">
        &copy; 2026 FlowTask. Engineering for Focus.
      </footer>
    </div>
  );
}
