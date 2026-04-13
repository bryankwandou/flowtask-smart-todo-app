import Link from "next/link";

export const metadata = {
  title: "Terms of Service | FlowTask",
  description: "Official Terms of Service for the FlowTask productivity application.",
};

export default function TermsPage() {
  const lastUpdated = "April 11, 2026";

  return (
    <div className="min-h-screen bg-slate-950 text-slate-100 font-sans selection:bg-indigo-500 selection:text-white pb-24">
      {/* Simple Navigation */}
      <nav className="p-6 max-w-4xl mx-auto flex items-center justify-between border-b border-white/10 mb-12 relative z-10">
        <Link href="/" className="flex items-center gap-2 group">
          <div className="w-8 h-8 rounded-full bg-indigo-600 flex items-center justify-center text-xs font-bold transition-transform group-hover:scale-110">F</div>
          <span className="font-bold text-lg">FlowTask</span>
        </Link>
        <Link href="/" className="text-slate-400 hover:text-white transition">Back to Home</Link>
      </nav>

      <main className="max-w-4xl mx-auto px-6 relative z-10">
        <h1 className="text-4xl md:text-5xl font-extrabold mb-4 tracking-tight">Terms of Service</h1>
        <p className="text-slate-400 mb-12 font-medium">Last Updated: {lastUpdated}</p>

        <section className="space-y-12">
          <div className="prose prose-invert prose-indigo max-w-none">
            <h2 className="text-2xl font-bold text-white mb-4">1. Acceptance of Terms</h2>
            <p className="text-slate-300 leading-relaxed font-medium">
              By accessing and using FlowTask, you agree to be bound by these Terms of Service. If you do not agree to these terms, please do not use our application.
            </p>

            <h2 className="text-2xl font-bold text-white mt-12 mb-4">2. Description of Service</h2>
            <p className="text-slate-300 leading-relaxed font-medium">
              FlowTask provides a mobile application designed for task management, focus timing, and productivity analytics. We reserve the right to modify or discontinue the service at any time without notice.
            </p>

            <h2 className="text-2xl font-bold text-white mt-12 mb-4">3. User Accounts</h2>
            <p className="text-slate-300 leading-relaxed font-medium">
              You are responsible for maintaining the confidentiality of your account information. You must notify us immediately of any unauthorized use of your account.
            </p>

            <h2 className="text-2xl font-bold text-white mt-12 mb-4">4. Prohibited Activities</h2>
            <ul className="list-disc pl-6 space-y-2 text-slate-300 mt-4 font-medium">
              <li>Attempting to interfere with the proper functioning of the service.</li>
              <li>Using the service for any illegal or unauthorized purpose.</li>
              <li>Attempting to bypass any security measures we have implemented.</li>
            </ul>

            <h2 className="text-2xl font-bold text-white mt-12 mb-4">5. Intellectual Property</h2>
            <p className="text-slate-300 leading-relaxed font-medium">
              FlowTask and its original content, features, and functionality are owned by its creators and are protected by international copyright and trademark laws.
            </p>

            <h2 className="text-2xl font-bold text-white mt-12 mb-4">6. Limitation of Liability</h2>
            <p className="text-slate-300 leading-relaxed font-medium">
              In no event shall FlowTask be liable for any indirect, incidental, special, consequential, or punitive damages arising out of your use of the service.
            </p>

            <h2 className="text-2xl font-bold text-white mt-12 mb-4">7. Governing Law</h2>
            <p className="text-slate-300 leading-relaxed font-medium">
              These Terms shall be governed by and construed in accordance with the laws of your jurisdiction, without regard to its conflict of law provisions.
            </p>

            <h2 className="text-2xl font-bold text-white mt-12 mb-4">8. Contact Us</h2>
            <p className="text-slate-300 leading-relaxed font-medium">
              If you have any questions about these Terms, please contact us at:
              <br/>
              <span className="text-indigo-400 font-bold">legal@flowtaskapp.com</span>
            </p>
          </div>
        </section>
      </main>

      <footer className="max-w-4xl mx-auto px-6 mt-24 pt-8 border-t border-white/5 text-slate-500 text-sm text-center font-medium">
        &copy; 2026 FlowTask. Built for high performance.
      </footer>
    </div>
  );
}
