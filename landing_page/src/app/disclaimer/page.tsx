import Link from "next/link";

export const metadata = {
  title: "Disclaimer | FlowTask",
  description: "Official Disclaimer for the FlowTask productivity application.",
};

export default function DisclaimerPage() {
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
        <h1 className="text-4xl md:text-5xl font-extrabold mb-4 tracking-tight">Disclaimer</h1>
        <p className="text-slate-400 mb-12 font-medium">Last Updated: {lastUpdated}</p>

        <section className="space-y-12">
          <div className="prose prose-invert prose-indigo max-w-none">
            <h2 className="text-2xl font-bold text-white mb-4">1. General Information</h2>
            <p className="text-slate-300 leading-relaxed font-medium">
              The information provided by FlowTask is for general informational and productivity purposes only. All information on the application is provided in good faith; however, we make no representation or warranty of any kind, express or implied, regarding the accuracy, adequacy, validity, reliability, or completeness of any information.
            </p>

            <h2 className="text-2xl font-bold text-white mt-12 mb-4">2. Professional Advice</h2>
            <p className="text-slate-300 leading-relaxed font-medium">
              The application does not contain medical, mental health, or other professional advice. The productivity techniques, such as the Pomodoro timer and focus analytics, are for personal development and organizational reference only.
            </p>

            <h2 className="text-2xl font-bold text-white mt-12 mb-4">3. External Links</h2>
            <p className="text-slate-300 leading-relaxed font-medium">
              The application may contain (or you may be sent through the app) links to other websites or content belonging to or originating from third parties. We do not warrant, endorse, guarantee, or assume responsibility for the accuracy or reliability of any information offered by third-party websites linked through the app.
            </p>

            <h2 className="text-2xl font-bold text-white mt-12 mb-4">4. "As Is" and "As Available"</h2>
            <p className="text-slate-300 leading-relaxed font-medium">
              FlowTask is provided on an "as is" and "as available" basis. We disclaim all warranties, express or implied, including but not limited to the implied warranties of merchantability and fitness for a particular purpose.
            </p>

            <h2 className="text-2xl font-bold text-white mt-12 mb-4">5. Limitation of Liability</h2>
            <p className="text-slate-300 leading-relaxed font-medium">
              Under no circumstance shall we have any liability to you for any loss or damage of any kind incurred as a result of the use of the app or reliance on any information provided on the app. Your use of the app and your reliance on any information on the app is solely at your own risk.
            </p>

            <h2 className="text-2xl font-bold text-white mt-12 mb-4">6. Contact Us</h2>
            <p className="text-slate-300 leading-relaxed font-medium">
              If you have any questions about this Disclaimer, please contact us at:
              <br/>
              <span className="text-indigo-400 font-bold">compliance@flowtaskapp.com</span>
            </p>
          </div>
        </section>
      </main>

      <footer className="max-w-4xl mx-auto px-6 mt-24 pt-8 border-t border-white/5 text-slate-500 text-sm text-center font-medium">
        &copy; 2026 FlowTask. Excellence in every session.
      </footer>
    </div>
  );
}
